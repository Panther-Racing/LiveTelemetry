%Get CAN Data and open DBC file too
canData=readmatrix("CANDataNew2.csv")
canDB = canDatabase("Data.dbc")

%CAN message timetable
msgTimetable = canMessageTimetable(canData, canDB)