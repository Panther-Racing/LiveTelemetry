#!/usr/bin/env python

import socket
import time

# Get the address of the test computer and the server computer
myPort = input("Enter the IP Address of this Computer: ")
serverPort = input("Enter the IP Address of the Server: ")

# Set up the internet connection
mainSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM);
mainSocket.bind((myPort, 20003))

# Request to be added to the server's clients
bytesToSend = str.encode("Add Me")
mainSocket.sendto(bytesToSend, (serverPort, 20003))

# Create a list to receive the messages
message = []
x = 0

# Run for 15 minutes
endTime = time.time() + 60 * 5

# Put the messages into an array
while x < 100000:
    message.append(mainSocket.recv(1024).decode())
    x += 1

# Count the number of messages missed
numMissed = 0
repeated = -1
elementsRead = 0
previous = int((message[0])[0:message[0].index(',')])
for element in message:
    current = int(element[0:element.index(',')])
    if(current == previous):
        repeated += 1
    else:
        numMissed += current - previous - 1
        previous = current
    # print(f'{current}   {previous}')
    elementsRead += 1

numMissed += 1
print(numMissed)
print(previous)
print(repeated)
print(elementsRead)
