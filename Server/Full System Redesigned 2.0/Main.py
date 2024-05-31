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
    Receive_Data.begin(raw_data_queue, terminate_event)


async def data_translator():
    translator = CAN_Translate.CANTranslator(db)
    while not terminate_event.is_set():
        if not raw_data_queue.empty():
            raw_data = raw_data_queue.get()
            translator.data_handler(raw_data, 'output.json', translated_data_queue)


async def data_sender():
    await Send_Direct.begin(translated_data_queue, terminate_event)


async def main():
    receiver_thread = asyncio.create_task(data_receiver())

    translator_task = asyncio.create_task(data_translator())
    sender_task = asyncio.create_task(data_sender())

    await asyncio.gather(translator_task, sender_task, receiver_thread)

if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        terminate_event.set()
