import asyncio
import websockets
import json

connected_clients = set()

async def handler(websocket, path):
    connected_clients.add(websocket)
    try:
        async for message in websocket:
            print(f"Received message: {message}")
    except (websockets.exceptions.ConnectionClosedError, websockets.exceptions.ConnectionClosedOK, ConnectionAbortedError) as e:
        print(f"Connection closed: {websocket.remote_address} with error: {e}")
    finally:
        connected_clients.remove(websocket)

async def send_updates(data):
    if connected_clients:
        await asyncio.gather(*[ws.send(data) for ws in connected_clients])

async def begin(translated_data, terminate_event):
    async with websockets.serve(handler, "localhost", 8080):
        print('Started Websocket')

        while not terminate_event.is_set():
            if translated_data.qsize() > 0:
                data = translated_data.get()
                await send_updates(data)
                print(f'Sent {data}')
                await asyncio.sleep(0.1)

if __name__ == '__main__':
    terminate_event = asyncio.Event()

    translated_data_queue = asyncio.Queue()

    asyncio.run(begin(translated_data_queue, terminate_event))
