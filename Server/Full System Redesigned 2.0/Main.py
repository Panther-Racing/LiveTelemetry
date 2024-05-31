import asyncio
import cantools
import CAN_Translate
import Receive_Data
import Send_Direct

# Queues for communication between tasks
raw_data_queue = asyncio.Queue()
translated_data_queue = asyncio.Queue()
terminate_event = asyncio.Event()

# Load the CAN database
db = cantools.database.load_file('DBCS/Combined.dbc')

async def data_receiver():
    print("Starting data receiver...")
    await Receive_Data.begin(raw_data_queue, terminate_event)
    print("Data receiver started.")

async def data_translator():
    print("Starting data translator...")
    translator = CAN_Translate.CANTranslator(db)
    while not terminate_event.is_set():
        if not raw_data_queue.empty():
            raw_data = await raw_data_queue.get()
            print(f"Translating raw data: {raw_data}")
            await translator.data_handler(raw_data, 'output.json', translated_data_queue)
        await asyncio.sleep(0.1)
    print("Data translator stopped.")

async def data_sender():
    print("Starting data sender...")
    await Send_Direct.begin(translated_data_queue, terminate_event)
    print("Data sender stopped.")

async def main():
    print("Starting main function...")

    # Start the receiver, translator, and sender tasks
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
