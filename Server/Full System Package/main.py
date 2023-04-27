# Import other programs we wrote
import CAN_Translate_And_Send_v1
import send_sql_v1
import Server_v4
import threading
import time

# Import multiprocessing
from multiprocessing import Process, Pipe


def server_process():
    print('Starting process 1')
    # Start process that collects data from the car
    # server_conn receives data from this process (the data acquired from the car)
    global server_conn
    server_conn, server_child_conn = Pipe()
    server = Process(target=Server_v4.start(server_child_conn))
    server.start()


def translate_process():
    print('starting process 2')
    # Start process that translates car data into JSON
    global translate_conn
    translate_conn, translate_child_conn = Pipe()
    # The data acquired from the previous process is sent to this process, and we receive data through translate_conn
    translate = Process(target=CAN_Translate_And_Send_v1.start(server_conn, translate_child_conn))
    translate.start()


def sql_process():
    print('starting process 3')
    # Start process that converts JSON to SQL and sends it to the database
    # This process does not give us information, it just takes the info from the last process and uses it
    SQL = Process(target=send_sql_v1.start(translate_conn))
    SQL.start()

def main():
    # Create and run threads to have all programs running simultaneously
    print('Creating threads')
    server_thread = threading.Thread(target=server_process)
    translate_thread = threading.Thread(target=translate_process)
    sql_thread = threading.Thread(target=sql_process)
    print('Start thread 1')
    server_thread.start()
    time.sleep(.1)
    print('Start thread 2')
    translate_thread.start()
    time.sleep(.1)
    print('Start thread 3')
    sql_thread.start()

main()
