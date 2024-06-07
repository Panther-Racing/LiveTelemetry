import asyncio
import cantools
import CAN_Translate
import Receive_Data
import Send_Direct

# Set maximum queue size
MAX_QUEUE_SIZE = 100000

# Queues for communication between tasks
raw_data_queue = asyncio.Queue(maxsize=MAX_QUEUE_SIZE)
translated_data_queue = asyncio.Queue()
terminate_event = asyncio.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')

async def data_receiver():
    print("Starting data receiver...")
    s = await Receive_Data.begin()
    print("Data receiver started.")
    try:
        while not terminate_event.is_set():
            data = await Receive_Data.listen_for_data(s, terminate_event)
            if raw_data_queue.full():
                pass
            else:
                try:
                    raw_data_queue.put_nowait(data)
                except asyncio.QueueFull:
                    pass
            await asyncio.sleep(0.01)
    except asyncio.CancelledError:
        print("Data receiver task cancelled.")
    finally:
        print('Closing Socket')
        s.close()

async def data_processor(can_translator):
    while not terminate_event.is_set():
        data = await raw_data_queue.get()
        await can_translator.data_handler(data, translated_data_queue, terminate_event)
        raw_data_queue.task_done()

async def data_sender():
    print("Starting data sender...")
    try:
        await Send_Direct.begin(translated_data_queue, terminate_event)
    except asyncio.CancelledError:
        print("Data sender task cancelled.")
    print("Data sender stopped.")

async def main():
    print("Starting main function...")

    can_translator = CAN_Translate.CANTranslator(db)

    # Create multiple data processor tasks
    processor_tasks = [asyncio.create_task(data_processor(can_translator)) for _ in range(1)]

    receiver_task = asyncio.create_task(data_receiver())
    sender_task = asyncio.create_task(Send_Direct.begin(translated_data_queue, terminate_event))

    await asyncio.gather(receiver_task, sender_task, *processor_tasks)
    print("Main function completed.")

async def run_with_restarts():
    """Run the main thread and restart it every 30 minutes or when terminate_event is set."""
    while True:
        print("Starting the main application...")
        terminate_event.clear()
        # Run the main app in a separate coroutine
        main_task = asyncio.create_task(main())

        # Wait for 30 minutes or until terminate_event is set
        try:
            await asyncio.wait_for(terminate_event.wait(), timeout=1800)
        except asyncio.TimeoutError:
            print("Scheduled restart after 30 minutes.")

        # If we reach here, it means the terminate event is set or the timer expired
        terminate_event.set()  # Ensure the termination event is set

        # Cancel the main task and wait for it to finish
        main_task.cancel()
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
