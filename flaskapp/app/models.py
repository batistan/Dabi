import sqlite3 as sql
import json
import collections
import os

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

def check_free_seats(start_station, end_station, train_num, date):
    #start_station; end_station; train_num; date #from user
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
            cur.execute("SELECT sf_seats_free FROM Seats_Free WHERE sf_train_num=? AND sf_date=? AND sf_seg_id in (SELECT segment_id FROM Segments WHERE (segment_north=? AND segment_south=?) OR (segment_south=? AND segment_north=?))", (train_num, sqldate(date), start_station, end_station, start_station, end_station))
        ## store in local var free_seats
            free_seats = cur.fetchone()
            
            if(not free_seats): 
                return false 
        start_station=next_station
        next_station+=1
    return true

# we might need these later. i'm shoving them here just in case
# we can sort out the details as we go along
from datetime import datetime

def sqldate(date):
    # takes python datetime object and converts to string for submission to sql queries
    # TODO: remake schema.sql to use datetime where appropriate
    # TODO: create format string e.g. formatstring = '%b %d %Y %I:%M%p'
    # look up strptime in datetime documentation to see what i mean
    
    formatstring = "%Y-%m-%d %H:%M:%S"
    dt = date.strftime(formatstring)
    return dt

def pydate(date):
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring)
