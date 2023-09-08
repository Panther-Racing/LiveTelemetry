from custom_cantools import cantools


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
    print(bytes(data, 'utf-8'))
    to_send = b'\xff\x03\x00\x00\x00\x00\x00\x00'
    print(len(to_send))

    # Attempt Decoding test message and print result
    print(db.decode_message(frame_id_or_name=frame_id, data=to_send, decode_choices=False, scaling=True,
                      decode_containers=False, allow_truncated=False))


main()
