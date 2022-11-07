#!/usr/bin/env python

import socket
import selectors
import types
import time
from tkinter import *
import threading
import sys

# Declare global variables
sel = None
bufferSize = None
timeoutTime = 1
localIP = None
packetsHandled = 0
currentRow = 0;
clientLabels = list()
# Create a list of client addresses to send to
# Client list will contain tuples, with the first value being client address and second value time joined
clientList = list()
# Variable to track current number of clients
numClients = 0
removeList = list()
clientSocket = None
timeoutLabel = None


def setup_server():
    # Declare global variables to ensure they aren't shadowed
    global numClients
    global clientList
    global sel
    global bufferSize
    global timeoutTime
    global clientSocket
    global localIP
    global currentRow
    global timeoutLabel

    # Get the ip address and ports and timeout time that the user entered in the textboxes
    localIP = ipAddressField.get(index1=1.0, index2="end-1c")
    clientPort = int(setClientPort.get(index1=1.0, index2="end-1c"))
    carPort = int(setCarPort.get(index1=1.0, index2="end-1c"))
    timeoutLabel = Label(frame, text=f"Timeout time: {timeoutTime} seconds")
    change_timeout()

    # Create a selector for handling data receive events
    sel = selectors.DefaultSelector()

    # adding an input box here to get the IP Address from the user

    # localIP = input("Enter the IP Address of the server: ")

    # Change to local IP of server -Future version get this automatically
    # localIP = "192.168.0.150"
    # Car UDP Port
    # carPort = 20001
    # Client UDP Port
    # clientPort = 20003
    # UDP Buffer size maybe? Need to check CHK
    bufferSize = 1024

    # Create a variable for how long before timing out
    # timeoutTime = 7200

    # Create 2 datagram sockets, one for car, one for listening for and sending to clients
    carSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    clientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    # Bind all sockets to address and ip
    carSocket.bind((localIP, carPort))
    clientSocket.bind((localIP, clientPort))

    # Add client socket to selector so an interrupt event is crated when a client tries to join
    # Don't create a data attribute so that it can be told apart from the car socket
    sel.register(clientSocket, selectors.EVENT_READ, data=None)

    # Create a data attribute to differentiate car events from client events and to log incoming car data
    carData = types.SimpleNamespace(type="car", inb=b"")
    # Add the car socket to the selector so incoming car data creates an interrupt event
    sel.register(carSocket, selectors.EVENT_READ, data=carData)

    print(f"UDP server up and listening at {localIP} on car port {carPort} and client port {clientPort}")

    # Delete all old gui elements
    promptInput.destroy()
    ipAddressField.destroy()
    startButton.destroy()
    setClientPort.destroy()
    setCarPort.destroy()
    promptCarInput.destroy()
    promptClientInput.destroy()

    # Display the server settings
    addressLabel = Label(frame, text=f"IP Address:\t{localIP}")
    carPortLabel = Label(frame, text=f"Car Port:  \t{carPort}")
    clientPortLabel = Label(frame, text=f"Client Port:\t{clientPort}")
    addressLabel.grid(row=currentRow)
    currentRow += 1
    carPortLabel.grid(row=currentRow, pady=5)
    currentRow += 1
    clientPortLabel.grid(row=currentRow, pady=5)
    currentRow += 1
    timeoutLabel.grid(row=currentRow, pady=5)
    currentRow += 1

    # Give the option to change the timeout time
    changeTimeoutButton = Button(frame, text="Change", fg='black', bg='white', activebackground='grey',
                                 command=change_timeout)
    timeoutPrompt.grid(row=currentRow, column=0, pady=5)
    timeoutInput.grid(row=currentRow, column=1, pady=5)
    changeTimeoutButton.grid(row=currentRow, column=2, pady=5)
    currentRow += 1

    # Display the number of packets received
    packetDisplay.grid(row=currentRow, pady=30)
    currentRow += 1

    # Create Label for Client List
    clientListLabel = Label(frame, text="Active Clients:")
    clientListLabel.grid(row=currentRow, pady=20)
    currentRow += 1

    listenThread.start()
    timeoutThread.start()


# Function to remove clients from the list and GUI given an address
def remove_client(address):
    global numClients
    global clientList
    global sel
    global bufferSize
    global timeoutTime
    global localIP
    global currentRow

    i = 0
    for client in clientList:
        if address == client[0]:
            clientList.pop(i)
            clientLabels[i].destroy()
            clientLabels.pop(i)
            removeList[i].destroy()
            removeList.pop(i)
            numClients -= 1
            currentRow -= 1
            print(f"Removed client at address {(client[0])[0]}")
        i += 1


# Function to get new clients -- called when clients request to be added
def accept_wrapper(sock):
    # Declare global variables to ensure they aren't shadowed
    global numClients
    global clientList
    global sel
    global bufferSize
    global timeoutTime
    global clientSocket
    global localIP
    global currentRow

    # Get message and address from the clientSocket
    commClient = sock.recvfrom(bufferSize)
    # If client request is valid, add client to clientList, else produce error
    if commClient[0] == b'Add Me':  # Message that comes from UDP comes in as a byte
        # Remove client if it is already in the list (to then re-add it)
        remove_client(commClient[1])

        # Add a tuple of the clients address and time added to the client list
        clientList.append((commClient[1], time.time()))

        # Add client to gui
        clientLabels.append(Label(frame, text=f"Client {numClients + 1}\tAddress: {((clientList[numClients])[0])[0]}   "
                                              f" \tTime Joined: {(clientList[numClients])[1]}"))
        removeList.append(Button(frame, text="Remove Client", fg='black', bg='white', activebackground='grey',
                                 command=lambda: remove_client(commClient[1])))
        clientLabels[numClients].grid(row=currentRow, column=0)
        removeList[numClients].grid(row=currentRow, column=1)
        currentRow += 1

        # Increment the number of clients on the server
        numClients += 1
        print(f"Accepted connection from {commClient[1]} at time {(clientList[numClients - 1])[1]}")

    # If client requests to be removed, call remove function to remove them
    elif commClient[0] == b'Remove Me':
        print(f"Requested removal from {commClient[1]}")
        remove_client(commClient[1])
    else:
        print("Invalid Client Request")
        print(f"Client Said: {commClient[0]}")


