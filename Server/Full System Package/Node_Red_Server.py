import pyodbc
import socket
import time


def start():
    print('Started Node Red Server')
    wait_for_request()


def connect_sql():
    global conn
    server = '20.81.190.176'
    database = 'Live Telemetry'
    username = 'raheelfarouk'
    password = 'li.telServer;'
    # ENCRYPT defaults to yes starting in ODBC Driver 18. It's good to always specify ENCRYPT=yes on the client side to avoid MITM attacks.
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';ENCRYPT=yes;UID='+username+';PWD='+ password+'TrustServerCertificate=yes;', fast_execute_many=True)
    # print('Connected to SQL Server')


def connect_node_red():
    global comm_port
    global comm_socket
    my_address = socket.gethostbyname(socket.gethostname())
    comm_port = 20003
    comm_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    comm_socket.bind((my_address, comm_port))
    # print('Connected to Node Red')


def wait_for_request():
    connect_sql()
    connect_node_red()
    while True:
        # print('Waiting to send Data')
        # request = comm_socket.recv(1048)
        request = 'Live'
        if request == 'Live':
            while True:
                # print('Sending Data')
                send_to_node_red(query_sql())
        else:
            print(request)


def query_sql(top_num=1):
    cursor = conn.cursor()
    result = cursor.execute('SELECT TOP (?) * FROM dbo.race_data', top_num)
    data = str(result.fetchall())
    # print(data)
    return data


def send_to_node_red(data):
    destination = 'arf-ece1188.eastus.cloudapp.azure.com'
    destination_address = (destination, comm_port)
    data = data.encode()
    # print(f'Data encoded: {data}')
    comm_socket.sendto(data, destination_address)
