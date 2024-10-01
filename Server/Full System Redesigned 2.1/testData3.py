import socket
import time

# Define the target IP address and port
UDP_IP = "20.81.190.176"
UDP_PORT = 20001

# List of messages to be sent (without the last number)
messages = [
    "8,a1,28 0 28 0 28 0 28 0 ,3",
    "8,a2,28 0 28 0 28 0 28 0 ,4",
    "8,a3,90 41 6 19 90 41 6 19 ,5",
    "8,a4,1 1 1 1 1 1 1 1 ,6",
    "8,a5,28 0 4 0 28 0 28 0 ,7",
    "8,a6,28 0 28 0 28 0 28 0 ,8",
    "8,a7,28 0 28 0 28 0 28 0 ,9",
    "8,a8,28 0 28 0 28 0 28 0 ,10",
    "8,a9,90 1 90 1 90 1 90 1 ,11",
    "8,aa,4 4 4 3f 83 41 c3 ff ,12",
    "8,ab,4 0 4 0 4 0 4 0 ,13",
    "8,ac,28 0 28 0 35 5 0 0 ,14",
    "8,ad,40 9c 28 0 28 0 28 0 ,15",
    "8,ae,4 0 4 0 4 0 4 0 ,16",
    "8,af,4 4 28 0 28 0 28 0 ,17",
    "8,b0,28 0 28 0 4 0 28 0 ,18",
    "8,c0,28 0 4 0 1 7 28 0 ,19",
    "8,c1,4 0 1 0 4 0 0 0 ,20",
    "8,c2,4 0 1 0 4 0 0 0 ,21",
    "8,118,4 0 28 1 90 0 0 0 ,22",
    "8,119,4 0 28 0 28 0 0 0 ,23",
    "8,202,4 0 4 0 0 0 0 0 ,24",
    "8,500,4 0 0 0 0 0 0 0 ,25",
    "8,542,4 80 20 80 20 c d0 0 ,26",
    "8,544,4 0 28 0 28 18 18 0 ,27",
    "8,644,4 1 90 28 0 1 0 0 ,28",
    "8,646,4 5 0 0 4 0 0 0 ,29",
    "8,648,4 d5 55 55 55 55 55 55 ,30",
    "8,6b0,0 28 0 28 8 0 4 ff ,31",
    "8,6b1,0 4 4 0 4 4 4 0 ,32",
    "8,6b2,4 0 28 0 28 0 4 4 ,33",
    "8,6b3,f a0 4 0 0 0 0 4 ,34",
    "8,6b5,0 4 0 4 0 0 0 0 ,35",
    "8,6b6,1 90 0 28 0 0 0 0 ,36",
    "8,6b8,0 28 0 28 9c 40 9c 40 ,37",
    "8,6b9,4 4 4 4 4 4 4 4 ,38",
    "8,6ba,9c 40 1 90 1 90 9c 40 ,39",
    "8,6bb,9c 40 0 28 0 4 0 4 ,40",
    "8,6bc,0 4 0 0 0 0 0 0 ,41",
    "8,750,4 0 28 0 28 0 0 0 ,42",
    "8,9806e5f4,0 28 0 28 80 0 0 0 ,43",
    "8,9806e7f4,0 28 0 28 80 0 0 0 ,44",
    "8,9806e9f4,0 28 0 28 80 0 0 0 ,45",
    "8,98ff50e5,0 0 0 0 0 0 0 0 ,46"
]

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Calculate the interval between messages
# interval = 1 / 500  # 500 messages per second
# interval = 0.000001
interval = 1 / 400  # The car sends at a rate of about 400 messages per second

# Record the start time
start_time = time.time()

startup_message = "startup"
# Calculate the elapsed time in milliseconds
elapsed_time = int((time.time() - start_time) * 1000)
message_format = f"8,00,{startup_message}, 0, {elapsed_time}"
print(message_format)
sock.sendto(message_format.encode(), (UDP_IP, UDP_PORT))
time.sleep(1)

while True:
    # Send the messages at the specified rate
    for message in messages:
        # Calculate the elapsed time since the start
        elapsed_time = time.time() - start_time
        # Append the elapsed time to the message
        modified_message = f"{message},{round(elapsed_time)}"
        print(modified_message)
        # Send the modified message
        sock.sendto(modified_message.encode(), (UDP_IP, UDP_PORT))
        time.sleep(interval)
