#!/usr/bin/env python

# Code simulates the car sending CAN packets

import socket

# Set server Port
serverPort = 20001

# Get the current computer's Address and the server's Address
myAddress = input("Enter the IP Address of this computer: ")
serverAddress = (input("Enter the IP Address of the server: "), 20001)

# Create and bind the socket
serverSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
serverSocket.bind((myAddress, serverPort))

# Initialize test packet to send
counter = 0

while True:
    bytesToSend = "123456789" + str(counter)
    serverSocket.sendto(bytesToSend, serverAddress)
    counter = (counter + 1) % 16
