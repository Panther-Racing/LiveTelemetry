import json
import os
import time
import cantools
import asyncio


class CANTranslator:
    def __init__(self, db):
        self.first_message = True
        self.offset = 0
        self.db = db
        self.json_dict = {}

    async def data_handler(self, data):
        message = data.decode().strip()
        date_time_str = message.split(',')[-1]
        arduino_time_raw = int(date_time_str)

        if self.first_message:
            self.offset = time.time() * 1000 - arduino_time_raw
            self.first_message = False

        arduino_time = arduino_time_raw + self.offset

        latency = time.time() * 1000 - arduino_time
        # print(f'arduino time: {arduino_time}\tserver time: {time.time()*1000}\tlatency: { latency }\toffset: { self.offset }')
        message = message.rsplit(',', 1)[0]

        try:
            frame_id = int(message[await CANTranslator.find_nth(message, ',', 1) + 1:await CANTranslator.find_nth(message, ',', 2)], 16)
        except ValueError as error:
            frame_id = 'ERROR'

        # print(f'Frame ID: { frame_id }     data: { data }')

        data_string = message[await CANTranslator.find_nth(message, ',', 2) + 1:]
        data_reformatted = await CANTranslator.reformatter(self, data_string)

        try:
            print('Decoding...')
            decoded = self.db.decode_message(frame_id_or_name=frame_id, data=data_reformatted, decode_choices=False, scaling=True,
                                             decode_containers=False, allow_truncated=False)
            print('Decoded')
            return await CANTranslator.to_json(self, decoded, latency / 1000, arduino_time)

        except KeyError as error:
            print('Key error: %s' % error)
        except ValueError as error:
            print('Value error: %s' % error)
        except Exception as error:
            print('Other Error:')
            print(error)

    @staticmethod
    async def find_nth(haystack, needle, n):
        start = haystack.find(needle)
        while start >= 0 and n > 1:
            start = haystack.find(needle, start + len(needle))
            n -= 1
        return start

    @staticmethod
    async def reformatter(self, data):
        result = []
        # Remove any spaces from the end of the data
        data = data.strip()
        for i in range(0, len(data), 2):
            result.append(await CANTranslator.convert_to_bytes_with_escape('\\x' + data[i:i + 2]))
        return b''.join(result)

    @staticmethod
    async def convert_to_bytes_with_escape(input_string):
        hex_values = input_string.split('\\x')[1:]  # Split by '\\x' and skip the empty first element
        # print(f'hex values: {hex_values}')
        byte_string = bytes(int(value, 16) for value in hex_values)
        return byte_string

    async def to_json(self, decoded, latency, arduino_time):
        # Update the JSON dictionary with the new data
        self.json_dict.update(decoded)
        self.json_dict.update({'Timestamp': time.time() * 1000})
        self.json_dict.update({'Latency': latency})
        self.json_dict.update({'Arduino_Time': arduino_time})

        # return the json dictionary
        return self.json_dict