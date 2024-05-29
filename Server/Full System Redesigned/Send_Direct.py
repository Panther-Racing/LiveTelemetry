import asyncio
import websockets
import json
import time

connected_clients = set()


async def handler(websocket, path):
    # Register client
    connected_clients.add(websocket)
    try:
        async for message in websocket:
            # Handle incoming messages if needed
            print(f"Received message: {message}")
    finally:
        # Unregister client
        connected_clients.remove(websocket)


async def send_updates(data):
    while True:
        if connected_clients:  # Only send updates if there are connected clients
            await asyncio.gather(*[ws.send(data) for ws in connected_clients])
        await asyncio.sleep(1)  # Adjust the interval as needed for your use case


def begin(translated_data, terminate_event):
    start_server = websockets.serve(handler, "localhost", 8080)

    asyncio.get_event_loop().run_until_complete(start_server)

    print('Started Websocket')

    while not terminate_event.isSet():
        send_updates({'Timestamp': 1})
        # if translated_data.qsize() > 0:
        #     send_updates(translated_data.get())
