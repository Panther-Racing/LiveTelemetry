# Import other programs we wrote
import CAN_Translate
import Send_SQL
import Receive_Data

# Import System Packages
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

# Create flag variables to control the infinite loops in threads
terminate_flag = False


# Function to set the terminate flag
def set_terminate_flag():
    global terminate_flag
    terminate_flag = True


# Create and run threads to have all programs running simultaneously
print('Creating threads')
receive_data_thread = threading.Thread(target=Receive_Data.Receive_Data, args=(raw_data,))
translate_thread = threading.Thread(target=CAN_Translate.CAN_Translate, args=(raw_data, translated_data,))
sql_thread = threading.Thread(target=Send_SQL.Send_SQL, args=(translated_data,))
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
    set_terminate_flag()  # Set the terminate flag to True
    sys.exit(0)

# Join threads to ensure they complete before exiting
receive_data_thread.join()
translate_thread.join()
sql_thread.join()

print("Server Closing")
