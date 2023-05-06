import cantools
import json
import time
import re


def start(receive_socket, socket):
    print('Starting CAN Translator')
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
    db = cantools.database.Database()
    db.add_dbc_file('DBCS/DBC1.dbc')

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
    with open(json_file_name, 'r+') as json_file:
        # # Traverse through the new dictionary and add time stamps
        # for key in message:
        #     data_value = message[key]
        #     message[key] = (time.time(), data_value)
        json_dict = json.load(json_file)
        # print(json_dict)
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

    data = bytes(message[find_nth(message, ',', 2)+1:], 'utf-8')
    print(message)
    print(f'Frame ID: {frame_id}     data: {data}')

    data_string = message[find_nth(message, ',', 2)+1:]

    # Remove any non-hex characters from the hexadecimal data
    # data_string = re.sub(r"\s|[^a-fA-F\d]", "", data_string)

    print(data_string)

    try:
        reversed_data = bytes.fromhex(data_string)[::-1]
    except ValueError as error:
        print(error)
        default = {0, 0, 0, 0, 0, 0, 0, 0}
        reversed_data = bytes(default)


    try:
        # Decode each incoming message
        to_json(db.decode_message(frame_id, reversed_data))
    except KeyError as error:
        print('Key error: %s' % error)
    except ValueError as error:
        print(error)


def send_json(json_string):
    json_result = json.dumps(json_string)

    try:
        send_socket.send(json_result.encode())
    except ConnectionResetError as error:
        print(error)

    # print(json_result, 'was sent!')
    # time.sleep(1)


def main(receive_socket):
    while True:
        data_handler(receive_socket.recv())

