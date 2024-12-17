import json

def replace_indices_and_create_dict(output_file, signal_names_file, result_file, dict_file):
    # Load signal names into a list
    with open(signal_names_file, 'r') as f:
        signal_names = [line.strip() for line in f]

    # Dictionary to store name-value pairs
    name_value_dict = {}

    # Read decoded output and replace indices with signal names
    with open(output_file, 'r') as f_in, open(result_file, 'w') as f_out:
        for line in f_in:
            index, value = map(str, line.split())
            signal_name = signal_names[int(index)] if int(index) < len(signal_names) else "UNKNOWN"
            f_out.write(f"{signal_name}: {value}\n")
            name_value_dict[signal_name] = float(value)

    # Write the dictionary to a JSON file
    with open(dict_file, 'w') as json_file:
        json.dump(name_value_dict, json_file, indent=4)

    print(f"Replaced indices and saved result to {result_file}")
    print(f"Dictionary of name-value pairs saved to {dict_file}")

if __name__ == "__main__":
    replace_indices_and_create_dict(
        "decoded_output.txt",    # Input file with indices and values
        "signal_names.txt",      # File containing signal names
        "final_output.txt",      # Human-readable output file
        "name_value_dict.json"   # JSON file for the name-value dictionary
    )
