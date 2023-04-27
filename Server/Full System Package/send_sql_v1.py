import pyodbc
import json


def start(sock):
    print('Starting')
    setup()
    main(sock)

    # Close the database connection
    conn.close()


def setup():
    global conn
    server = '20.81.190.176'
    database = 'Live Telemetry'
    username = 'raheelfarouk'
    password = 'li.telServer;'
    # ENCRYPT defaults to yes starting in ODBC Driver 18. It's good to always specify ENCRYPT=yes on the client side to avoid MITM attacks.
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';ENCRYPT=yes;UID='+username+';PWD='+ password+'TrustServerCertificate=yes;')


def main(sock):
    while True:
        json_received = sock.recv()
        print('Json received -->', json_received.decode().replace('\\', ''))
        send_data(json_received)


def send_data(json_received):
    try:
        # Load the JSON data from the string
        json_data = json.loads(json_received)
    except json.decoder.JSONDecodeError as error:
        print('ERROR1', error)

    # Define the SQL query
    sql_query = "INSERT INTO dbo.race_data ({}) VALUES ({})"

    # Build the list of column names and values for the SQL query
    column_names = []
    column_values = []

    for key, value in json_data.items():
        column_names.append(key)
        column_values.append(value)

    # Build the placeholders for the SQL query
    placeholders = ', '.join(['?'] * len(column_names))

    try:
        # Insert the variables and their values into the database using the Pyodbc cursor
        cursor = conn.cursor()
        cursor.execute(sql_query.format(', '.join(column_names), placeholders), column_values)
        conn.commit()
    except pyodbc.ProgrammingError as error:
        print('ERROR2', error)

    print('Sent')

    # time.sleep(1)
