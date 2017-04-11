CREATE TABLE IF NOT EXISTS Passengers (
 passenger_id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 passenger_lname varchar(20) NOT NULL,
 passenger_fname varchar(20) NOT NULL,
 passenger_billing_address varchar(50) NOT NULL,
 passenger_email varchar(50) DEFAULT NULL
); 



CREATE TABLE IF NOT EXISTS Tickets( 
	trip_id INT AUTO_INCREMENT PRIMARY KEY,
	trip_starts INT NOT NULL,
	trip_ends INT NOT NULL,
	trip_train INT NOT NULL,
	trip_date DATETIME,
	passenger_id INT NOT NULL,
	round_trip bool,
	fare decimal(4,2) NOT NULL,
	FOREIGN KEY (trip_starts) REFERENCES Stations(station_id),
  	FOREIGN KEY (trip_ends) REFERENCES Stations(station_id),
 	FOREIGN KEY (trip_train) REFERENCES Trains(train_id),
  	FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
  );


INSERT INTO passengers(passenger_lname, passenger_fname, passenger_billing_address, passenger_email) 
VALUES ('Butt', 'Abu','160 Convent Ave, New York, NY 11103','buttabu@yahoo.com');

INSERT INTO passengers(passenger_lname, passenger_fname, passenger_billing_address, passenger_email) 
VALUES ('Batista', 'Nelson','160 Convent Ave, New York, NY 11102','nbatist000@citymail.cuny.edu');

INSERT INTO passengers(passenger_lname, passenger_fname, passenger_billing_address, passenger_email) 
VALUES ('Shomoye', 'Adedamola','160 Convent Ave, New York, NY 11103','ashomoy000@citymail.cuny.edu');

INSERT INTO passengers(passenger_lname, passenger_fname, passenger_billing_address, passenger_email) 
VALUES ('Palongengi', 'Ichwan','160 Convent Ave, New York, NY 11103','ipalong00@citymail.cuny.edu');






INSERT INTO Tickets(trip_starts, trip_ends, trip_train, trip_date, passenger_id, round_trip, fare)
VALUES (001, 002,1,'2017-04-10 06:55:55',(SELECT passenger_id from Passengers WHERE Passengers.passenger_id=1),1,20.134);


INSERT INTO Tickets(trip_starts, trip_ends, trip_train, trip_date, passenger_id, round_trip, fare)
VALUES (002, 003,2,'2017-04-10 06:58:58',(SELECT passenger_id from Passengers WHERE Passengers.passenger_id=2),0,10.134);

INSERT INTO Tickets(trip_starts, trip_ends, trip_train, trip_date, passenger_id, round_trip, fare)
VALUES (003, 004,3,'2017-04-10 07:00:00',(SELECT passenger_id from Passengers WHERE Passengers.passenger_id=3),1,202.34);












