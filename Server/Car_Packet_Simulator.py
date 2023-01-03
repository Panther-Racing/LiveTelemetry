#!/usr/bin/env python
# Code simulates the car sending CAN packets

import socket
import time

# Set server Port
serverPort = 20001

# Get the current computer's Address and the server's Address
myAddress = input("Enter the IP Address of this computer: ")
serverAddress = (input("Enter the IP Address of the server: "), 20001)
# serverAddress = ("litelserver.eastus.cloudapp.azure.com", 20001)

# Create and bind the socket
serverSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
serverSocket.bind((myAddress, serverPort))

# Initialize test packet to send
# counter = 0

# while True:
#     messageToSend = "1234567890" + str(counter)
#     bytesToSend = str.encode(messageToSend)
#     serverSocket.sendto(bytesToSend, serverAddress)
#     counter = (counter + 1) % 10
#

# Open the sample data file
f = open('BusLogs/log.asc','r')
data = []
# Read in the first line of data
line = f.readline()

# While there is valid data to read in, continue reading it into an array
while line:
    # strip removes the newline character from the end of the data
    line = line.strip()
    canID = line[14:23]
    length = line[36:38]
    messageData = line[38:63]
    # Create a tuple from the data: (time sent, canID, length, data)
    dataTuple = (line[0:9], canID.strip(), length.strip(), messageData.strip())
    # Append tuple to the data array
    data.append(dataTuple)
    line = f.readline()
f.close()

# Remove non-data elements from array
for x in range(7):
    data.pop(0)

# Send the data from the array at the proper time intervals
previousTime = float(data[0][0])
# Initialize counter for each message sent
messageNum = 0
for element in data:
    currentTime = float(element[0])
    # Delay to be in accordance with the rate that the car sends out data
    time.sleep(currentTime-previousTime)
    previousTime = currentTime
    # Create and encode the message and send it to the server
    messageToSend = f'{messageNum},' + element[1] + ',' + element[2] + ',' + element[3]
    bytesToSend = str.encode(messageToSend)
    serverSocket.sendto(bytesToSend, serverAddress)
    # Increment Counter
    messageNum += 1
