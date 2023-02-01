#!/usr/bin/env python

import socket
import selectors
import can
import cantools
import json
import time

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
outfile = open('output.txt', 'a')
# jsonFile = open('forjson.txt', 'a')
json_file_name = "json_data.json"


def setup():
    global sel
    global db
    global CANSocket
    global serverIP
    global receivePort
    global outfile
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
    outfile.write(f'Added as client on {serverIP}\n')
    outfile.write(f'UDP server up and listening at {localIP} on port {receivePort}\n')
    print(f'Added as client on {serverIP}')
    print(f'UDP server up and listening at {localIP} on port {receivePort}')

    # Create a selector for handling data receive events
    sel = selectors.DefaultSelector()
    sel.register(CANSocket, selectors.EVENT_READ, data=None)
    outfile.write('Selector created\n')
    print("Selector created")

    # Add the DBC file to the CAN reader
    db = cantools.database.Database()
    db.add_dbc_file('DBC1.dbc')

    # Reset the json file
    json_file = open(json_file_name, "w")
    json_file.write('{}')


def find_nth(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
        start = haystack.find(needle, start+len(needle))
        n -= 1
    return start


# Translate each string from the decoded CAN message into a dictionary and then output that dictionary to the json file
def to_json(message):
    with open(json_file_name, "r+") as json_file:
        # Traverse through the new dictionary and add time stamps
        for key in message:
            data_value = message[key]
            message[key] = (time.time(), data_value)
        json_dict = json.load(json_file)
        # print(json_dict)
        json_dict.update(message)
        json_file.close()
        open(json_file_name, "w").close()
        json_file = open(json_file_name, "r+")
        json.dump(json_dict, json_file)


def data_handler(key):
    global db
    global outfile
    # Extract the message from the socket
    message = key.fileobj.recvfrom(bufferSize)[0].decode().strip()

    # Separate CAN message into id and data
    # Except non hexadecimal values
    try:
        frame_id = int(message[find_nth(message, ',', 1)+1:find_nth(message, ',', 2)], 16)
    except ValueError as error:
        print('Non hexadecimal frame_id: %s' % error)
        outfile.write('Non hexadecimal frame_id: %s\n\n' % error)
        frame_id = 'ERROR'

    data = bytes(message[find_nth(message, ',', 3)+1:], 'utf-8')
    outfile.write(f'Frame ID: {frame_id}     data: {data}\n\n')
    print(f'Frame ID: {frame_id}     data: {data}')

    try:
        # Decode each incoming message and print it out
        # outfile.write(str(db.decode_message(frame_id, data)))
        # jsonFile.write(str(db.decode_message(frame_id, data)))
        to_json(db.decode_message(frame_id, data))
        # jsonFile.write('\n')
        outfile.write('\n\n')
        print(db.decode_message(frame_id, data))
    except KeyError as error:
        outfile.write('Key error: %s\n\n' % error)
        print('Key error: %s' % error)


def main():
    global outfile
    outfile.write('NEW INSTANCE')
    outfile.write('-------------------------------------------------------\n\n\n\n')
    setup()
    while True:
        # Wait for an event (input has been received on one of the sockets) and never timeout
        events = sel.select(timeout=None)

        # Call a function to handle data
        for key, mask in events:
            data_handler(key)


try:
    main()
except KeyboardInterrupt:
    # When program is terminated (keyboard interrupt) ask to be removed from the server
    bytesToSend = str.encode("Remove Me")
    CANSocket.sendto(bytesToSend, (serverIP, receivePort))
    print(f'Removed from {serverIP}')
    outfile.write(f'Removed from {serverIP}\n')
