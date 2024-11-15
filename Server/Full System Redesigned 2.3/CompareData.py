import json
import os

# List of fields to ignore during comparison
ignored_fields = {"Timestamp", "Latency", "Arduino_Time", "Counter", "Lost_packages", "Percent_lost", "Blank",
                  "Blank1", "Blank2", "Blank3", "Blank4", "Blank5", "CRC_Checksum"}

# Use full paths to avoid FileNotFoundError
file_name1 = r"Server/Full System Redesigned 2.3/Golden_dict.json"    # Input the file path
file_name2 = r"Server/Full System Redesigned 2.3/Test_dict.json"

threshold = 0.001 # 0.1% tolerance

def is_close(a, b, threshold_percentage=threshold):
    # Calculate the absolute difference and check if it's within the threshold percentage of the absolute value
    if a == 0 and b == 0:
        return True  # Both are zero, considered equal
    elif a == 0 or b == 0:
        return False  # One is zero, the other is not
    else:
        difference = abs(a - b)
        relative_threshold = max(abs(a), abs(b)) * threshold_percentage
        return difference <= relative_threshold

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

def compare_dicts(d1, d2):
    # Recursively compare dictionaries with a threshold for numerical values
    if isinstance(d1, dict) and isinstance(d2, dict):
        if d1.keys() != d2.keys():
            return False
        return all(compare_dicts(d1[key], d2[key]) for key in d1)
    elif isinstance(d1, list) and isinstance(d2, list):
        if len(d1) != len(d2):
            return False
        return all(compare_dicts(item1, item2) for item1, item2 in zip(d1, d2))
    elif isinstance(d1, (int, float)) and isinstance(d2, (int, float)):
        return is_close(d1, d2)
    else:
        return d1 == d2

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

        # Compare the cleaned dictionaries with the thresholded comparison
        if compare_dicts(dict1_cleaned, dict2_cleaned):
            print("There were no errors in decoding")
        else:
            print("ERROR: Test dictionary does not match golden")
            print("Golden:")
            print(dict1_cleaned)
            print("Test:")
            print(dict2_cleaned)
