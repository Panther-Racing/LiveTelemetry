import cantools
import sys
import os

# Constants for fixed-point representation
SCALE_FACTOR = 1e6
OFFSET_FACTOR = 1e3

# Maximum number of signals per message
MAX_SIGNALS = 68

# Maximum Length that a signal name can be to make sure it fits in the block ram
# This length is in number of hex characters it can be
MAX_SIGNAL_NAME_HEX = 128

# Bit width of each signal definition (padded to a multiple of 8)
SIGNAL_DEF_BIT_WIDTH = 80  # 75 bits padded to 80 bits (10 bytes)

# Check if the user has provided the DBC file path
if len(sys.argv) != 2:
    print("Usage: python script.py <path_to_dbc_file>")
    sys.exit(1)

# Get the DBC file path from command line arguments
dbc_file_path = sys.argv[1]

# Load the DBC file using cantools
try:
    # Load the DBC database
    db = cantools.database.load_file(dbc_file_path)
except Exception as e:
    print(f"Error loading DBC file: {e}")
    sys.exit(1)

# Initialize a list to hold the LUT entries
lut_entries = []

# Initialize a mapping for signal names to indices
signal_name_to_index = {}
index_to_signal_name = []
current_signal_index = 0

# Iterate over all messages in the DBC database
for message in db.messages:
    # Get the message ID (frame ID)
    message_id = message.frame_id

    # Initialize a list to hold signal definitions
    signal_definitions = []

    # Iterate over all signals in the message
    for signal in message.signals:
        # Extract signal parameters
        start_bit = signal.start
        length = signal.length
        is_signed = int(signal.is_signed)
        # 0 for little, 1 for big
        endianness = 0 if signal.byte_order == 'little_endian' else 1

        # Convert scale and offset to fixed-point representation
        scale = int(signal.scale * SCALE_FACTOR)
        offset = int(signal.offset * OFFSET_FACTOR)

        # Assign a unique index to the signal name
        signal_name = signal.name
        if signal_name not in signal_name_to_index:
            signal_name_to_index[signal_name] = current_signal_index
            index_to_signal_name.append(signal_name)
            current_signal_index += 1
        signal_name_index = signal_name_to_index[signal_name]

        # Signal Definition Format (total of 75 bits):
        """
        Bits 74 - 64: Signal Name Index (11 bits)
        Bits 63 - 57: Start Bit (7 bits)
        Bits 56 - 50: Length (7 bits)
        Bit 49: Is Signed (1 bit)
        Bit 48: Endianness (1 bit)
        Bits 47 - 24: Scale (24 bits)
        Bits 23 - 0: Offset (24 bits)
        """

        # Pack the signal definition into an integer
        signal_def = (
            ((signal_name_index & 0x7FF) << 64) |   # 11 bits for signal name index
            ((start_bit & 0x7F) << 57) |             # 7 bits for start_bit
            ((length & 0x7F) << 50) |                # 7 bits for length
            ((is_signed & 0x01) << 49) |             # 1 bit for is_signed
            ((endianness & 0x01) << 48) |            # 1 bit for endianness
            ((scale & 0xFFFFFF) << 24) |             # 24 bits for scale
            (offset & 0xFFFFFF)                      # 24 bits for offset
        )

        # Append the signal definition to the list
        signal_definitions.append(signal_def)

    # Check if there are any signals in the message
    if not signal_definitions:
        print(f"No valid signals found for message {message.name}")
        continue

    # Limit the number of signals to MAX_SIGNALS
    num_signals = len(signal_definitions)
    if num_signals > MAX_SIGNALS:
        print(f"Message {message.name} has more than {MAX_SIGNALS} signals. Truncating.")
        signal_definitions = signal_definitions[:MAX_SIGNALS]
        num_signals = MAX_SIGNALS

    # Construct the LUT entry
    lut_entry = {
        'message_id': message_id,
        'num_signals': num_signals,
        'signal_definitions': signal_definitions
    }

    lut_entries.append(lut_entry)

# Sort the LUT entries by message_id (CAN ID)
lut_entries.sort(key=lambda x: x['message_id'])

# Define the radix for the .coe files
radix = 16  # Using hexadecimal radix for compact representation

# Initialize the address pointer for signal definitions
signal_def_pointer = 0

# Open the files for msg_lut and signal_def_mem
msg_lut_file_path = 'msg_lut.coe'
signal_def_mem_file_path = 'signal_def_mem.coe'
msg_lut_file = open(msg_lut_file_path, 'w')
signal_def_mem_file = open(signal_def_mem_file_path, 'w')

