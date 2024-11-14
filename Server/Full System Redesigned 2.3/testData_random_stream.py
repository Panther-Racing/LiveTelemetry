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

# Initialize the last values for each signal to create smoother transitions
last_values = {}

# Function to generate initial random data based on DBC signal type
def generate_initial_data(signal):
    min_val = signal.minimum if signal.minimum is not None else 0
    max_val = signal.maximum if signal.maximum is not None else 1000

    min_val = min(100, min_val)
    max_val = max(0, max_val)

    if min_val > max_val:
        max_val = min_val

    if signal.is_float:
        return random.uniform(min_val, max_val)
    elif signal.is_signed:
        return random.randint(int(min_val), int(max_val))
    else:
        return random.randint(int(min_val), int(max_val))

# Function to generate smooth random data based on the last value
def generate_smooth_data(signal, last_value):
    min_val = signal.minimum if signal.minimum is not None else 0
    max_val = signal.maximum if signal.maximum is not None else 1000

    if signal.is_float:
        new_value = last_value + random.uniform(-1, 1)
    elif signal.is_signed:
        new_value = last_value + random.randint(-1, 1)
    else:
        new_value = last_value + random.randint(-1, 1)

    # Ensure the value is within the 0 to 100 range
    return max(0, min(100, new_value))

# Function to format data as hex string
def format_data(data):
    return ' '.join(format(byte, '02x') for byte in data)

# Function to create and send a CAN message
def create_and_send_can_message(counter):
    for message in db.messages:
        data_dict = {}
        multiplexer_value = None

        # First pass to handle multiplexer values
        for signal in message.signals:
            if signal.is_multiplexer:
                if signal.choices:
                    multiplexer_value = random.choice(list(signal.choices.keys()))
                else:
                    multiplexer_value = 0  # Default to 0 if no choices are defined
                data_dict[signal.name] = multiplexer_value
                break

        # Second pass to handle normal and multiplexer dependent signals
        for signal in message.signals:
            if signal.is_multiplexer:
                continue
            if signal.multiplexer_ids:
                if multiplexer_value in signal.multiplexer_ids:
                    last_value = last_values.get(signal.name, generate_initial_data(signal))
                    new_value = generate_smooth_data(signal, last_value)
                    data_dict[signal.name] = new_value
                    last_values[signal.name] = new_value
            elif not signal.is_multiplexer:
                last_value = last_values.get(signal.name, generate_initial_data(signal))
                new_value = generate_smooth_data(signal, last_value)
                data_dict[signal.name] = new_value
                last_values[signal.name] = new_value

        try:
            # Encode the data
            data = message.encode(data_dict)

            # Create the CAN message
            can_id = message.frame_id
            bit_size = message.length * 8

            # Calculate the elapsed time in milliseconds
            elapsed_time = int((time.time() - start_time)*1000)

            # Format the message
            message_format = f"{bit_size},{can_id:x},{format_data(data)}, {elapsed_time}, {counter}"
            print(message_format)

            # Send the message over UDP
            sock.sendto(message_format.encode(), (UDP_IP, UDP_PORT))
        except Exception as e:
            print(f"Error encoding or sending message: {e}")

# Function to create and send the startup message
def send_startup_message():
    startup_message = "startup"
    # Calculate the elapsed time in milliseconds
    elapsed_time = int((time.time() - start_time)*1000)
    message_format = f"8,0x00,{startup_message}, {elapsed_time}, 0"
    print(message_format)
    sock.sendto(message_format.encode(), (UDP_IP, UDP_PORT))
    time.sleep(1)

# Send the startup message
send_startup_message()

# Periodically send CAN messages
while True:
    create_and_send_can_message(counter)
    counter += 1
    time.sleep(1/400)  # Adjust the interval as needed
