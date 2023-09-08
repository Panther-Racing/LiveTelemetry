from custom_cantools import cantools


def convert_to_bytes_with_escape(input_string):
    hex_values = input_string.split('\\x')[1:]  # Split by '\\x' and skip the empty first element
    byte_string = bytes(int(value, 16) for value in hex_values)
    return byte_string


def main():
    print('Starting')

    # Add the DBC file to the CAN reader
    # cantools.database.load_file(filename, database_format=None, encoding=None, frame_id_mask=None,
    # prune_choices=False, strict=True, cache_dir=None, sort_signals=<function sort_signals_by_start_bit
    db = cantools.database.load_file('DBCS/DBC_test.dbc', database_format='dbc', encoding='cp1252', frame_id_mask=None,
                                     prune_choices=False, strict=True, cache_dir=None)

    # Use custom message with known output
    frame_id = 1
    data = '\\xff\\x03\\x00\\x00\\x00\\x00\\x00\\x00'

    byte_string = convert_to_bytes_with_escape(data)

    print(byte_string)
    to_send = b'\xff\x03\x00\x00\x00\x00\x00\x00'
    to_send = byte_string
    print(len(to_send))

    # Attempt Decoding test message and print result
    print(db.decode_message(frame_id_or_name=frame_id, data=to_send, decode_choices=False, scaling=True,
                      decode_containers=False, allow_truncated=False))


main()
