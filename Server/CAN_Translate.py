#!/usr/bin/env python

import os
from binascii import hexlify
import can
import cantools
from pprint import pprint

db = cantools.database.Database()
db.add_dbc_file('fileName.dbc')

can_bus = can.interface.Bus('')
