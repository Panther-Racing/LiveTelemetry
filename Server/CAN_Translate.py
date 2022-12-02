#!/usr/bin/env python

# import os
# from binascii import hexlify
import can
import cantools
# from pprint import pprint
# import can_decoder

# db = can_decoder.load_dbc('DBC2.dbc')
# decoder = can_decoder.DataFrameDecoder(db)

# can.rc['interface'] = 'socketcan'
# can.rc['channel'] = 'vcan0'
# can_bus = can.interface.Bus()


db = cantools.database.Database()
db.add_dbc_file('DBC1.dbc')
