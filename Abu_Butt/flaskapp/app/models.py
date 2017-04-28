import sqlite3 as sql
import json
import collections
import os
from datetime import datetime

# This file is basically how the webserver interfaces with the database
# we'll have to replace these with our own functions working on our own database
# for now I'm leaving them here for reference

def add_user(username, password):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("INSERT INTO users VALUES (null,?,?)", (username, password))
        con.commit()

def add_meetup(classname, subject, starttime, endtime, createdby, lat, lon):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("INSERT INTO meetups VALUES (null,?,?,?,?,?,?,?)", (classname, subject, starttime, endtime, createdby, lat, lon))
        con.commit()

def set_going(uid, eid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("INSERT INTO RSVPS VALUES (?,?)", (eid, uid))
        con.commit()
        
def set_not_going(uid, eid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("DELETE FROM RSVPS WHERE eid = ? and uid = ?", (eid, uid))
        con.commit()

def is_going(uid, eid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT * FROM RSVPS WHERE uid = ? AND eid = ?", (uid, eid))
        if not (cur.fetchall()):
            return False
        else:
            return True

def get_all_meetups():
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT * FROM meetups;")
        rs = list(cur.fetchall())

        meetuplist = []
        for row in rs:
            mdict = collections.OrderedDict()
            mdict['eid'] = row[0]
            mdict['classname'] = row[1]
            mdict['subject'] = row[2]
            mdict['starttime'] = row[3]
            mdict['endtime'] = row[4]
            mdict['createdby'] = row[5]
            mdict['latitude'] = row[6]
            mdict['longitude'] = row[7]

            meetuplist.append(mdict)

        return (meetuplist)

def get_all_attendees(eid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT * FROM RSVPS WHERE eid = ?;", eid)
        rs = list(cur.fetchall())

        listofattendees = []
        for row in rs:
            listofattendees.append(getUsernameFromUID(row[1]))  # change to getUsername(uid)

        return (json.dumps(listofattendees))

def getUsernameFromUID(uid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT username FROM users WHERE uid = ?;", (uid,))
        rs = cur.fetchall()
        if not rs:
            return "Error"
        else:
            return rs[0][0]

def getIDFromUsername(username):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT uid FROM users WHERE username = ?;", (username,))
        rs = cur.fetchall()
        if not rs:
            return None
        else:
            return rs[0][0]

def get_meetup_info(eid):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT * FROM meetups where eid = ?;", [(str(eid))])
        row = cur.fetchone()

        if (not row):
            return None

        mdict = collections.OrderedDict()
        mdict['eid'] = row[0]
        mdict['classname'] = row[1]
        mdict['subject'] = row[2]
        mdict['starttime'] = row[3]
        mdict['endtime'] = row[4]
        mdict['createdby'] = row[5]
        mdict['latitude'] = row[6]
        mdict['longitude'] = row[7]
        return (mdict)

def findByClass(term):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT * FROM meetups where classname = ?;", (term,))
        rs = list(cur.fetchall())

        meetuplist = []
        for row in rs:
            mdict = collections.OrderedDict()
            mdict['eid'] = row[0]
            mdict['classname'] = row[1]
            mdict['subject'] = row[2]
            mdict['starttime'] = row[3]
            mdict['endtime'] = row[4]
            mdict['createdby'] = row[5]
            mdict['latitude'] = row[6]
            mdict['longitude'] = row[7]

            meetuplist.append(mdict)

        return (meetuplist)

def confirmUserPass(user,passw):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("SELECT password FROM users where username = ?;", (user,))
        row = cur.fetchall()

        if not row:
            return False

        return True
        # def exists_user():
        # def delete_meetup():
        # def delete_user():


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
def create_ticket(start_station,end_station,train_num,date,passenger_id,roundtrip,fare):
    pass

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

            cur.execute(q,(train_num, date, start_station, next_station, start_station, next_station))
            con.commit()
        start_station=next_station
        next_station+=1



'''
    method for getting station id from station symbol
'''
def get_station_id(stationcode):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        # need the comma here or python doesn't recognize (stationcode) as a tuple
        cur.execute("SELECT station_id from Stations WHERE station_code =?", (stationcode,))
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
