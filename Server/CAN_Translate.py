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

def setup():
    global sel
    global db
    # Connect to server to get CAN data
    localIP = input("Enter the IP address of this program: ")
    receivePort = input("Enter the port of incoming CAN data: ")
    CANSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    CANSocket.bind((localIP, receivePort))
    print(f"UDP server up and listening at {localIP} on port {receivePort}")

    # Create a selector for handling data receive events
    sel = selectors.DefaultSelector()
    sel.register(CANSocket, selectors.EVENT_READ, data=None)
    print("Selector created")

    # Add the DBC file to the CAN reader
    db = cantools.database.Database()
    db.add_dbc_file('DBC1.dbc')


def data_handler(key):
    global db
    message = key.fileobj.recvfrom(bufferSize)
    frame_id = message[0:5]
    data = message[5:]
    # Decode each incoming message and print it out
    print(db.decode_message(frame_id, data))


def main():
    while True:
        # Wait for an event (input has been received on one of the sockets) and never timeout
        events = sel.select(timeout=None)

        # Extract key, which holds the socket object that triggered the event, and mask, which is an event mask
        # of the operations that are ready (if it is a receive or send event - we only use receive events)
        for key, mask in events:
            data_handler(key)