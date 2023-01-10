#!/usr/bin/env python

import socket
import selectors
import can
import cantools

# import can_decoder

# db = can_decoder.load_dbc('DBC2.dbc')
# decoder = can_decoder.DataFrameDecoder(db)

# can.rc['interface'] = 'socketcan'
# can.rc['channel'] = 'vcan0'
# can_bus = can.interface.Bus()

sel = None
db = None
bufferSize = 1024
CANSocket = None
serverIP = None
receivePort = None


def setup():
    global sel
    global db
    global CANSocket
    global serverIP
    global receivePort
    # Connect to server to get CAN data
    # Get the address of the computer, what port to be on, and the IP address of the server
    localIP = input("Enter the IP address of this program: ")
    receivePort = 20003
    # serverIP = input('Enter the IP address of the server: ')
    serverIP = socket.gethostbyname('litelserver.eastus.cloudapp.azure.com')
    # Create the socket
    CANSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    CANSocket.bind((localIP, receivePort))
    # Request to be added to the server
    bytesToSend = str.encode("Add Me")
    CANSocket.sendto(bytesToSend, (serverIP, receivePort))
    print(f'Added as client on {serverIP}')
    print(f'UDP server up and listening at {localIP} on port {receivePort}')

    # Create a selector for handling data receive events
    sel = selectors.DefaultSelector()
    sel.register(CANSocket, selectors.EVENT_READ, data=None)
    print("Selector created")

    # Add the DBC file to the CAN reader
    db = cantools.database.Database()
    db.add_dbc_file('DBC1.dbc')


def find_nth(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
        start = haystack.find(needle, start+len(needle))
        n -= 1
    return start


def data_handler(key):
    global db
    # Extract the message from the socket
    message = key.fileobj.recvfrom(bufferSize)[0].decode().strip()

    # Seperate CAN message into id and data
    frame_id = message[find_nth(message, ',', 1)+1:find_nth(message, ',', 2)]
    data = message[find_nth(message, ',', 3)+1:]
    print(frame_id)
    print(data)

    try:
        # Decode each incoming message and print it out
        print(db.decode_message(frame_id, data))
    except KeyError as error:
        print('Key error: %s' % error)


def main():
    setup()
    while True:
        # Wait for an event (input has been received on one of the sockets) and never timeout
        events = sel.select(timeout=None)

        # Call a function to handle data
        for key, mask in events:
            data_handler(key)


try:
    main()
except:
    # When program is terminated (keyboard interrupt) ask to be removed from the server
    bytesToSend = str.encode("Remove Me")
    CANSocket.sendto(bytesToSend, (serverIP, receivePort))
    print(f'Removed from {serverIP}')
