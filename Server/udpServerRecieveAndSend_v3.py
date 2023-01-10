#!/usr/bin/env python

import socket
import selectors
import types
import time
import threading

sel = None
bufferSize = None
clientList = None
clientSocket = None
carSocket = None
timeoutTime = None


def setup_server():
    global sel
    global bufferSize
    global clientList
    global clientSocket
    global carSocket
    global timeoutTime

    # Create a selector for handling data recieve events
    sel = selectors.DefaultSelector()

    '''adding an input box here to get the IP Address from the user'''

    # localIP = input("Enter the IP Address of the server: ")
    localIP = socket.gethostbyname(socket.gethostname())
    print(localIP, "Is being used")

    # Enter the time to timeout in seconds:
    timeoutTime = input('Enter the time for the client to timeout in seconds: ')

    # Change to local IP of server -Future version get this automatically
    # localIP = "192.168.0.150"
    # Car UDP Port
    carPort = 20001
    # Client UDP Port
    clientPort = 20003
    # UDP Buffer size maybe? Need to check CHK
    bufferSize = 1024

    # Create a list of client addresses to send to
    clientList = []

    # Create 2 datagram sockets, one for car, one for listening for and sending to clients
    carSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    clientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    # Bind all sockets to address and ip
    carSocket.bind((localIP, carPort))
    clientSocket.bind((localIP, clientPort))

    # Add client socket to selector so an interrupt event is crated when a client tries to join
    #Don't create a data attribute so that it can be told apart from the car socket
    sel.register(clientSocket, selectors.EVENT_READ, data=None)

    #Create a data attribute to differentiate car events from client events and to log incoming car data
    carData = types.SimpleNamespace(type="car", inb=b"")
    # Add the car socket to the selector so incoming car data creates an interrupt event
    sel.register(carSocket, selectors.EVENT_READ, data=carData)

    print(f"UDP server up and listening at {localIP} on car port {carPort} and client port {clientPort}")


# Function to get new clients -- called when clients request to be added
def accept_wrapper(sock):
    global sel
    global bufferSize
    global clientList
    global clientSocket
    global carSocket

    # Get message and address from the clientSocket
    clientMessage = sock.recvfrom(bufferSize)
    # If client request is valid, add client to clientList, else produce error
    if clientMessage[0] == b'Add Me':  # Message that comes from UDP comes in as a byte
        clientList.append(clientMessage[1])
        print(f"Accepted connection from {clientMessage[1]}")
    elif clientMessage[0] == b'Remove Me':
        clientList.remove(clientMessage[1])
        print(f"Removed {clientMessage[1]} on request")
    else:
        print("Invalid Client Request")
        print(f"Client Said: {clientMessage[0]}")


# Function to receive data from car and send it to clients -- called when new car data is received
def data_handler(key):
    global sel
    global bufferSize
    global clientList
    global clientSocket
    global carSocket

    # Get incoming data from the car
    carDataPackage = carSocket.recvfrom(bufferSize)

    # Extract Message from the car data
    carMsg = carDataPackage[0]
    # print("Car Data:{}".format(carMsg))

    # Log received data in notes connected to the car socket
    data = key.data
    data.inb += carMsg

    # Add newline to end of car data
    carMsgString = carMsg.decode("utf-8")
    carMsgString += "\n"

    # Encode the car data into bytes
    bytesToSend = str.encode(carMsgString)

    #For each client, send out the received car data
    for clientAddress in clientList:
        clientSocket.sendto(bytesToSend, clientAddress)
        # print(f'Sent {bytesToSend} to {clientAddress}')
    # print('Done sending message')


def remove_client(address):
    global sel
    global bufferSize
    global clientList
    global clientSocket
    global carSocket

    i = 0
    for client in clientList:
        if address == client[0]:
            clientList.pop(i)
            print(f"Removed client at address {(client[0])[0]}")
        i += 1

def main_loop():
    try:
        # Run indefinitely to constantly listen for client requests and car data
        while (True):
            # Wait for an event (input has been received on one of the sockets) and never timeout
            events = sel.select(timeout=None)
            # Extract key, which holds the socket object that triggered the event, and mask, which is an event mask
            # of the operations that are ready (if it is a receive or send event - we only use receive events)
            for key, mask in events:
                # If key.data is none, then the key is the client (which has no data label)
                # and we'll call a function to add it to the client list
                if key.data is None:
                    print("client request received")
                    accept_wrapper(key.fileobj)
                # If key.data is not none, then the event is from the car so run a function to receive and send out that data
                else:
                    data_handler(key)

    except KeyboardInterrupt:
        #If a user on the server interrupts the program, it will stop the infinite loop
        print("Caught Keyboard interrupt, exiting")
    finally:
        #The selector will be closed when the program ends
        sel.close()


# Main program
setup_server()
main_loop()
