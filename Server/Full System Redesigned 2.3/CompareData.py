import json
import os

# List of fields to ignore during comparison
ignored_fields = {"Timestamp", "Latency", "Arduino_Time", "Counter", "Lost_packages", "Percent_lost", "Blank",
                  "Blank1", "Blank2", "Blank3", "Blank4", "CRC_Checksum"}

# Use full paths to avoid FileNotFoundError
file_name1 = r"Golden_dict.json"    #Input the file path
file_name2 = r"Test_dict.json"


def remove_ignored_fields(d):
    # Recursively remove ignored fields from the dictionaries
    if isinstance(d, dict):
        return {
            key: remove_ignored_fields(value)
            for key, value in d.items()
            if key not in ignored_fields
        }
    elif isinstance(d, list):
        return [remove_ignored_fields(item) for item in d]
    elif isinstance(d, (int, float)):  # Normalize numbers to float for comparison
        return float(d)
    else:
        return d


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

        # Remove ignored fields from both dictionaries
        dict1_cleaned = remove_ignored_fields(dict1)
        dict2_cleaned = remove_ignored_fields(dict2)

        # Compare the cleaned dictionaries
        if dict1_cleaned == dict2_cleaned:
            print("There were no errors in decoding")
        else:
            print("ERROR: Test dictionary does not match golden")
            print("Golden:")
            print(dict1_cleaned)
            print("Test:")
            print(dict2_cleaned)
