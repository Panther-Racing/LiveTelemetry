#!/usr/bin/env python

import json

infile = open('forjson.txt', 'r')
json = open('finaljson.txt', 'a')

# Read all the lines in from the data file created by CAN_Translate
data = infile.readlines()
for line in data:
    # Remove the brackets from the string
    line = line.replace('{', '')
    line = line.replace('}', '')

    comma = line.find(',')
    while comma > 0:
        json.write(line[0:comma])
        json.write('\n')
        line = line[comma+2:]
        comma = line.find(',')

    print(line.strip())

