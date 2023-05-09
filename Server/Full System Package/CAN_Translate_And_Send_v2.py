import cantools
import json
import time
import can_decoder


def start(receive_socket, socket):
    print('Starting CAN Translator')
    global send_socket
    send_socket = socket
    setup()
    main(receive_socket)


def setup():
    global sel
    global CANSocket
    global serverIP
    global receivePort
    global bufferSize
    global nonLiterals
    global json_file_name
    global decoder
    bufferSize = 1024
    nonLiterals = set()
    json_file_name = 'json_data.json'

    # Add the DBC file to the CAN reader
    db = can_decoder.load_dbc('DBCS/DBC3.dbc')
    decoder = can_decoder.dataframe.DataFrameDecoder(db)

    # Reset the json file
    json_file = open(json_file_name, 'w')
    json_file.write('{}')


def find_nth(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
        start = haystack.find(needle, start+len(needle))
        n -= 1
    return start


# Translate each string from the decoded CAN message into a dictionary and then output that dictionary to the json file
def to_json(message):
    print(message)
    with open(json_file_name, 'r+') as json_file:
        # # Traverse through the new dictionary and add time stamps
        # for key in message:
        #     data_value = message[key]
        #     message[key] = (time.time(), data_value)
        json_dict = json.load(json_file)
        print(json_dict)
        json_dict.update(message)
        #Add a value to hold the current time
        json_dict.update({'Timestamp': time.time()})
        json_file.close()
        open(json_file_name, 'w').close()
        json_file = open(json_file_name, 'r+')
        json.dump(json_dict, json_file)
        send_json(json_dict)


def data_handler(data):
    # Extract the message from the socket
    message = data.decode().strip()

    # Separate CAN message into id and data
    # Except non hexadecimal values
    try:
        frame_id = int(message[find_nth(message, ',', 1)+1:find_nth(message, ',', 2)], 16)
    except ValueError as error:
        # print('Non hexadecimal frame_id: %s' % error)
        nonLiterals.add(str(error))
        frame_id = 'ERROR'

    print(message)
    print(f'Frame ID: {frame_id}     data: {data}')

    data_string = message[find_nth(message, ',', 2)+1:]
    data_string = data_string.replace(' ', '')
    data = bytes(data_string, 'utf-8')

    reversed_data = reverse(data_string)
    reversed_data = bytes(reversed_data, 'utf-8')
    frame_byte1 = int(frame_id[0:2])
    frame_byte2 = int(frame_id[2:] + '0')
    current_space = -1
    next_space = 0
    i = 0
    data_bytes = []
    while next_space >= 0:
        next_space = find_nth(data_string, ' ', i)
        if next_space - current_space == 1:
            data_bytes.append(int('0' + data_string[current_space+1:next_space]))
        elif next_space - current_space == 2:
            data_bytes.append(int(data_string[current_space+1:next_space]))
        else:
            print('Error dealing with spaces')
        i += 1
        current_space = next_space

    formatted_data = bytes([frame_byte1, frame_byte2, data_bytes[0], data_bytes[1], data_bytes[2], data_bytes[3],
                            data_bytes[4], data_bytes[5], data_bytes[6], data_bytes[7]])

    try:
        # Decode each incoming message
        to_json(decoder.decode_frame(formatted_data))
    except KeyError as error:
        print('Key error: %s' % error)
    except ValueError as error:
        print(error)
    except Exception as error:
        print(error)


def send_json(json_string):
    json_result = json.dumps(json_string)

    try:
        send_socket.send(json_result.encode())
    except ConnectionResetError as error:
        print(error)

    # print(json_result, 'was sent!')
    # time.sleep(1)


def reverse(data_string):

    print(data_string)

    length = len(data_string)
    i = length
    reverse_string = ''
    if length % 2 == 0:
        i -= 1
        reverse_string = '0' + data_string[i:]

    while i >= 0:
        i -= 2
        reverse_string += data_string[i:i+2]

    reverse_string = reverse_string.replace(' ', '')
    print(reverse_string)

    return reverse_string



def main(receive_socket):
    while True:
        data_handler(receive_socket.recv())

