import sqlite3 as sql


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

