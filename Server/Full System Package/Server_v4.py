import socket


def start(conn):
    print('Starting')
    setup_server()
    main(conn)


def setup_server():
    # localIP = input("Enter the IP Address of the server: ")
    # Use IP address of current computer
    localIP = socket.gethostbyname(socket.gethostname())
    # localIP = '127.0.0.1'
    print(localIP, "Is being used")

    # Car UDP Port
    carPort = 20001
    # UDP Buffer size maybe? Need to check CHK
    global buffer_size
    buffer_size = 1024

    # Create a list of client addresses to send to
    global clientList
    clientList = []

    # Create 2 datagram sockets, one for car, one for listening for and sending to clients
    global car_socket
    car_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    # Bind all sockets to address and ip
    car_socket.bind((localIP, carPort))

    print(f"UDP server up and listening at {localIP} on car port {carPort}")


# Function to receive data from car and send it to clients -- called when new car data is received
def data_handler(car_data_package):
    # Extract Message from the car data
    car_msg = car_data_package[0]
    # print("Car Data:{}".format(carMsg))

    # Add newline to end of car data
    car_msg_string = car_msg.decode("utf-8")
    car_msg_string += "\n"

    # Encode the car data into bytes
    bytesToSend = str.encode(car_msg_string)
    return bytesToSend


def main(conn):
    try:
        # Run indefinitely to constantly listen for client requests and car data
        while (True):
            print('listening')
            data = car_socket.recv(buffer_size)
            conn.send(data_handler(data))
    except KeyboardInterrupt:
        #If a user on the server interrupts the program, it will stop the infinite loop
        print("Caught Keyboard interrupt, exiting")

# random_port = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
# random_port.bind(('127.0.0.1', 20002))
#
# start(random_port)