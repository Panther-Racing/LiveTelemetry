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
        print(f"Sending updates to {len(connected_clients)} clients")
        await asyncio.gather(*[ws.send(data) for ws in connected_clients if ws.open])

async def begin(translated_data, terminate_event):
    print('Sender begun')
    async with websockets.serve(handler, "localhost", 8080):
        print('Started WebSocket')

        while not terminate_event.is_set():
            if not translated_data.empty():
                data = await translated_data.get()
                print(f"Sending data: {data}")
                await send_updates(data)
                await asyncio.sleep(0.1)

        print("Server stopping...")
