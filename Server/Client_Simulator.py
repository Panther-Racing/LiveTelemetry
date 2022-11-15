#!/usr/bin/env python

import socket
import time

# Get the address of the test computer and the server computer
myPort = input("Enter the IP Address of this Computer: ")
serverPort = input("Enter the IP Address of the Server: ")

mainSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM);
mainSocket.bind((myPort, 20003))

bytesToSend = str.encode("Add Me")
mainSocket.sendto(bytesToSend, (serverPort, 20003))

for i in range(10):

    # Initialize variables to track how many messages are being missed/corrupted
    missed = 0
    received = 0
    past = 0
    corrupted = 0
    repeated = 0
    startTime = time.time()

    while received < 2000:
        message = mainSocket.recv(1024).decode()
        print(message)

        # Increment variable tracking the number of messages received
        received += 1

        # Find the difference between the past and current message
        difference = int(message)
        difference = difference - past
        print(f"Past: {past}       Difference: {difference}")

        # If the difference is greater than 9 than it must be due to corruption (The counter is only 0 to 9)
        if abs(difference) > 9:
            corrupted += 1
            print("corrupted")
        # If the difference is negative, count the missing packages by adding 9 to the difference
        elif difference < 0:
            missed += difference + 9
            print(f"missed {difference+9}")
        # If the number received is the same twice in a row then 16 packets were missed
        elif difference == 0:
            # missed += 9
            repeated += 1
            received -= 1
            print(f"repeated")
        # Otherwise the difference is positive which means it is one more than the number of packages missed
        else:
            missed += difference - 1
            print(f"missed {difference-1}")

        past = int(message)
        print()
        print()
        print()

    # Account for the first time past not matching difference because past is initialized to 0
    corrupted -= 1
    endTime = time.time()

    percentMissed = (missed / (missed+received)) * 100
    print(f"Run {i}")
    print(f"Percent of Messages Missed: {percentMissed}%")
    print(f"Number of Messages corrupted: {corrupted}")
    print(f"Number of times reread packets: {repeated}")
    print(f"Number of Messages Received: {received}")
    print(f"Time to run: {endTime-startTime} seconds")
    time.sleep(10)
