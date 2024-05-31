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
        await asyncio.gather(*[ws.send(data) for ws in connected_clients if ws.open])


async def begin(translated_data, terminate_event):
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
