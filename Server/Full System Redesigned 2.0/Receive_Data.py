import socket
import asyncio

async def begin(raw_data_queue, terminate_event):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind((socket.gethostbyname(socket.gethostname()), 20001))
    s.settimeout(1)
    print(f'Listening at {socket.gethostbyname(socket.gethostname())} on port 20001')

    # loop = asyncio.get_running_loop()

    while not terminate_event.is_set():
        try:
            # data, addr = await loop.run_in_executor(None, s.recvfrom, 1024)
            data = s.recvfrom(1024)
            print(f'Received {data}')
            await raw_data_queue.put(data)
            print(f'Raw data contains {raw_data_queue.qsize()} items')
        except socket.timeout:
            continue
        except Exception as e:
            print(f"Error: { e }")
