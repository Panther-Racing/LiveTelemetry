import asyncio
import websockets
import json

connected_clients = set()
BATCH_SIZE = 10

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
        print(f'Sending {data}')
        await asyncio.gather(*[ws.send(data) for ws in connected_clients if ws.open])


async def begin(translated_data, terminate_event):
    print('Sender begun')
    async with websockets.serve(handler, "localhost", 8080):
        print('Started WebSocket')

        while not terminate_event.is_set():

            try:
                data = await asyncio.wait_for(translated_data.get(), timeout=0.1)
                # print(f"Sending data: {data}")
                await send_updates(data)

            except asyncio.TimeoutError:
                continue
            # if translated_data.qsize() >= BATCH_SIZE:
            #     batch = []
            #     for _ in range(BATCH_SIZE):
            #         item = await translated_data.get()
            #         batch.append(item)
            #         translated_data.task_done()
            #     combined = {i: item for i, item in enumerate(batch)}
            #     combined_json = json.dumps(combined)
            #     try:
            #         await send_updates(combined_json)
            #         # await asyncio.sleep(1)              # Limit rate data is sent to site to prevent crashing
            #     except asyncio.TimeoutError:
            #         continue
        print("Server stopping...")
