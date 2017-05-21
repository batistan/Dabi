import sqlite3 as sql
import json
import collections
import os
from datetime import datetime, timedelta
from random import randint

'''
create new passenger
'''
def create_passenger(p_lname,p_fname,p_address,p_email):
    with sql.connect("database.db") as con:
        cur = con.cursor()
        cur.execute("INSERT INTO Passengers (passenger_lname,passenger_fname,passenger_billing_address,passenger_email) VALUES (?,?,?,?);", (p_lname, p_fname,p_address,p_email))
        con.commit()
        cur.execute("SELECT LAST_INSERT_ROWID();")
        return cur.fetchall()[0][0]


'''create ticket'''
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
 update free seats by adding or removing free seats, 
 default remove one seat for all segments in the given trip
'''
def update_free_seats(start_station,end_station,train_num,date, diff=-1):
    if(start_station>end_station): start_station,end_station=end_station,start_station
    with sql.connect("database.db") as con:
        q = ("update Seats_free "
            "SET sf_seats_free = sf_seats_free + (?) "
            "WHERE sf_train_num=? AND sf_date=? AND " 
            "sf_seg_id in (SELECT segment_id FROM Segments WHERE " 
            "(segment_north>=? AND segment_south<=?)); "
            )
        cur = con.cursor()
        cur.execute(q,(diff,train_num, date, start_station, end_station))
        con.commit()


'''
for filing drop-downs etc in templates
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
    else:
        day = "SSH"
    
    with sql.connect("database.db") as con:
        cur = con.cursor()
        squery=("select sa.train_num, sa.time_out, sa2.time_in " 
                "from stops_at sa join trains t on "
                "(t.train_num=sa.train_num and t.direction=? and t.train_days=?) " 
                "join stops_at sa2 on (sa2.train_num=t.train_num) "
                "where sa.station_id=? and sa2.station_id=? AND sa.time_out between ? AND ?; "
                )

        cur.execute(squery,(direction, day, start_station, end_station, start_train_time,end_train_time))

        a_trains=list(cur.fetchall())
        trains_list = []
        for t in a_trains:
            train = {}
            train['train_num'] = t[0]
            train['time_out'] = t[1]
            train['arrival'] = t[2]

            trains_list.append(train)
        return trains_list


#this is a more efficient checking of free seats, call when rebooking.
def is_seats_available(start_station, end_station, train_num, date):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        stmt = ("SELECT sf_seats_free FROM Seats_Free WHERE sf_seg_id IN (SELECT segment_id "
                "FROM Segments WHERE (segment_north >= ? AND segment_north < ?)"
                "OR (segment_north < ? AND segment_north >= ?))"
                "AND (sf_train_num=?) AND (sf_date=?)")
        cur.execute(stmt, (start_station, end_station, start_station, end_station, train_num, date))
        result = cur.fetchall()
        return all(i[0] > 0 for i in result)


#get seg_id for two stations //declutter queries
def get_seg_id(start_station,end_station):
    if(end_station<start_station): start_station,end_station = end_station,start_station
    with sql.connect("database.db") as con:
        cur = con.cursor()
        q = "SELECT segment_id from Segments where (segment_north>=? and segment_south<=?)"
        cur.execute(q,(start_station,end_station))
        return cur.fetchall()[0][0]


#this will insert free seat record if booking for a later date and no one has booked yet.
def check_free_seats(start_station, end_station, train_num, date):
    #start_station; end_station; train_num; date #from user
    if(end_station<start_station): start_station,end_station = end_station,start_station
    next_station = start_station+1
    while (next_station<=end_station):
        seg_id = get_seg_id(start_station,next_station)
        with sql.connect("database.db") as con:
            cur = con.cursor()
            cur.execute("INSERT OR IGNORE INTO Seats_free values (?,?,?,?)",(train_num,seg_id,date,448))
            con.commit()
            cur.execute("SELECT sf_seats_free FROM Seats_Free WHERE sf_train_num=? AND sf_date=? AND sf_seg_id =?;", 
                (train_num, date, seg_id))
            free_seats = cur.fetchone()[0]
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


#for dealing with datetime string
def pydate_only(date):
    formatstring = "%Y-%m-%d %H:%M:%S"
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring).date()

def pydatetime(date):
    formatstring = u"%Y-%m-%d %H:%M:%S"
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring)

def pydate(date):
    formatstring = "%Y-%m-%d"
    # takes string and converts to datetime object for use in python functions
    return datetime.strptime(date, formatstring)

def pytime(time):
    formatstring = "%H:%M:%S"
    # takes time string and converts to datetime object for use in python functions
    return datetime.strptime(time, formatstring)

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
        q = (" UPDATE Tickets "
            "SET cancelled = 0 "            
            "WHERE trip_id = ? ")
        cur.execute(q, (ticketID, ))
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




# returns a list of tuple of all rows in `temp_stops_at` table
def get_train_status(train_num):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        query_stmt = ("SELECT station_id,time_in,delayed FROM temp_stops_at where train_num = ?")
        cur.execute(query_stmt,(train_num,))
        return cur.fetchall()
        


