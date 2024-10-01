import asyncio
import websockets 
import json
import time
from CAN_Translate import json_dict
connected_clients = set()
BATCH_SIZE = 2000

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
            start_time = time.time()
            combined = {}

            # Run the inner loop for exactly 1 second
            while time.time() - start_time < 1 and not terminate_event.is_set():
                item = await translated_data.get()
                combined.update(json.loads(item))
                translated_data.task_done()
                combined_json = json.dumps(combined)

            try:
               # pass
               await send_updates(combined_json)
               with open(file="Json_dict.json","w") as json_data:
                   
                    json_data.write(json_dict)            
               print(f'Update sent at time {time.time()}')
                # await asyncio.sleep(1)              # Limit rate data is sent to site to prevent crashing
            except asyncio.TimeoutError:
                continue
        print("Server stopping...")
