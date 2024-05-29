import asyncio
import websockets
import json

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


async def send_updates():
    while True:
        data = json.dumps({'timestamp': asyncio.get_event_loop().time()})
        await asyncio.wait([ws.send(data) for ws in connected_clients])
        await asyncio.sleep(1)

start_server = websockets.serve(handler, "localhost", 8080)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().create_task(send_updates())
asyncio.get_event_loop().run_forever()
