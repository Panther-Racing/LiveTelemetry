# Import system packages
import queue
import threading
import time
import sys
import Receive_Data
import CAN_Translate
import Send_SQL

# Create queues to hold raw incoming data and translated data
raw_data = queue.Queue(maxsize=48)
translated_data = queue.Queue(maxsize=48)

# Create event object to signal termination
terminate_event = threading.Event()

# Function to set the terminate event
def set_terminate_event():
    terminate_event.set()

# Create and run threads to have all programs running simultaneously
print('Creating threads')
receive_data_thread = threading.Thread(target=Receive_Data.Receive_Data, args=(raw_data, terminate_event))
translate_thread = threading.Thread(target=CAN_Translate.CAN_Translate, args=(raw_data, translated_data, terminate_event))
sql_thread = threading.Thread(target=Send_SQL.Send_SQL, args=(translated_data, terminate_event))
# node_red_thread = threading.Thread(target=node_red_process)
receive_data_thread.start()
time.sleep(.1)
translate_thread.start()
time.sleep(.1)
sql_thread.start()

# Continue running unless there is a keyboard interrupt
try:
    while True:
        pass
except KeyboardInterrupt:
    print("Ctrl+C detected. Exiting...")
    set_terminate_event()  # Set the terminate event
    sys.exit(0)

# Join threads to ensure they complete before exiting
receive_data_thread.join()
translate_thread.join()
sql_thread.join()

print("Server Closing")
