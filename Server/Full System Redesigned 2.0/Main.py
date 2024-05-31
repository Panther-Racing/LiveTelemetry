import threading
import asyncio
import queue
import cantools
import CAN_Translate
import Receive_Data
import Send_Direct
import socket

# Queues for communication between threads
raw_data_queue = asyncio.Queue()
translated_data_queue = asyncio.Queue()
terminate_event = asyncio.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')


async def data_receiver():
    print("Starting data receiver...")
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind((socket.gethostbyname(socket.gethostname()), 20001))
    s.settimeout(1)
    print(f'Listening at {socket.gethostbyname(socket.gethostname())} on port 20001')

    loop = asyncio.get_running_loop()
    while not terminate_event.is_set():
        try:
            data, addr = await loop.run_in_executor(None, s.recvfrom, 1024)
            print(f'Received {data}')
            await raw_data_queue.put(data)
        except socket.timeout:
            continue
        except Exception as e:
            print(f"Error: {e}")
    print("Data receiver stopped.")


async def data_translator():
    print("Starting data translator...")
    translator = CAN_Translate.CANTranslator(db)
    while not terminate_event.is_set():
        if not raw_data_queue.empty():
            raw_data = await raw_data_queue.get()
            print(f"Translating raw data: {raw_data}")
            translator.data_handler(raw_data, 'output.json', translated_data_queue)
    print("Data translator stopped.")


async def data_sender():
    print("Starting data sender...")
    await Send_Direct.begin(translated_data_queue, terminate_event)
    print("Data sender stopped.")


async def main():
    print("Starting main function...")
    receiver_task = asyncio.create_task(data_receiver())
    translator_task = asyncio.create_task(data_translator())
    sender_task = asyncio.create_task(data_sender())

    await asyncio.gather(receiver_task, translator_task, sender_task)
    print("Main function completed.")

if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        terminate_event.set()
        print("Terminating...")
