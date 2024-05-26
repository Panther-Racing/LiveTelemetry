import socket
import queue


def Receive_Data(output_queue, terminate_event):
    # Set up the Server
    print('Starting Server')
    # Use IP address of current computer
    localIP = socket.gethostbyname(socket.gethostname())
    # localIP = '192.168.88.250'
    # localIP = '192.168.88.251'
    # localIP = '127.0.0.1'
    print(localIP, "Is being used")

    # Car UDP Port
    carPort = 20001
    # UDP Buffer size maybe? Need to check CHK
    buffer_size = 48

    # Create 2 datagram sockets, one for car, one for listening for and sending to clients
    car_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    # Bind all sockets to address and ip
    car_socket.bind((localIP, carPort))

    car_socket.settimeout(1.0)

    print(f"UDP server up and listening at {localIP} on car port {carPort}")

    # Run indefinitely to constantly listen for client requests and car data
    while not terminate_event.is_set():
        # Wait for incoming data
        try:
            data = car_socket.recvfrom(buffer_size)

            # Extract Message from the car data
            car_msg = data[0]
            print("Car Data:{}".format(car_msg))

            # Add newline to end of car data
            try:
                car_msg_string = car_msg.decode("utf-8")
                car_msg_string += "\n"
                bytesToSend = str.encode(car_msg_string)
                try:
                    # Add the car data to a queue for the next thread
                    output_queue.put_nowait(bytesToSend)
                    print(f'Translate queue has {output_queue.qsize()} items in it')
                except queue.Full as error:
                    print('Data discarded. raw data queue full')
            except UnicodeDecodeError as error:
                print(f'Decode error {error}')
                car_msg_string = ''
        except socket.timeout:
            pass
