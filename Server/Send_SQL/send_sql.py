import pyodbc
import json

# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = '20.81.190.176'
database = 'Live Telemetry'
username = 'raheelfarouk'
password = 'li.telServer;'
# ENCRYPT defaults to yes starting in ODBC Driver 18. It's good to always specify ENCRYPT=yes on the client side to avoid MITM attacks.
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';ENCRYPT=yes;UID='+username+';PWD='+ password+'TrustServerCertificate=yes;')
cursor = conn.cursor()

# Test JSON String
json_string = '{"Differential_Temperature_Front": 2.1, "Differential_Temperature_Centre": 2.3, "Differential_Temperature_Rear": 5.4}'

# Load the JSON data from the string
json_data = json.loads(json_string)

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

# Insert the variables and their values into the database using the Pyodbc cursor
cursor = conn.cursor()
cursor.execute(sql_query.format(', '.join(column_names), placeholders), column_values)
conn.commit()

# Close the database connection
conn.close()


print('Sent')

