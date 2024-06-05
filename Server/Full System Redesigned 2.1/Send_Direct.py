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
        combined_data = json.dumps(data)  # Combine batched data into one JSON file
        await asyncio.gather(*[ws.send(combined_data) for ws in connected_clients if ws.open])


async def begin(translated_data, terminate_event):
    print('Sender begun')
    async with websockets.serve(handler, "localhost", 8080):
        print('Started WebSocket')
        while not terminate_event.is_set():
            try:
                batch = await asyncio.wait_for(translated_data.get(), timeout=0.1)
                await send_updates(batch)
            except asyncio.TimeoutError:
                continue
        print("Server stopping...")
