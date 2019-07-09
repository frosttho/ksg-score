# coding=utf8

###################################################
#                 HtmlGenerate                    #
#                                                 #
#                Teil des Pakets                  #
#                    KSG score                    #
#                                                 #
#              (c) 2019, KSG Media                #
#                                                 #
#                 in Anlehnung an                 #
#       http://elektormagazine.de/articles/       #
#  darstellung-serieller-daten-auf-einer-webseite #
#                                                 #
#               https://ksg-media.de              #
#           thomas.frost@ksg-media.de             #
###################################################


import serial
import time

file_name = "clock.html" # Once created, open this file in a browser.

# Adapt serial port nr. & baud rate to your system.
# serial_port = 'COM15'
# baudrate = 115200

page_title = "AutoRefresh Page";

def write_page(data_list):
    fo = open(file_name,"w+")
    # Start of HTML page.
    #fo.write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'>")
    #fo.write("<html><head><title>"+page_title+"</title>") # Page & Head begin.
    #fo.write("<meta http-equiv='refresh' content='1'>")
    #fo.write("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>")
    #fo.write("<link rel='shortcut icon' href='favicon.ico' />")
    #fo.write("<link rel='icon' type='image/x-icon' href='favicon.ico' />")
    #fo.write("<link rel='icon' type='image/png' href='favicon.png' />")
    #fo.write("</head><body><center><p>"+page_title+"</p>") # Head end, body begin.

    # Table begin.
    fo.write(data_list)
    #fo.write("<table border='1' border-spacing='5' style='text-align:center;'>")
    #fo.write("<tr><th>ID</th><th>Value</th></tr>")
    # for i in range(0,len(data_list),2):
    #     fo.write("<tr>") # Table row begin.
    #     fo.write("<td>"+data_list[i]+"</td>") # Table column 1.
    #     fo.write("<td>") # Table column 2 begin.
    #     fo.write("<font color='")
    #     # Values >= 500 will be printed in green, smaller values will be red.
    #     if (int(data_list[i+1])>=500): fo.write("green")
    #     else: fo.write("red")
    #     fo.write("'>")
    #     fo.write(data_list[i+1])
    #     fo.write("</font></td>") # Table column 2 end.
    #     fo.write("</tr>") # Table row end.
    #fo.write("</table>") # Table end.
    #fo.write("</body>") # Body end.
    #fo.write("</html>") # Page end.
    # Done, close file.
    fo.close()

# s = serial.Serial(serial_port,baudrate) # Open serial port.
# s.dtr = 0 # Reset Arduino.
# s.dtr = 1
print("Waiting for data...");
time.sleep(2) # Wait for Arduino to finish booting.
# s.reset_input_buffer() # Delete any stale data.

while 1:
    # data_str = s.readline().decode() # Read data & convert bytes to string type.
    # Clean up input data.
    # Expected format: "$,id1,value1,id2,value2,...,CRLF"
    # data_str = data_str.replace(' ','') # Remove whitespace.
    # data_str = data_str.replace('\r','') # Remove return.
    # data_str = data_str.replace('\n','') # Remove new line.
    # data_str += '123,65,1,999,cpv,236' # Add some more data
    # print(data_str)
    # Split data in fields separated by ','.
    # data_list = data_str.split(",")
    # del data_list[0] # Remove '$'
    # Write HTML page.
    data_list = input("Ihre Eingabe? ")
    write_page(data_list)
