import json

def calculate_latency_diff(latency_in_file, latency_out_file, latency_diff_file):
    with open(latency_in_file, 'r') as in_file, open(latency_out_file, 'r') as out_file, open(latency_diff_file, 'w') as diff_file:
        in_data = json.load(in_file)
        out_data = json.load(out_file)

        for message_in in in_data:
            in_timestamp = message_in['Time']
            for message_out in out_data:
                if message_out['Time'] >= in_timestamp and message_out['Message'] == message_in['Message']:
                    latency_diff = message_out['Time'] - in_timestamp
                    diff_file.write(f"Message: {message_in['Message']}, Latency Difference: {latency_diff}\t {message_out['Error']}\n")
                    break
            else:
                diff_file.write(f"Message: {message_in['Message']}, Error: Message not found in {latency_out_file}\n")

        # for message_out in out_data:
        #     for message_in in in_data:
        #         if message_out['Message'] == message_in['Message']:
        #             break
        #     else:
        #         diff_file.write(f"Message: {message_out['Message']}, Error: Message not found in {latency_in_file}\n")

# Usage example
calculate_latency_diff('latencyIn.json', 'latencyOut.json', 'latencyDiff.txt')
