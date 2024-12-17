def calculate_actual_bit_positions(signals):
    """
    Convert Motorola (big-endian) start bit and length into absolute start positions
    (starting at bit 0) and re-map lengths to align with expected signal positions in the CAN frame.

    :param signals: List of dictionaries with signal name, start_bit, and length.
    :return: List of dictionaries with re-mapped signal start_bit and length.
    """
    results = []
    for signal in signals:
        motorola_start = signal["start_bit"]
        length = signal["length"]

        # Calculate byte-aligned positions and re-map start_bit
        byte_index = motorola_start // 8  # Which byte the signal starts in
        bit_within_byte = 7 - (motorola_start % 8)  # Motorola bit position within the byte
        absolute_start = (byte_index * 8) + bit_within_byte

        results.append({
            "name": signal["name"],
            "start_bit": absolute_start,
            "length": length,
        })
    return results


# Example usage
if __name__ == "__main__":
    # Signals from the DBC
    signals = [
        {"name": "CellId", "start_bit": 7, "length": 8},
        {"name": "CellVoltage", "start_bit": 15, "length": 16},
        {"name": "CellBalancing", "start_bit": 31, "length": 1},
        {"name": "CellResistance", "start_bit": 30, "length": 15},
        {"name": "CellOpenVoltage", "start_bit": 47, "length": 16},
        {"name": "Checksum", "start_bit": 63, "length": 8},
    ]

    # Calculate actual bit positions
    remapped_signals = calculate_actual_bit_positions(signals)

    # Print results
    for signal in remapped_signals:
        print(f"Signal: {signal['name']}, Start Bit: {signal['start_bit']}, Length: {signal['length']}")
