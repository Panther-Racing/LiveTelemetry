import subprocess
import time

def start_node_red():
    while True:
        try:
            # Replace 'node-red' with the actual command to start Node-RED if it's different
            subprocess.run(["node-red"], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Node-RED crashed with error: {e}")
            print("Restarting Node-RED...")
            time.sleep(5)  # Wait for 5 seconds before restarting

if __name__ == "__main__":
    start_node_red()