def create_temp_stops_at():
    with sql.connect('database.db') as con:
        cur = con.cursor()
        q=(" CREATE TABLE if not exists temp_stops_at("
        "station_id int, train_num int ,time_in DATETIME, time_out DATETIME, "
        "delayed bool default 0, primary key (station_id, train_num), "
        "FOREIGN KEY(train_num) REFERENCES Trains(train_num), "
        "FOREIGN KEY(station_id) REFERENCES Stations(station_id)); "
        )
        cur.execute(q)
        con.commit()


##update relevant trains given a "root" delayed train
def update_all_trains(train_days,direction,first_delayed_train):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        q = (" select train_num from Trains where train_days = ? AND direction = ?")
        cur.execute(q,(train_days,direction))
        trains = []
        for t in cur.fetchall():
            if t[0] > first_delayed_train: trains.append(t[0])
        for t in sorted(trains):
            update_train_status(t,direction)
        return trains



# randomly pick a train
# put all the records from the `stops_at` table into `temp_stops_at` table
# apply specified offset to all the data in `time_in` and `time_out` fields in `temp_stops_at` table
def delay_random_train(offset):
    with sql.connect('database.db') as con:
        cur = con.cursor()
        # clear the `temp_stops_at` table
        cur.execute("DELETE from temp_stops_at")
        con.commit()
        #copy stops_at into temp_stops_at, convert time to datetime
        insert_into_temp_stops_at()

        random_train = randint(1, 27)

        # introduce delay to all `time_in` and `time_out` fields in `temp_stops_at` table
        offset_string = ('+' + str(offset) + ' minutes') if offset >= 0 else (str(offset) + ' minutes')
        delay_stmt = ("UPDATE temp_stops_at SET time_in = DATETIME(time_in, ?), time_out = DATETIME(time_out, ?), delayed = 1 where train_num = ?")
        cur.execute(delay_stmt, (offset_string, offset_string,random_train))
        con.commit()

        # return the tuple (train_days, direction) of the randomly picked train
        get_train_stmt = ("SELECT train_days, direction,train_num FROM Trains where train_num = ?")
        cur.execute(get_train_stmt, (random_train,))
        return cur.fetchone()

##move repeated actions over here, inserts all stops_at into temp_stops_at and turns time in datetime
def insert_into_temp_stops_at():
    with sql.connect('database.db') as con:
        cur = con.cursor()
        #insert schedule time into temp_stops_at
        for train_num in get_all_trains():
            q = ("INSERT OR IGNORE INTO temp_stops_at (station_id, train_num, time_in, time_out)"
                           "SELECT * FROM stops_at "
                           "WHERE stops_at.train_num = ?")
            cur.execute(q,(train_num,))
            con.commit()
            #get the train's starting station from direction
            cur.execute("SELECT direction FROM Trains where train_num = ?",(train_num,))
            direction = cur.fetchone()[0]
            first_station = 26 if direction == 1  else 1
            q = ("select time_in from stops_at where train_num = ? AND station_id = ?")
            cur.execute(q,(train_num,first_station))
            #if any time is less than the starting time then it's crossed to new day
            min_time = cur.fetchone()[0]
            correct_stmt = ("UPDATE temp_stops_at SET time_in = CASE "
                    "WHEN time_in >= ? "
                    "THEN DATETIME(date('now'), time_in) "
                    "ELSE DATETIME(date('now'), '+1 day', time_in) END, "
                    "time_out = CASE "
                    "WHEN time_out > ? "
                    "THEN DATETIME(date('now'), time_out) "
                    "ELSE DATETIME(date('now'), '+1 day', time_out) END "
                    "where train_num = ?"
                    )
            cur.execute(correct_stmt,(min_time,min_time,train_num))
            con.commit()


#update trains times if affected by delay in temp_stops_at
def update_train_status(train_num,direction):
    if(train_num<27): 
        stops = list(range(26,0,-1)) 
    else:
        stops=[26,23,19,17,14,10,4,3,1]
    if(direction==0): 
        stops = reversed(stops)
    with sql.connect('database.db') as con:
        cur = con.cursor()
        for st in stops:
            #get the time lastest time out for any train (same direction) in temp stops_at
            q = ("select max(sa.time_out) from temp_stops_at sa join trains t on "
            "(t.train_num = sa.train_num AND t.direction = ?) "
            "where sa.station_id = ? order by station_id; "
            )
            cur.execute(q,(direction, st))
            r=cur.fetchone()[0]
            latest_train = pydatetime(r)
            #get current train's scheduled time out
            q = ("select time_out from temp_stops_at where train_num = ? and station_id = ?;")
            cur.execute(q,(train_num,st))
            sched_time = cur.fetchone()[0]
            sched_time=pydatetime(sched_time)
            #no need to update arrival time in the past
            if(sched_time>datetime.now()): 
                #checking if any train will be arriving later than current train
                if(latest_train>=sched_time):
                    delay_time = (latest_train - sched_time + timedelta(minutes=5)).total_seconds()
                    delay_time = ('+' + str(delay_time) + ' seconds')
                    #update all stations arrival time with new delay
                    q=("update temp_stops_at "
                        "set time_out = datetime(time_out,?), time_in = datetime(time_in,?), delayed = 1 "
                        "where train_num = ? AND station_id >= ?")
                    cur.execute(q,(delay_time,delay_time,train_num,st))

        con.commit()
