from custom_cantools import cantools
from datetime import datetime
import json
import time
import re

output_monitoring = open('Output.txt', 'w')
latency_file = open('total_latency.txt', 'w')

def start(receive_socket, socket):
    print('Starting CAN Translator')
    output_monitoring.write('Starting CAN Translator\n')
    global send_socket
    send_socket = socket
    setup()
    main(receive_socket)


def setup():
    global sel
    global db
    global CANSocket
    global serverIP
    global receivePort
    global bufferSize
    global nonLiterals
    global json_file_name
    bufferSize = 1024
    nonLiterals = set()
    json_file_name = 'json_data.json'

    # Add the DBC file to the CAN reader
    # cantools.database.load_file(filename, database_format=None, encoding=None, frame_id_mask=None,
    # prune_choices=False, strict=True, cache_dir=None, sort_signals=<function sort_signals_by_start_bit
    db = cantools.database.load_file('DBCS/Combined.dbc', database_format='dbc', encoding='cp1252', frame_id_mask=None,
                                     prune_choices=False, strict=True, cache_dir=None)

    # Reset the json file
    json_file = open(json_file_name, 'w')
    json_file.write('{}')


def find_nth(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
        start = haystack.find(needle, start + len(needle))
        n -= 1
    return start


# Translate each string from the decoded CAN message into a dictionary and then output that dictionary to the json file
def to_json(message, latencyAmount): 
    # print(message)
    with open(json_file_name, 'r+') as json_file:
        # # Traverse through the new dictionary and add time stamps
        # for key in message:
        #     data_value = message[key]
        #     message[key] = (time.time(), data_value)
        json_dict = json.load(json_file)
        print(f'json_dict {json_dict}')
        output_monitoring.write(f'dict {json_dict}\n\n')
        json_dict.update(message)
        # Add a value to hold the current time
        json_dict.update({'Timestamp': time.time()})
        json_dict.update({'Latency': latencyAmount.total_seconds()})
        json_file.close()
        open(json_file_name, 'w').close()
        json_file = open(json_file_name, 'r+')
        json.dump(json_dict, json_file)
        send_json(json_dict)


def reformatter(data_string):
    # print(data_string)
    start_pos = 0
    current_space = 0
    next_space = 0
    i = 0
    data_reformatted = ''
    data_string = str(data_string)
    print(data_string)
    while next_space >= 0:
        next_space = find_nth(data_string, ' ', i + 1)
        # print(next_space)
        # print(next_space-current_space)
        if next_space - current_space == 1:
            data_reformatted += ('\\x0' + data_string[start_pos:next_space])
        elif next_space - current_space == 2:
            data_reformatted += ('\\x' + data_string[start_pos:next_space])
        else:
            data_reformatted += ('\\x0' + data_string[start_pos:])
        # print('looking for more spaces')
        i += 1
        current_space = next_space + 1
        start_pos = current_space

    data_bytes = convert_to_bytes_with_escape(data_reformatted)

    return data_bytes


def convert_to_bytes_with_escape(input_string):
    hex_values = input_string.split('\\x')[1:]  # Split by '\\x' and skip the empty first element
    byte_string = bytes(int(value, 16) for value in hex_values)
    return byte_string


def data_handler(data):
    # Extract the message from the socket
    message = data.decode().strip()
    output_monitoring.write(f"message: {message}\n")

    date_time_str = message.split(',')[-1]
    date_time_obj = datetime.strptime(date_time_str, "%H:%M:%S %d/%m/%Y")

    latency = datetime.now - date_time_obj
    message = message.rsplit(',', 1)[0]  # Rewrite message to everything before the last comma (to keep rest of the code consistent when decoding)

    # Separate CAN message into id and data
    # Except non hexadecimal values
    try:
        frame_id = int(message[find_nth(message, ',', 1) + 1:find_nth(message, ',', 2)], 16)
    except ValueError as error:
        # print('Non hexadecimal frame_id: %s' % error)
        nonLiterals.add(str(error))
        frame_id = 'ERROR'

    # print(message)
    print(f'Frame ID: {frame_id}     data: {data}')
    # output_monitoring.write(f'Frame ID: {frame_id}           data: {data}')

    data_string = message[find_nth(message, ',', 2) + 1:]
    # data_string = data_string.replace(' ', '')
    data = bytes(data_string, 'utf-8')

    data_reformatted = reformatter(data_string)

    to_send = data_reformatted
    # print(to_send)
    output_monitoring.write(f"{to_send}{latency.total_seconds()}\n")

    try:
        # Decode each incoming message
        to_json(db.decode_message(frame_id_or_name=frame_id, data=to_send, decode_choices=False, scaling=True,
                                  decode_containers=False, allow_truncated=False), latency)
    except KeyError as error:
        print('Key error: %s' % error)
        output_monitoring.write('Key error: %s \n' % error)
    except ValueError as error:
        print(error)
    except Exception as error:
        print(error)
    
    latency = datetime.now - date_time_obj
    latency_file.write(f'Total Latency: {latency}\n')



def send_json(json_string):
    json_result = json.dumps(json_string)

    try:
        send_socket.send(json_result.encode())
    except ConnectionResetError as error:
        print(error)

    # print(json_result, 'was sent!')
    # time.sleep(1)


def reverse(data_string):
    # print(data_string)

    length = len(data_string)
    i = int(length/4)
    reverse_string = ''
    while i > 0:
        startpos = find_nth(data_string, '\\', i)
        reverse_string += data_string[startpos:startpos+4]
        i -= 1
    # print(reverse_string)

    return reverse_string


def main(receive_socket):
    while True:
        data_handler(receive_socket.recv())
