import sqlite3 as sql
import json
import collections
import os
from datetime import datetime

# This file is basically how the webserver interfaces with the database
# we'll have to replace these with our own functions working on our own database
# for now I'm leaving them here for reference


'''
create new passenger
'''
def create_passenger(p_lname,p_fname,p_address,p_email):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("INSERT INTO Passengers (passenger_lname,passenger_fname,passenger_billing_address,passenger_email) VALUES (?,?,?,?);", (p_lname, p_fname,p_address,p_email))
        con.commit()
        cur.execute("SELECT LAST_INSERT_ID();")
        return cur.fetchall()[0][0]

'''create ticket
'''
def create_ticket(start_station,end_station,train_num,trip_date_time,passenger_id, fare, round_trip, return_train, return_date_time):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        q=("INSERT INTO Tickets(trip_starts, trip_ends, trip_train, trip_date, passenger_id," 
            "round_trip, return_train, return_date, fare)"
            " VALUES "
            " (?,?,?,?,?,?,?,?,?);"
            )
        cur.execute(q,(start_station,end_station,train_num,trip_date_time,passenger_id,round_trip,return_train,return_date_time,fare))
        con.commit()
        cur.execute("SELECT LAST_INSERT_ROWID();")
        return cur.fetchall()[0][0]

'''
 update free seats for all segments in the given trip
'''
def update_free_seats(start_station,end_station,train_num,date):
    if(start_station>end_station): start_station,end_station=end_station,start_station
    ## this will be done in mysql but we can't do stored procedures in sqlite so... :/
    next_station=start_station+1
    while(next_station<=end_station):
        with sql.connect("database.db") as con:
            q = ("update Seats_free "
                "SET sf_seats_free = sf_seats_free-1 "
                "WHERE sf_train_num=? AND sf_date=? AND " 
                "sf_seg_id in (SELECT segment_id FROM Segments WHERE " 
                "(segment_north=? AND segment_south=?) OR (segment_south=? AND segment_north=?)); "
                )
            cur = con.cursor()
            cur.execute(q,(train_num, date, start_station, next_station, start_station, next_station))
            con.commit()
        start_station=next_station
        next_station+=1


'''
for filing dropdowns etc in templates
'''

def get_all_trains():
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT train_num from Trains ;")
        return [ t[0] for t in list(cur.fetchall())]     

def get_all_stations():
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT station_name,station_code from Stations;")
        s_list = list(cur.fetchall())
        all_stations = []
        for s in s_list:
            station={}
            station["station_name"] = s[0]
            station["station_code"] = s[1]
            all_stations.append(station)
        return all_stations

def get_train_seats(train_num,train_date):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        q=("select sf.sf_seats_free, sg.segment_north,sg.segment_south from Seats_free sf JOIN "
         "segments sg on sf.sf_seg_id=sg.segment_id AND sf.sf_train_num=? AND "
            "sf.sf_date=?;")
        cur.execute(q, (train_num,train_date))
        t_seats = list(cur.fetchall())
        train_seats =[]
        for t in t_seats:
            s={}
            s["seats"]=t[0]
            s["station1"]=t[1]
            s["station2"]=t[2]
            train_seats.append(s)
        return train_seats


def get_all_passengers():
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute(" SELECT * from Passengers")
        return cur.fetchall()

def get_all_tickets():
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute(" SELECT * from Tickets")
        return cur.fetchall()

'''
    method for getting station id from station symbol
'''
def get_station_id(stationcode):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        # need the comma here or python doesn't recognize (stationcode) as a tuple
        cur.execute("SELECT station_id from Stations WHERE station_code =?;", (stationcode,))
        return cur.fetchall()[0][0]


'''
    method for getting all trains running from stations at a given date and optional time of day
'''
def get_trains_from_station(start_station,end_station,date,time_of_day=None):
    #set the time interval for time of day
    if(time_of_day=="morning"):
        start_train_time = '00:00:00'
        end_train_time = '11:59:59'
    elif(time_of_day=="afternoon"):
        start_train_time = '12:00:00'
        end_train_time = "17:00:00"
    elif (time_of_day=="evening"):
        start_train_time = "17:00:00"
        end_train_time = "23:59:59"
    else:
        start_train_time = "00:00:00"
        end_train_time = "23:59:59"

    if(start_station>end_station):
        direction = 1
    else: direction = 0
    #weekday/weekend trains
    day = pydate(date).weekday()
    if(day<5): 
        day = "MF"
    else: day = "SSH"
    
    with sql.connect("database.db") as con:
        cur  = con.cursor()
        squery=("select sa.train_num, sa.time_out from stops_at sa "
                "join trains t "
                "on (t.train_num=sa.train_num AND t.direction=? AND t.train_days=?) "
                "where "
                "sa.station_id = ? AND sa.time_out between ? AND ?; "
                )

        cur.execute(squery,
            (direction, day, start_station, start_train_time,end_train_time))

        a_trains=list(cur.fetchall())
        trains_list = []
        for t in a_trains:
            train = {}
            train['train_num'] = t[0]
            train['time_out'] = t[1]

            trains_list.append(train)
        return trains_list


