import asyncio
import cantools
import CAN_Translate
import Receive_Data
import Send_Direct

# Set maximum queue size
MAX_QUEUE_SIZE = 500

# Queues for communication between tasks
raw_data_queue = asyncio.Queue(maxsize=MAX_QUEUE_SIZE)
translated_data_queue = asyncio.Queue(maxsize=MAX_QUEUE_SIZE)
terminate_event = asyncio.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')

async def data_receiver():
    print("Starting data receiver...")
    s = await Receive_Data.begin()
    print("Data receiver started.")
    while not terminate_event.is_set():
        print('Waiting for data')
        data = await Receive_Data.listen_for_data(s, terminate_event)
        print(f'Received {data}')
        if raw_data_queue.full():
            print("Raw data queue is full. Discarding data.")
            pass
        else:
            try:
                raw_data_queue.put_nowait(data)
            except asyncio.QueueFull:
                # print("Raw data queue is full. Discarding data.")
                pass
    print('Closing Socket')
    s.close()

async def data_translator():
    print("Starting data translator...")
    translator = CAN_Translate.CANTranslator(db)
    data = dict()
    index = 0
    buffer_amt = 10  # Number of messages to accumulate before sending
    while not terminate_event.is_set():
        if not raw_data_queue.empty():
            print('Processing data')
            raw_data = await raw_data_queue.get()
            data.update(await translator.data_handler(raw_data))
            if index >= buffer_amt:
                await translated_data_queue.put(data)
                index = 0
            index += 1

    print("Data translator stopped.")


async def data_sender():
    print("Starting data sender...")
    await Send_Direct.begin(translated_data_queue, terminate_event)
    print("Data sender stopped.")


async def main():
    print("Starting main function...")
    receiver_task = asyncio.create_task(data_receiver())
    # translator_task = asyncio.create_task(data_translator())
    # sender_task = asyncio.create_task(data_sender())
    await asyncio.gather(receiver_task)
    print("Main function completed.")


async def run_with_restarts():
    """Run the main thread and restart it every 30 minutes."""
    while True:
        print("Starting the main application...")
        # Run the main app in a separate coroutine
        main_task = asyncio.create_task(main())

        # Wait for 30 minutes before restarting
        await asyncio.sleep(1800)  # 1800 seconds = 30 minutes

        # If we reach here, it means the restart timer has expired
        print("Scheduled restart after 30 minutes.")
        terminate_event.set()  # Cancel the current running app
        try:
            await main_task  # Await task to handle any finalizations or exceptions
        except asyncio.CancelledError:
            print("The main application was successfully cancelled for restart.")

        print("Restarting the application now...")


if __name__ == '__main__':
    try:
        asyncio.run(run_with_restarts())
    except KeyboardInterrupt:
        terminate_event.set()
        print("Terminating...")
