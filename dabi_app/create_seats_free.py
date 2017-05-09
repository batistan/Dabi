import datetime as dt
for i in range(1, 20):
    start_month = dt.datetime(2017, 5, i)
    for i in range(1, 27):
        for j in range(1001, 1026):
			print("INSERT INTO Seats_free values (%d,%d,'%s',%d);\n"%(i,j,start_month.strftime("%Y-%m-%d"),448))