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
terminate_event = threading.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')


def data_receiver():
    Receive_Data.begin(raw_data_queue, terminate_event)


async def data_translator():
    translator = CAN_Translate.CANTranslator(db)
    while not terminate_event.is_set():
        try:
            raw_data = raw_data_queue.get(timeout=0.1)
            await translator.data_handler(raw_data, json_file_name, translated_data_queue)
        except queue.Empty:
            await asyncio.sleep(0.01)  # Prevent tight loop


async def data_sender():
    await Send_Direct.begin(translated_data_queue, terminate_event)


async def main():
    # Start the data receiver in a separate thread
    receiver_thread = threading.Thread(target=data_receiver, daemon=True)
    receiver_thread.start()

    # Start the data translator and sender as asyncio tasks
    translator_task = asyncio.create_task(data_translator())
    sender_task = asyncio.create_task(data_sender())

    # Wait for the translator and sender tasks to complete
    await asyncio.gather(translator_task, sender_task)

if __name__ == '__main__':
    latency_file = open('latency_file.txt', 'w')
    json_file_name = 'output.json'

    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        terminate_event.set()
    finally:
        latency_file.close()
        print("Application terminated")
