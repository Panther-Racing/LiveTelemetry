import json
import time
import cantools
import queue

class CANTranslator:
    def __init__(self, db):
        self.first_message = True
        self.offset = 0
        self.db = db

    def data_handler(self, data, json_file_name, processed_data):
        message = data.decode().strip()
        date_time_str = message.split(',')[-1]
        arduino_time_raw = int(date_time_str)

        if self.first_message:
            self.offset = time.time() * 1000 - arduino_time_raw
            self.first_message = False

        arduino_time = arduino_time_raw + self.offset

        latency = time.time() * 1000 - arduino_time
        print(f'latency: {latency}\toffset: {self.offset}')
        message = message.rsplit(',', 1)[0]

        try:
            frame_id = int(message[CANTranslator.find_nth(message, ',', 1) + 1:CANTranslator.find_nth(message, ',', 2)], 16)
        except ValueError as error:
            frame_id = 'ERROR'

        print(f'Frame ID: {frame_id}     data: {data}')

        data_string = message[CANTranslator.find_nth(message, ',', 2) + 1:]
        data_reformatted = CANTranslator.reformatter(self, data_string)

        try:
            decoded = self.db.decode_message(frame_id_or_name=frame_id, data=data_reformatted, decode_choices=False, scaling=True,
                                             decode_containers=False, allow_truncated=False)
            print(f'decoded: {decoded}')
            CANTranslator.to_json(decoded, latency / 1000, json_file_name, processed_data, arduino_time)

        except KeyError as error:
            print('Key error: %s' % error)
        except ValueError as error:
            print('Value error: %s' % error)

    @staticmethod
    def find_nth(haystack, needle, n):
        start = haystack.find(needle)
        while start >= 0 and n > 1:
            start = haystack.find(needle, start + len(needle))
            n -= 1
        return start

    @staticmethod
    def reformatter(self, data_string):
        start_pos = 0
        current_space = 0
        next_space = 0
        i = 0
        data_reformatted = ''
        data_string = str(data_string)
        while next_space >= 0:
            next_space = self.find_nth(data_string, ' ', i + 1)
            if next_space - current_space == 1:
                data_reformatted += ('\\x0' + data_string[start_pos:next_space])
            elif next_space - current_space == 2:
                data_reformatted += ('\\x' + data_string[start_pos:next_space])
            else:
                data_reformatted += ('\\x0' + data_string[start_pos:])
            i += 1
            current_space = next_space + 1
            start_pos = current_space

        data_bytes = self.convert_to_bytes_with_escape(data_reformatted)

        return data_bytes

    @staticmethod
    def to_json(decoded, latency, json_file_name, processed_data, arduino_time):
        with open(json_file_name, 'r+') as json_file:

            # Read the file content
            try:
                json_file.seek(0)
                content = json_file.read().strip()
                if content:
                    json_file.seek(0)
                    json_dict = json.load(json_file)
                else:
                    json_dict = {}
            except json.decoder.JSONDecodeError:
                print("Error decoding JSON from the file. Initializing with an empty dictionary.")
                json_dict = {}

            # Update the JSON dictionary with the new data
            json_dict.update(decoded)
            json_dict.update({'Timestamp': time.time() * 1000})
            json_dict.update({'Latency': latency})
            json_dict.update({'Arduino_Time': arduino_time})

            # Move the file pointer to the beginning and truncate the file
            json_file.seek(0)
            json_file.truncate()

            # Write the updated JSON data back to the file
            json.dump(json_dict, json_file)

            # Push the updated JSON data to the processed_data queue
            try:
                processed_data.put_nowait(json.dumps(json_dict))
                print(f'processed data queue has {processed_data.qsize()} items in it')
            except queue.Full as error:
                print('Data discarded, decoded data queue full')
