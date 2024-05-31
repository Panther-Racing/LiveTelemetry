import socket
import queue
import threading

def begin(raw_data_queue, terminate_event):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind((socket.gethostbyname(socket.gethostname()), 20001))
    s.settimeout(1)
    print(f'Listening at {socket.gethostbyname(socket.gethostname())} on port 20001')

    while not terminate_event.isSet():
        try:
            data, addr = s.recvfrom(1024)
            raw_data_queue.put(data)
        except socket.timeout:
            continue
        except Exception as e:
            print(f"Error: {e}")