# Write headers for the .coe files
msg_lut_file.write(f"memory_initialization_radix={radix};\n")
msg_lut_file.write("memory_initialization_vector=\n")

signal_def_mem_file.write(f"memory_initialization_radix={radix};\n")
signal_def_mem_file.write("memory_initialization_vector=\n")

# Write the size of the LUTs as the first entry
msg_lut_file.write(f"{format(len(lut_entries), '014X')},\n")
signal_def_mem_file.write(f"{format(sum(len(entry['signal_definitions']) for entry in lut_entries), '020X')},\n")

# Iterate over the LUT entries to write to the .coe files
for index, entry in enumerate(lut_entries):
    message_id = entry['message_id']
    num_signals = entry['num_signals']

    # Write to msg_lut.coe
    # Format: message_id (29 bits), num_signals (7 bits), signal_def_pointer (16 bits)
    # Total of 52 bits - pad with leading 0s to make it 56 bits (7 bytes)
    msg_lut_entry = (message_id << 23) | (num_signals << 16) | (signal_def_pointer & 0xFFFF)
    msg_lut_entry_hex = format(msg_lut_entry, '014X')
    if index != len(lut_entries) - 1:
        msg_lut_file.write(f"{msg_lut_entry_hex},\n")
    else:
        msg_lut_file.write(f"{msg_lut_entry_hex};\n")

    # Write signal definitions to signal_def_mem.coe
    for signal_def in entry['signal_definitions']:
        # Signal Definition is 75 bits. Pad with leading 0s to make it 80 bits (10 bytes)
        signal_def_hex = format(signal_def, '020X')
        signal_def_mem_file.write(f"{signal_def_hex},\n")
        signal_def_pointer += 1  # Increment pointer for each signal definition

# Close the files
msg_lut_file.close()
signal_def_mem_file.close()

print(f"LUT messages .coe file has been generated at: {msg_lut_file_path}")
print(f"Signal Definition .coe file has been generated at: {signal_def_mem_file_path}")

# Generate the signal names .coe file
signal_names_coe_path = 'signal_names.coe'
with open(signal_names_coe_path, 'w') as signal_names_coe:
    # Write the header information
    signal_names_coe.write(f"memory_initialization_radix={radix};\n")
    signal_names_coe.write("memory_initialization_vector=\n")

    # Write the size of the signal names LUT as the first entry
    signal_names_coe.write(f"{format(len(index_to_signal_name), f'0{MAX_SIGNAL_NAME_HEX}X')},\n")

    # For each signal name, write it to the .coe file
    for index, signal_name in enumerate(index_to_signal_name):
        # Convert signal name to ASCII codes, fixed length
        signal_name_ascii = [ord(c) for c in signal_name]
        # Convert to bytes
        signal_name_bytes = bytes(signal_name_ascii)
        # Convert to integer
        signal_name_int = int.from_bytes(signal_name_bytes, byteorder='big')
        # Determine the number of bits
        signal_name_bits = len(signal_name_bytes) * 8
        # Convert to hex string
        num_hex_digits = (signal_name_bits + 3) // 4
        signal_name_hex = format(signal_name_int, f'0{MAX_SIGNAL_NAME_HEX}X')

        if num_hex_digits > MAX_SIGNAL_NAME_HEX:
            signal_name_hex = signal_name_hex[num_hex_digits-MAX_SIGNAL_NAME_HEX:num_hex_digits]
            # Convert the truncated hex to a string for display
            # Convert to int
            signal_name_int = int(signal_name_hex, 16)
            # Convert to bytes
            # Determine the length of the bytes (each hex digit represents 4 bits)
            num_bytes = (len(signal_name_hex) + 1) // 2
            signal_name_bytes = signal_name_int.to_bytes(num_bytes, byteorder='big')
            # Convert bytes to ASCII string
            signal_name_truncated = signal_name_bytes.decode('ascii')

            print(signal_name)  # Output: "SIGNAL"
            print(f"Signal Name: {signal_name} was too long. Truncating to {signal_name_truncated}")

        # Write the value to the .coe file
        if index != len(index_to_signal_name) - 1:
            signal_names_coe.write(f"{signal_name_hex},\n")
        else:
            # If it is the last entry, put a semicolon after it
            signal_names_coe.write(f"{signal_name_hex};\n")

print(f"Signal names .coe file has been generated at: {signal_names_coe_path}")
print(f"Total number of signal names: {len(index_to_signal_name)}")