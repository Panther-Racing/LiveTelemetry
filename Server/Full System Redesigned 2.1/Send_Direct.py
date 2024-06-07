import asyncio
import websockets
import json

connected_clients = set()
BATCH_SIZE = 100000

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
        # print(f'Sending {data}')
        await asyncio.gather(*[ws.send(data) for ws in connected_clients if ws.open])

async def begin(translated_data, terminate_event):
    print('Sender begun')
    async with websockets.serve(handler, "localhost", 8080):
        print('Started WebSocket')

        while not terminate_event.is_set():
            await asyncio.sleep(0.1)
            # print(f'Translated Data Queue Size: {translated_data.qsize()}')
            if translated_data.qsize() >= BATCH_SIZE:
                combined = {}
                for _ in range(BATCH_SIZE):
                    item = await translated_data.get()
                    combined.update(json.loads(item))
                    translated_data.task_done()
                combined_json = json.dumps(combined)
                try:
                    pass
                    await send_updates(combined_json)
                    # await asyncio.sleep(1)              # Limit rate data is sent to site to prevent crashing
                except asyncio.TimeoutError:
                    continue
        print("Server stopping...")
