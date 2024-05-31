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
    # Only send updates if there are connected clients
    if connected_clients:
        await asyncio.gather(*[ws.send(data) for ws in connected_clients])


def begin(translated_data, terminate_event):
    # Create a new event loop
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)

    start_server = websockets.serve(handler, "localhost", 8080)

    loop.run_until_complete(start_server)

    print('Started Websocket')

    async def periodic_send():
        while not terminate_event.isSet():
            if translated_data.qsize() > 0:
                print('queue Received data')
                data = translated_data.get()  # or translated_data.get() if you are using a queue
                await send_updates(data)
                print(f'websocket sent {data}')
                # Delay so node red isn't overloaded with messages
                await asyncio.sleep(.1)

    loop.run_until_complete(periodic_send())
