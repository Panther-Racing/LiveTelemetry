import threading
import asyncio
import queue
import cantools
import CAN_Translate
import Receive_Data
import Send_Direct

# Queues for communication between threads
raw_data_queue = queue.Queue()
translated_data_queue = asyncio.Queue()
terminate_event = asyncio.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')


def data_receiver():
    print("Starting data receiver...")
    Receive_Data.begin(raw_data_queue, terminate_event)
    print("Data receiver started.")


async def data_translator():
    print("Starting data translator...")
    translator = CAN_Translate.CANTranslator(db)
    while not terminate_event.is_set():
        if not raw_data_queue.empty():
            raw_data = raw_data_queue.get()
            print(f"Translating raw data: {raw_data}")
            translator.data_handler(raw_data, 'output.json', translated_data_queue)
    print("Data translator stopped.")


async def data_sender():
    print("Starting data sender...")
    await Send_Direct.begin(translated_data_queue, terminate_event)
    print("Data sender stopped.")


async def main():
    print("Starting main function...")

    loop = asyncio.get_running_loop()

    # Run the data receiver in a separate thread using run_in_executor
    receiver_future = loop.run_in_executor(None, data_receiver)

    # Start translator and sender tasks
    translator_task = asyncio.create_task(data_translator())
    sender_task = asyncio.create_task(data_sender())

    # Wait for all tasks to complete
    await asyncio.gather(receiver_future, translator_task, sender_task)
    print("Main function completed.")


if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        terminate_event.set()
        print("Terminating...")