# Function to receive data from car and send it to clients -- called when new car data is received
def data_handler(key):
    # Declare global variables to ensure they aren't shadowed
    global numClients
    global clientList
    global sel
    global bufferSize
    global timeoutTime
    global clientSocket
    global localIP
    global currentRow

    # Get incoming data from the car
    carDataPackage = key.fileobj.recvfrom(bufferSize)

    # Extract Message from the car data
    carMsg = carDataPackage[0]
    print("Car Data:{}".format(carMsg))

    # Log received data in notes connected to the car socket
    data = key.data
    data.inb += carMsg

    # Add newline to end of car data
    carMsgString = carMsg.decode("utf-8")
    carMsgString += "\n"

    # Encode the car data into bytes
    bytesToSend = str.encode(carMsgString)

    # For each client, send out the received car data
    for client in clientList:
        clientSocket.sendto(bytesToSend, client[0])

    global packetsHandled
    packetsHandled += 1
    packetDisplay.configure(text=f"Packets Handled: {packetsHandled}")


# Function to check how long each client has been connected and disconnect them if it has been too long
def timeout():
    global clientList
    global timeoutTime
    while True:
        current = time.time()
        for client in clientList:
            if (current - client[1]) > timeoutTime:
                print(f"Client at address {(client[0])[0]} timed out")
                remove_client(client[0])


def change_timeout():
    global timeoutTime
    global timeoutLabel
    timeoutTime = int(timeoutInput.get(index1=1.0, index2="end-1c"))
    timeoutLabel.configure(text=f"Timeout time: {timeoutTime} seconds")


# Main program
def main_loop():
    # Declare global variables to ensure they aren't shadowed
    global numClients
    global clientList
    global sel
    global bufferSize
    global timeoutTime
    global clientSocket
    global localIP
    global currentRow

    try:
        # Run indefinitely to constantly listen for client requests and car data
        while True:
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
                # If key.data is not none, then the event is from the car so run a function to receive and send out
                # that data
                else:
                    data_handler(key)

    except KeyboardInterrupt:
        # If a user on the server interrupts the program, it will stop the infinite loop
        print("Caught Keyboard interrupt, exiting")
    finally:
        # The selector will be closed when the program ends
        sel.close()


def onFrameConfigure(canvas):
    # Reset the scroll region to encompass the inner frame
    canvas.configure(scrollregion=canvas.bbox("all"))


# GUI SETUP:

# Set up GUI frame in the GUI window
window = Tk()
window.geometry("1000x700")
window.title("Server Control Panel")

# Add scrollbar to frame using canvas
canvas = Canvas(window, borderwidth=0)
vsb = Scrollbar(window, orient="vertical", command=canvas.yview)
canvas.configure(yscrollcommand=vsb.set)
frame = Frame(canvas)
vsb.pack(side="right", fill="y")
canvas.pack(side="left", fill="both", expand=True)
canvas.create_window((4, 4), window=frame, anchor="nw")
frame.bind("<Configure>", lambda event, canvas=canvas: onFrameConfigure(canvas))

# Get the ip address of the server
promptInput = Label(frame, text="Enter the ip address of the server:")
ipAddressField = Text(frame, height=1, width=20)
startButton = Button(frame, text="Start Server", fg='black', bg='white', activebackground='grey',
                     command=setup_server)

# Get the port for the client and car
promptClientInput = Label(frame, text="Enter the port to use for the client (default = 20003)")
setClientPort = Text(frame, height=1, width=5)
promptCarInput = Label(frame, text="Enter the port to use for the car (default = 20001)")
setCarPort = Text(frame, height=1, width=5)

# Get the timeout time
timeoutPrompt = Label(frame, text="Enter the time it takes to timeout (in seconds): ")
timeoutInput = Text(frame, height=1, width=5)

# Create GUI for continuously running server
packetDisplay = Label(frame, text=f"Packets Handled: {packetsHandled}")

# Put items on the screen
promptInput.grid(row=0, column=0)
ipAddressField.grid(row=0, column=1)
promptClientInput.grid(row=1, column=0)
setClientPort.grid(row=1, column=1)
promptCarInput.grid(row=2, column=0)
setCarPort.grid(row=2, column=1)
timeoutPrompt.grid(row=3, column=0)
timeoutInput.grid(row=3, column=1)
startButton.grid(row=4)

# Create thread to listen for car data
listenThread = threading.Thread(target=main_loop)
listenThread.daemon = True

# Create a thread to check for timeouts
timeoutThread = threading.Thread(target=timeout)
timeoutThread.daemon = True

# Stop the thread once the window is closed
window.mainloop()
sys.exit()
