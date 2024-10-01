import json
import os

# Use full paths to avoid FileNotFoundError
file_name1 = r"Golden_dict.json" #Input the file path
file_name2 = r"Test_dict.json" 

# Check if files exist
if not os.path.isfile(file_name1):
    print(f"Error: {file_name1} not found.")
elif not os.path.isfile(file_name2):
    print(f"Error: {file_name2} not found.")
else:
    dict1 = {}
    dict2 = {}

    # Load the JSON files
    with open(file_name1, "r") as golden_dict:
        dict1 = json.load(golden_dict)

    with open(file_name2, "r") as test1:
        dict2 = json.load(test1)

    # Compare the dictionaries
    if dict1 == dict2:
        print("There were no errors in decoding")
    else:
        print("There were errors in decoding")
