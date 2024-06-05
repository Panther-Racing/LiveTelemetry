import socket
import asyncio

async def begin():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind((socket.gethostbyname(socket.gethostname()), 20001))
    s.settimeout(1)
    print(f'Listening at {socket.gethostbyname(socket.gethostname())} on port 20001')
    return s


async def listen_for_data(s, terminate_event):
    loop = asyncio.get_running_loop()

    while not terminate_event.is_set():
        try:
            data = await loop.run_in_executor(None, s.recvfrom, 1024)
            print(f'Received {data}')
            return data[0]
        except socket.timeout:
            continue
        except Exception as e:
            print(f"Error: {e}")
            return None
