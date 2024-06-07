import cantools
import socket
import time
import random

# Load the DBC file
dbc_file = 'DBCs/Combined.dbc'
db = cantools.database.load_file(dbc_file)

# UDP configuration
UDP_IP = "20.81.190.176"
UDP_PORT = 20001
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Record the start time
start_time = time.time()

# Initialize the counter
counter = 0

# Function to generate random data based on DBC signal type
def generate_random_data(signal):
    if signal.is_float:
        return random.uniform(signal.minimum, signal.maximum)
    elif signal.is_signed:
        return random.randint(int(signal.minimum), int(signal.maximum))
    else:
        return random.randint(int(signal.minimum), int(signal.maximum))

# Function to format data as hex string
def format_data(data):
    return ' '.join(format(byte, '02x') for byte in data)

# Function to create and send a CAN message
def create_and_send_can_message(counter):
    for message in db.messages:
        # Generate random data for each signal
        data_dict = {signal.name: generate_random_data(signal) for signal in message.signals}

        # Encode the data
        try:
            data = message.encode(data_dict)

            # Create the CAN message
            can_id = message.frame_id

            # Calculate the elapsed time in milliseconds
            elapsed_time = int((time.time() - start_time) * 1000)

            # Format the message
            message_format = f"{message.length},{can_id:x},{format_data(data)}, {counter}, {elapsed_time}"
            print(message_format)

            # Send the message over UDP
            sock.sendto(message_format.encode(), (UDP_IP, UDP_PORT))
        except Exception as e:
            print(e)


# Function to create and send the startup message
def send_startup_message():
    startup_message = "startup"
    # Calculate the elapsed time in milliseconds
    elapsed_time = int((time.time() - start_time) * 1000)
    message_format = f"8,00,{startup_message}, {counter}, {elapsed_time}"
    print(message_format)
    sock.sendto(message_format.encode(), (UDP_IP, UDP_PORT))
    time.sleep(1)


send_startup_message()

# Periodically send CAN messages
while True:
    create_and_send_can_message(counter)
    counter += 1
    time.sleep(0.000001)  # Adjust the interval as needed
    # time.sleep(0.1)
