# Import other programs we wrote
import CAN_Translate
import Send_SQL
import Receive_Data

# Import System Packages
import threading
import queue
import time
import sys

# Create queues to hold raw incoming data and translated data
raw_data = queue.Queue(maxsize=48)
translated_data = queue.Queue(maxsize=48)

# Create and run threads to have all programs running simultaneously
print('Creating threads')
receive_data_thread = threading.Thread(target=Receive_Data.Receive_Data(raw_data))
translate_thread = threading.Thread(target=CAN_Translate.CAN_Translate(raw_data, translated_data))
sql_thread = threading.Thread(target=Send_SQL.Send_SQL(translated_data))
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
    sys.exit(0)

print("Server Closing")
