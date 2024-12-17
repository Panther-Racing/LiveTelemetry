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

        # Calculate byte-aligned positions and re-map start_bit
        byte_index = start_bit // 8             # Which byte the signal starts in
        bit_within_byte = 7 - (start_bit % 8)   # Motorola bit position within the byte
        start_bit = (byte_index * 8) + bit_within_byte

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

        if message_id == 54:
            print(f'Signal: {signal_name}: start_bit: {start_bit}, length: {length}, endianness: {endianness}, scale: {scale}, offset: {offset}')

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
    # Total of 52 bits - pad with leading 0s to make it 56 bits (7 bytes)
    """
        Bits 51 - 23: Message ID (29 bits)
        Bits 22 - 16: Number of Signals (7 bits)
        Bits 15 - 0: Signal Definition Pointer (16 bits)
    """

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

# Generate the signal names .txt file
signal_names_txt_path = 'signal_names.txt'
with open(signal_names_txt_path, 'w') as signal_names_txt:
    # For each signal name, write it to the .txt file in order of the signals so that the name pointer is correct
    for index, signal_name in enumerate(index_to_signal_name):
        signal_names_txt.write(f'{signal_name}\n')

print(f'Signal names .txt file has been generated at: {signal_names_txt_path}')
print(f'Total number of signal names: {len(index_to_signal_name)}')