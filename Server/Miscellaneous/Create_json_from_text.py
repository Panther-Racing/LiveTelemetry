#!/usr/bin/env python

import json

infile = open('forjson.txt', 'r')
# json = open('finaljson.txt', 'a')
json_dict = {}

# Read all the lines in from the data file created by CAN_Translate
data = infile.readlines()
for line in data:
    # Remove the brackets from the string
    line = line.replace('{', '')
    line = line.replace('}', '')

    comma = line.find(',')
    while comma > 0:
        data_line = line[0:comma]
        data_line = data_line.replace('\'', '')
        colon = data_line.index(':')
        json_dict[data_line[0:colon]] = float(data_line[colon+2:])
        line = line[comma+2:]
        comma = line.find(',')

with open("json_data.json", "w") as outfile:
    json.dump(json_dict, outfile)
