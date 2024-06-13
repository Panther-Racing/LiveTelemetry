import socket
import time

# Define the target IP address and port
UDP_IP = "20.81.190.176"
UDP_PORT = 20001

# List of messages to be sent (without the last number)
messages = [
    "8,b0,28 0 28 0 4 0 28 0 ,18"
]

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Calculate the interval between messages
interval = 1 / 500  # 500 messages per second

# Record the start time
start_time = time.time()*1000

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
        elapsed_time = time.time()*1000 - start_time
        # Append the elapsed time to the message
        modified_message = f"{message},{round(elapsed_time)}"
        print(modified_message)
        # Send the modified message
        sock.sendto(modified_message.encode(), (UDP_IP, UDP_PORT))
        time.sleep(interval)
