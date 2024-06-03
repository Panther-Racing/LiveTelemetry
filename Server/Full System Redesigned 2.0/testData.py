import socket
import time


def send_byte_string(ip, port, base_message, interval=0.01):
    """
    Sends the specified base message with the current time appended to the given IP address and port over UDP repeatedly.

    :param ip: The IP address to send the message to.
    :param port: The port number to send the message to.
    :param base_message: The base message to send, before appending the current time.
    :param interval: The interval (in seconds) between sending each message. Default is 1 second.
    """
    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    try:
        while True:
            # Append the current time in seconds to the base message
            current_time = str(int((time.time()-1717378803)*1000))
            message = f"{base_message},{current_time}".encode()
            # Send the message
            sock.sendto(message, (ip, port))
            print(f"Sent: {message} to {ip}:{port}")
            # Wait for the specified interval before sending again
            time.sleep(interval)
    except KeyboardInterrupt:
        print("Stopped sending message.")
    finally:
        # Close the socket
        sock.close()


if __name__ == "__main__":
    ip_address = "20.81.190.176"  # Replace with the target IP address
    port = 20001  # Target port number
    base_message = '8,a0,28 0 28 0 28 0 28 0'  # Base message before appending the current time

    send_byte_string(ip_address, port, base_message)