def check_free_seats(start_station, end_station, train_num, date):
    #start_station; end_station; train_num; date #from user
    if(end_station<start_station): start_station,end_station = end_station,start_station

    next_station = start_station+1
    while (next_station<=end_station):
        #find segment id with north-end = start_station and south_end = next_station
        #use seg_id, date and train_num to find free seats
        ## the two actions above should be a SQL stored procedure executed in one line in python
        ### stored procedure returns boolean for free or not free.
        # nope.
        with sql.connect("database.db") as con:
            cur = con.cursor()
            # find the one segment with matching north and south stations
            # query the number of seats it has free for x train on y date
            # TODO: make this less clunky as sin
            cur.execute("SELECT sf_seats_free FROM Seats_Free WHERE sf_train_num=? AND sf_date=? AND sf_seg_id in (SELECT segment_id FROM Segments WHERE (segment_north=? AND segment_south=?) OR (segment_south=? AND segment_north=?))", 
                (train_num, date, start_station, next_station, start_station, next_station))
        ## store in local var free_seats

        ##TODO change this to retrieve value (fetchone()[0]) when there are values in seats_free
            free_seats = cur.fetchone()
            if(not free_seats): 
                return False 
        start_station=next_station
        next_station+=1
    return True

# we might need these later. i'm shoving them here just in case
# we can sort out the details as we go along


def sqldate(date):
    # takes python datetime object and converts to string for submission to sql queries
    # TODO: remake schema.sql to use datetime where appropriate
    # TODO: create format string e.g. formatstring = '%b %d %Y %I:%M%p'
    # look up strptime in datetime documentation to see what i mean
    
    formatstring = "%Y-%m-%d"
    dt = date.strftime(formatstring)
    return dt

def pydate(date):
    formatstring = "%Y-%m-%d"
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring)


'''
Getting passengers reservations and handling all previous tickets
'''


def get_passenger_reservation(passengerID):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        cur.execute("""SELECT t.trip_id, t.trip_train, ls.station_name origin, le.station_name destination, 
                        t.trip_date, t.round_trip, t.return_train, t.return_date, t.fare, t.cancelled
                        FROM Tickets t JOIN Stations ls
                        ON ls.station_id = t.trip_starts
                        JOIN Stations le
                        ON le.station_id = t.trip_ends  WHERE t.passenger_id = ?""",
                    (passengerID,))
        result = cur.fetchall()
        return result


def rebook_ticket(ticketID):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        query_stmt = ("INSERT INTO Tickets (trip_starts, trip_ends, trip_train, trip_date, passenger_id, round_trip, return_trip, return_train, return_date, fare)"
                      "SELECT (trip_starts, trip_ends, trip_train, trip_date, passenger_id, round_trip, return_trip, return_train, return_date, fare)"
                      "FROM Tickets"
                      "WHERE trip_id = ?")
        cur.execute(query_stmt, (ticketID, ))
        con.commit()


def cancel_ticket(ticketID):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        query_stmt = ("UPDATE Tickets SET cancelled = 1 WHERE trip_id = ?")
        cur.execute(query_stmt, (ticketID, ))
        con.commit()


def get_ticket_record(ticketID):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        query_stmt = ("SELECT * FROM Tickets WHERE trip_id = ?")
        cur.execute(query_stmt, (ticketID,))
        return cur.fetchone()

def delay_train(trainID, amt, station):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        query_stmt = ("CREATE TABLE Temp_Stops_At AS"
                      "SELECT * FROM Stops_At")
        cur.execute(query_stmt)

        query_stmt = ("SELECT station_id FROM Temp_Stops_At where train_num = ? AND station_id >= ? ORDER BY station_id ASC")
        cur.execute(query_stmt, (trainID, station))

        for st in cur.fetchall():
            query_stmt = ("UPDATE Temp_Stops_At SET time_in = TIME(time_in, '+? minute'), time_out = TIME(time_out,'+? minute') WHERE train_num = ? AND station_id = ?")
            cur.execute(query_stmt, (amt, amt, trainID, st))

