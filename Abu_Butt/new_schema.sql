CREATE TABLE IF NOT EXISTS Stations(
  station_id INTEGER PRIMARY KEY,
  station_name TEXT NOT NULL,
  station_code TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Segments (
  segment_id INTEGER PRIMARY KEY,
  segment_north INTEGER NOT NULL,
  segment_south INTEGER NOT NULL,
  FOREIGN KEY (segment_north) REFERENCES Stations(station_id),
  FOREIGN KEY (segment_south) REFERENCES Stations(station_id)
);

INSERT INTO Stations VALUES (001, 'Boston South Station, MA', 'BOST');
INSERT INTO Stations VALUES (002, 'Boston Back Bay, MA', 'BBAY');
INSERT INTO Stations VALUES (003, 'Route 128, MA', 'RTMA');
INSERT INTO Stations VALUES (004, 'Providence, RI', 'PRVD');
INSERT INTO Stations VALUES (005, 'Kingston, RI', 'KING');
INSERT INTO Stations VALUES (006, 'Westerly, RI', 'WSLY');
INSERT INTO Stations VALUES (007, 'Mystic, CT', 'MYST');
INSERT INTO Stations VALUES (008, 'New London, CT', 'NLND');
INSERT INTO Stations VALUES (009, 'Old Saybrook, CT', 'OSYB');
INSERT INTO Stations VALUES (010, 'New Haven, CT', 'NHVN');
INSERT INTO Stations VALUES (011, 'Bridgeport, CT', 'BDPR');
INSERT INTO Stations VALUES (012, 'Stamford, CT', 'STMF');
INSERT INTO Stations VALUES (013, 'New Rochelle, NY', 'NRCH');
INSERT INTO Stations VALUES (014, 'New York Penn Station, NY', 'NYPS');
INSERT INTO Stations VALUES (015, 'Newark Penn Station, NJ', 'NJPS');
INSERT INTO Stations VALUES (016, 'Newark Liberty Airport, NJ', 'LIBR');
INSERT INTO Stations VALUES (017, 'Metropark, NJ', 'MTRP');
INSERT INTO Stations VALUES (018, 'Trenton, NJ', 'TRNT');
INSERT INTO Stations VALUES (019, '30th Street Station, PA', 'PHLY');
INSERT INTO Stations VALUES (020, 'Wilmington, DE', 'WGTN');
INSERT INTO Stations VALUES (021, 'Newark, DE', 'NRDE');
INSERT INTO Stations VALUES (022, 'Aberdeen, MD', 'ABRD');
INSERT INTO Stations VALUES (023, 'Baltimore Penn Station, MD', 'MDPS');
INSERT INTO Stations VALUES (024, 'BWI Marshall Airport, MD', 'BWIM');
INSERT INTO Stations VALUES (025, 'New Carrollton, MD', 'NCRL');
INSERT INTO Stations VALUES (026, 'Union Station, DC', 'USDC');


INSERT INTO Segments VALUES (1001,001, 002);
INSERT INTO Segments VALUES (1002,002, 003);
INSERT INTO Segments VALUES (1003,003, 004);
INSERT INTO Segments VALUES (1004,004, 005);
INSERT INTO Segments VALUES (1005,005, 006);
INSERT INTO Segments VALUES (1006,006, 007);
INSERT INTO Segments VALUES (1007,007, 008);
INSERT INTO Segments VALUES (1008,008, 009);
INSERT INTO Segments VALUES (1009,009, 010);
INSERT INTO Segments VALUES (1010,010, 011);
INSERT INTO Segments VALUES (1011,011, 012);
INSERT INTO Segments VALUES (1012,012, 013);
INSERT INTO Segments VALUES (1013,013, 014);
INSERT INTO Segments VALUES (1014,014, 015);
INSERT INTO Segments VALUES (1015,015, 016);
INSERT INTO Segments VALUES (1016,016, 017);
INSERT INTO Segments VALUES (1017,017, 018);
INSERT INTO Segments VALUES (1018,018, 019);
INSERT INTO Segments VALUES (1019,019, 020);
INSERT INTO Segments VALUES (1020,020, 021);
INSERT INTO Segments VALUES (1021,021, 022);
INSERT INTO Segments VALUES (1022,022, 023);
INSERT INTO Segments VALUES (1023,023, 024);
INSERT INTO Segments VALUES (1024,024, 025);
INSERT INTO Segments VALUES (1025,025, 026);



create table if not exists Trains(
	train_num integer primary key autoincrement not null,
	train_starts int, 
	train_ends int, 
	direction bool,
	train_days varchar(5), 
	FOREIGN KEY(train_starts) REFERENCES Stations(station_id),
	FOREIGN KEY(train_ends) REFERENCES Stations(station_id)
	 );

-- 8 trains (weekdays) north (1)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(26,001,1,"MF"),
	(26,001,1,"MF"),
	(26,001,1,"MF"),

	(26,001,1,"MF"),
	(26,001,1,"MF"),
	(26,001,1,"MF"),

	(26,001,1,"MF"),
	(26,001,1,"MF");

-- 8 trains (weekdays) south (0)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(001,26,0,"MF"),
	(001,26,0,"MF"),
	(001,26,0,"MF"),

	(001,26,0,"MF"),
	(001,26,0,"MF"),
	(001,26,0,"MF"),

	(001,26,0,"MF"),
	(001,26,0,"MF");

-- 5 trains (weekends/holidays) north (1)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(26,001,1,"SSH"),
	(26,001,1,"SSH"),

	(26,001,1,"SSH"),
	(26,001,1,"SSH"),
	
	(26,001,1,"SSH");

-- 5 trains (weekends/holidays) south (0)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(001,26,0,"SSH"),
	(001,26,0,"SSH"),

	(001,26,0,"SSH"),
	(001,26,0,"SSH"),

	(001,26,0,"SSH");

CREATE TABLE if not exists stops_at(
	station_id int,
	train_num int ,
	time_in TIME,
	time_out TIME,
	primary key (station_id, train_num),
	FOREIGN KEY(train_num) REFERENCES Trains(train_num),
	FOREIGN KEY(station_id) REFERENCES Stations(station_id)
);



--all stops of train 1 
INSERT INTO stops_at values (026,1,'04:00:00','04:02:00');
INSERT INTO stops_at values (025,1,'04:15:00','04:17:00');
INSERT INTO stops_at values (024,1,'04:30:00','04:32:00');
INSERT INTO stops_at values (023,1,'04:45:00','04:47:00');
INSERT INTO stops_at values (022,1,'05:00:00','05:02:00');
INSERT INTO stops_at values (021,1,'05:15:00','05:17:00');
INSERT INTO stops_at values (020,1,'05:30:00','05:32:00');
INSERT INTO stops_at values (019,1,'05:45:00','05:47:00');
INSERT INTO stops_at values (018,1,'06:00:00','06:02:00');
INSERT INTO stops_at values (017,1,'06:15:00','06:17:00');
INSERT INTO stops_at values (016,1,'06:30:00','06:32:00');
INSERT INTO stops_at values (015,1,'06:45:00','06:47:00');
INSERT INTO stops_at values (014,1,'07:00:00','07:02:00');
INSERT INTO stops_at values (013,1,'07:15:00','07:17:00');
INSERT INTO stops_at values (012,1,'07:30:00','07:32:00');
INSERT INTO stops_at values (011,1,'07:45:00','07:47:00');
INSERT INTO stops_at values (010,1,'08:00:00','08:02:00');
INSERT INTO stops_at values (009,1,'08:15:00','08:17:00');
INSERT INTO stops_at values (008,1,'08:30:00','08:32:00');
INSERT INTO stops_at values (007,1,'08:45:00','08:47:00');
INSERT INTO stops_at values (006,1,'09:00:00','09:02:00');
INSERT INTO stops_at values (005,1,'09:15:00','09:17:00');
INSERT INTO stops_at values (004,1,'09:30:00','09:32:00');
INSERT INTO stops_at values (003,1,'09:45:00','09:47:00');
INSERT INTO stops_at values (002,1,'10:00:00','10:02:00');
INSERT INTO stops_at values (001,1,'10:15:00','10:17:00');

--all stops of train 2 
INSERT INTO stops_at values (026,2,'07:00:00','07:02:00');
INSERT INTO stops_at values (025,2,'07:15:00','07:17:00');
INSERT INTO stops_at values (024,2,'07:30:00','07:32:00');
INSERT INTO stops_at values (023,2,'07:45:00','07:47:00');
INSERT INTO stops_at values (022,2,'08:00:00','08:02:00');
INSERT INTO stops_at values (021,2,'08:15:00','08:17:00');
INSERT INTO stops_at values (020,2,'08:30:00','08:32:00');
INSERT INTO stops_at values (019,2,'08:45:00','08:47:00');
INSERT INTO stops_at values (018,2,'09:00:00','09:02:00');
INSERT INTO stops_at values (017,2,'09:15:00','09:17:00');
INSERT INTO stops_at values (016,2,'09:30:00','09:32:00');
INSERT INTO stops_at values (015,2,'09:45:00','09:47:00');
INSERT INTO stops_at values (014,2,'10:00:00','10:02:00');
INSERT INTO stops_at values (013,2,'10:15:00','10:17:00');
INSERT INTO stops_at values (012,2,'10:30:00','10:32:00');
INSERT INTO stops_at values (011,2,'10:45:00','10:47:00');
INSERT INTO stops_at values (010,2,'11:00:00','11:02:00');
INSERT INTO stops_at values (009,2,'11:15:00','11:17:00');
INSERT INTO stops_at values (008,2,'11:30:00','11:32:00');
INSERT INTO stops_at values (007,2,'11:45:00','11:47:00');
INSERT INTO stops_at values (006,2,'12:00:00','12:02:00');
INSERT INTO stops_at values (005,2,'12:15:00','12:17:00');
INSERT INTO stops_at values (004,2,'12:30:00','12:32:00');
INSERT INTO stops_at values (003,2,'12:45:00','12:47:00');
INSERT INTO stops_at values (002,2,'13:00:00','13:02:00');
INSERT INTO stops_at values (001,2,'13:15:00','13:17:00');

--all stops of train 3 
INSERT INTO stops_at values (026,3,'10:00:00','10:02:00');
INSERT INTO stops_at values (025,3,'10:15:00','10:17:00');
INSERT INTO stops_at values (024,3,'10:30:00','10:32:00');
INSERT INTO stops_at values (023,3,'10:45:00','10:47:00');
INSERT INTO stops_at values (022,3,'11:00:00','11:02:00');
INSERT INTO stops_at values (021,3,'11:15:00','11:17:00');
INSERT INTO stops_at values (020,3,'11:30:00','11:32:00');
INSERT INTO stops_at values (019,3,'11:45:00','11:47:00');
INSERT INTO stops_at values (018,3,'12:00:00','12:02:00');
INSERT INTO stops_at values (017,3,'12:15:00','12:17:00');
INSERT INTO stops_at values (016,3,'12:30:00','12:32:00');
INSERT INTO stops_at values (015,3,'12:45:00','12:47:00');
INSERT INTO stops_at values (014,3,'13:00:00','13:02:00');
INSERT INTO stops_at values (013,3,'13:15:00','13:17:00');
INSERT INTO stops_at values (012,3,'13:30:00','13:32:00');
INSERT INTO stops_at values (011,3,'13:45:00','13:47:00');
INSERT INTO stops_at values (010,3,'14:00:00','14:02:00');
INSERT INTO stops_at values (009,3,'14:15:00','14:17:00');
INSERT INTO stops_at values (008,3,'14:30:00','14:32:00');
INSERT INTO stops_at values (007,3,'14:45:00','14:47:00');
INSERT INTO stops_at values (006,3,'15:00:00','15:02:00');
INSERT INTO stops_at values (005,3,'15:15:00','15:17:00');
INSERT INTO stops_at values (004,3,'15:30:00','15:32:00');
INSERT INTO stops_at values (003,3,'15:45:00','15:47:00');
INSERT INTO stops_at values (002,3,'16:00:00','16:02:00');
INSERT INTO stops_at values (001,3,'16:15:00','16:17:00');

--all stops of train 4 
INSERT INTO stops_at values (026,4,'13:00:00','13:02:00');
INSERT INTO stops_at values (025,4,'13:15:00','13:17:00');
INSERT INTO stops_at values (024,4,'13:30:00','13:32:00');
INSERT INTO stops_at values (023,4,'13:45:00','13:47:00');
INSERT INTO stops_at values (022,4,'14:00:00','14:02:00');
INSERT INTO stops_at values (021,4,'14:15:00','14:17:00');
INSERT INTO stops_at values (020,4,'14:30:00','14:32:00');
INSERT INTO stops_at values (019,4,'14:45:00','14:47:00');
INSERT INTO stops_at values (018,4,'15:00:00','15:02:00');
INSERT INTO stops_at values (017,4,'15:15:00','15:17:00');
INSERT INTO stops_at values (016,4,'15:30:00','15:32:00');
INSERT INTO stops_at values (015,4,'15:45:00','15:47:00');
INSERT INTO stops_at values (014,4,'16:00:00','16:02:00');
INSERT INTO stops_at values (013,4,'16:15:00','16:17:00');
INSERT INTO stops_at values (012,4,'16:30:00','16:32:00');
INSERT INTO stops_at values (011,4,'16:45:00','16:47:00');
INSERT INTO stops_at values (010,4,'17:00:00','17:02:00');
INSERT INTO stops_at values (009,4,'17:15:00','17:17:00');
INSERT INTO stops_at values (008,4,'17:30:00','17:32:00');
INSERT INTO stops_at values (007,4,'17:45:00','17:47:00');
INSERT INTO stops_at values (006,4,'18:00:00','18:02:00');
INSERT INTO stops_at values (005,4,'18:15:00','18:17:00');
INSERT INTO stops_at values (004,4,'18:30:00','18:32:00');
INSERT INTO stops_at values (003,4,'18:45:00','18:47:00');
INSERT INTO stops_at values (002,4,'19:00:00','19:02:00');
INSERT INTO stops_at values (001,4,'19:15:00','19:17:00');

--all stops of train 5 
INSERT INTO stops_at values (026,5,'15:00:00','15:02:00');
INSERT INTO stops_at values (025,5,'15:15:00','15:17:00');
INSERT INTO stops_at values (024,5,'15:30:00','15:32:00');
INSERT INTO stops_at values (023,5,'15:45:00','15:47:00');
INSERT INTO stops_at values (022,5,'16:00:00','16:02:00');
INSERT INTO stops_at values (021,5,'16:15:00','16:17:00');
INSERT INTO stops_at values (020,5,'16:30:00','16:32:00');
INSERT INTO stops_at values (019,5,'16:45:00','16:47:00');
INSERT INTO stops_at values (018,5,'17:00:00','17:02:00');
INSERT INTO stops_at values (017,5,'17:15:00','17:17:00');
INSERT INTO stops_at values (016,5,'17:30:00','17:32:00');
INSERT INTO stops_at values (015,5,'17:45:00','17:47:00');
INSERT INTO stops_at values (014,5,'18:00:00','18:02:00');
INSERT INTO stops_at values (013,5,'18:15:00','18:17:00');
INSERT INTO stops_at values (012,5,'18:30:00','18:32:00');
INSERT INTO stops_at values (011,5,'18:45:00','18:47:00');
INSERT INTO stops_at values (010,5,'19:00:00','19:02:00');
INSERT INTO stops_at values (009,5,'19:15:00','19:17:00');
INSERT INTO stops_at values (008,5,'19:30:00','19:32:00');
INSERT INTO stops_at values (007,5,'19:45:00','19:47:00');
INSERT INTO stops_at values (006,5,'20:00:00','20:02:00');
INSERT INTO stops_at values (005,5,'20:15:00','20:17:00');
INSERT INTO stops_at values (004,5,'20:30:00','20:32:00');
INSERT INTO stops_at values (003,5,'20:45:00','20:47:00');
INSERT INTO stops_at values (002,5,'21:00:00','21:02:00');
INSERT INTO stops_at values (001,5,'21:15:00','21:17:00');

--all stops of train 6 
INSERT INTO stops_at values (026,6,'17:00:00','17:02:00');
INSERT INTO stops_at values (025,6,'17:15:00','17:17:00');
INSERT INTO stops_at values (024,6,'17:30:00','17:32:00');
INSERT INTO stops_at values (023,6,'17:45:00','17:47:00');
INSERT INTO stops_at values (022,6,'18:00:00','18:02:00');
INSERT INTO stops_at values (021,6,'18:15:00','18:17:00');
INSERT INTO stops_at values (020,6,'18:30:00','18:32:00');
INSERT INTO stops_at values (019,6,'18:45:00','18:47:00');
INSERT INTO stops_at values (018,6,'19:00:00','19:02:00');
INSERT INTO stops_at values (017,6,'19:15:00','19:17:00');
INSERT INTO stops_at values (016,6,'19:30:00','19:32:00');
INSERT INTO stops_at values (015,6,'19:45:00','19:47:00');
INSERT INTO stops_at values (014,6,'20:00:00','20:02:00');
INSERT INTO stops_at values (013,6,'20:15:00','20:17:00');
INSERT INTO stops_at values (012,6,'20:30:00','20:32:00');
INSERT INTO stops_at values (011,6,'20:45:00','20:47:00');
INSERT INTO stops_at values (010,6,'21:00:00','21:02:00');
INSERT INTO stops_at values (009,6,'21:15:00','21:17:00');
INSERT INTO stops_at values (008,6,'21:30:00','21:32:00');
INSERT INTO stops_at values (007,6,'21:45:00','21:47:00');
INSERT INTO stops_at values (006,6,'22:00:00','22:02:00');
INSERT INTO stops_at values (005,6,'22:15:00','22:17:00');
INSERT INTO stops_at values (004,6,'22:30:00','22:32:00');
INSERT INTO stops_at values (003,6,'22:45:00','22:47:00');
INSERT INTO stops_at values (002,6,'23:00:00','23:02:00');
INSERT INTO stops_at values (001,6,'23:15:00','23:17:00');

--all stops of train 7 
INSERT INTO stops_at values (026,7,'19:00:00','19:02:00');
INSERT INTO stops_at values (025,7,'19:15:00','19:17:00');
INSERT INTO stops_at values (024,7,'19:30:00','19:32:00');
INSERT INTO stops_at values (023,7,'19:45:00','19:47:00');
INSERT INTO stops_at values (022,7,'20:00:00','20:02:00');
INSERT INTO stops_at values (021,7,'20:15:00','20:17:00');
INSERT INTO stops_at values (020,7,'20:30:00','20:32:00');
INSERT INTO stops_at values (019,7,'20:45:00','20:47:00');
INSERT INTO stops_at values (018,7,'21:00:00','21:02:00');
INSERT INTO stops_at values (017,7,'21:15:00','21:17:00');
INSERT INTO stops_at values (016,7,'21:30:00','21:32:00');
INSERT INTO stops_at values (015,7,'21:45:00','21:47:00');
INSERT INTO stops_at values (014,7,'22:00:00','22:02:00');
INSERT INTO stops_at values (013,7,'22:15:00','22:17:00');
INSERT INTO stops_at values (012,7,'22:30:00','22:32:00');
INSERT INTO stops_at values (011,7,'22:45:00','22:47:00');
INSERT INTO stops_at values (010,7,'23:00:00','23:02:00');
INSERT INTO stops_at values (009,7,'23:15:00','23:17:00');
INSERT INTO stops_at values (008,7,'23:30:00','23:32:00');
INSERT INTO stops_at values (007,7,'23:45:00','23:47:00');
INSERT INTO stops_at values (006,7,'00:00:00','00:02:00');
INSERT INTO stops_at values (005,7,'00:15:00','00:17:00');
INSERT INTO stops_at values (004,7,'00:30:00','00:32:00');
INSERT INTO stops_at values (003,7,'00:45:00','00:47:00');
INSERT INTO stops_at values (002,7,'01:00:00','01:02:00');
INSERT INTO stops_at values (001,7,'01:15:00','01:17:00');

--all stops of train 8 
INSERT INTO stops_at values (026,8,'21:00:00','21:02:00');
INSERT INTO stops_at values (025,8,'21:15:00','21:17:00');
INSERT INTO stops_at values (024,8,'21:30:00','21:32:00');
INSERT INTO stops_at values (023,8,'21:45:00','21:47:00');
INSERT INTO stops_at values (022,8,'22:00:00','22:02:00');
INSERT INTO stops_at values (021,8,'22:15:00','22:17:00');
INSERT INTO stops_at values (020,8,'22:30:00','22:32:00');
INSERT INTO stops_at values (019,8,'22:45:00','22:47:00');
INSERT INTO stops_at values (018,8,'23:00:00','23:02:00');
INSERT INTO stops_at values (017,8,'23:15:00','23:17:00');
INSERT INTO stops_at values (016,8,'23:30:00','23:32:00');
INSERT INTO stops_at values (015,8,'23:45:00','23:47:00');
INSERT INTO stops_at values (014,8,'00:00:00','00:02:00');
INSERT INTO stops_at values (013,8,'00:15:00','00:17:00');
INSERT INTO stops_at values (012,8,'00:30:00','00:32:00');
INSERT INTO stops_at values (011,8,'00:45:00','00:47:00');
INSERT INTO stops_at values (010,8,'01:00:00','01:02:00');
INSERT INTO stops_at values (009,8,'01:15:00','01:17:00');
INSERT INTO stops_at values (008,8,'01:30:00','01:32:00');
INSERT INTO stops_at values (007,8,'01:45:00','01:47:00');
INSERT INTO stops_at values (006,8,'02:00:00','02:02:00');
INSERT INTO stops_at values (005,8,'02:15:00','02:17:00');
INSERT INTO stops_at values (004,8,'02:30:00','02:32:00');
INSERT INTO stops_at values (003,8,'02:45:00','02:47:00');
INSERT INTO stops_at values (002,8,'03:00:00','03:02:00');
INSERT INTO stops_at values (001,8,'03:15:00','03:17:00');

--all stops of train 9 
INSERT INTO stops_at values (001,9,'04:00:00','04:02:00');
INSERT INTO stops_at values (002,9,'04:15:00','04:17:00');
INSERT INTO stops_at values (003,9,'04:30:00','04:32:00');
INSERT INTO stops_at values (004,9,'04:45:00','04:47:00');
INSERT INTO stops_at values (005,9,'05:00:00','05:02:00');
INSERT INTO stops_at values (006,9,'05:15:00','05:17:00');
INSERT INTO stops_at values (007,9,'05:30:00','05:32:00');
INSERT INTO stops_at values (008,9,'05:45:00','05:47:00');
INSERT INTO stops_at values (009,9,'06:00:00','06:02:00');
INSERT INTO stops_at values (010,9,'06:15:00','06:17:00');
INSERT INTO stops_at values (011,9,'06:30:00','06:32:00');
INSERT INTO stops_at values (012,9,'06:45:00','06:47:00');
INSERT INTO stops_at values (013,9,'07:00:00','07:02:00');
INSERT INTO stops_at values (014,9,'07:15:00','07:17:00');
INSERT INTO stops_at values (015,9,'07:30:00','07:32:00');
INSERT INTO stops_at values (016,9,'07:45:00','07:47:00');
INSERT INTO stops_at values (017,9,'08:00:00','08:02:00');
INSERT INTO stops_at values (018,9,'08:15:00','08:17:00');
INSERT INTO stops_at values (019,9,'08:30:00','08:32:00');
INSERT INTO stops_at values (020,9,'08:45:00','08:47:00');
INSERT INTO stops_at values (021,9,'09:00:00','09:02:00');
INSERT INTO stops_at values (022,9,'09:15:00','09:17:00');
INSERT INTO stops_at values (023,9,'09:30:00','09:32:00');
INSERT INTO stops_at values (024,9,'09:45:00','09:47:00');
INSERT INTO stops_at values (025,9,'10:00:00','10:02:00');
INSERT INTO stops_at values (026,9,'10:15:00','10:17:00');

--all stops of train 10 
INSERT INTO stops_at values (001,10,'07:00:00','07:02:00');
INSERT INTO stops_at values (002,10,'07:15:00','07:17:00');
INSERT INTO stops_at values (003,10,'07:30:00','07:32:00');
INSERT INTO stops_at values (004,10,'07:45:00','07:47:00');
INSERT INTO stops_at values (005,10,'08:00:00','08:02:00');
INSERT INTO stops_at values (006,10,'08:15:00','08:17:00');
INSERT INTO stops_at values (007,10,'08:30:00','08:32:00');
INSERT INTO stops_at values (008,10,'08:45:00','08:47:00');
INSERT INTO stops_at values (009,10,'09:00:00','09:02:00');
INSERT INTO stops_at values (010,10,'09:15:00','09:17:00');
INSERT INTO stops_at values (011,10,'09:30:00','09:32:00');
INSERT INTO stops_at values (012,10,'09:45:00','09:47:00');
INSERT INTO stops_at values (013,10,'10:00:00','10:02:00');
INSERT INTO stops_at values (014,10,'10:15:00','10:17:00');
INSERT INTO stops_at values (015,10,'10:30:00','10:32:00');
INSERT INTO stops_at values (016,10,'10:45:00','10:47:00');
INSERT INTO stops_at values (017,10,'11:00:00','11:02:00');
INSERT INTO stops_at values (018,10,'11:15:00','11:17:00');
INSERT INTO stops_at values (019,10,'11:30:00','11:32:00');
INSERT INTO stops_at values (020,10,'11:45:00','11:47:00');
INSERT INTO stops_at values (021,10,'12:00:00','12:02:00');
INSERT INTO stops_at values (022,10,'12:15:00','12:17:00');
INSERT INTO stops_at values (023,10,'12:30:00','12:32:00');
INSERT INTO stops_at values (024,10,'12:45:00','12:47:00');
INSERT INTO stops_at values (025,10,'13:00:00','13:02:00');
INSERT INTO stops_at values (026,10,'13:15:00','13:17:00');

--all stops of train 11 
INSERT INTO stops_at values (001,11,'10:00:00','10:02:00');
INSERT INTO stops_at values (002,11,'10:15:00','10:17:00');
INSERT INTO stops_at values (003,11,'10:30:00','10:32:00');
INSERT INTO stops_at values (004,11,'10:45:00','10:47:00');
INSERT INTO stops_at values (005,11,'11:00:00','11:02:00');
INSERT INTO stops_at values (006,11,'11:15:00','11:17:00');
INSERT INTO stops_at values (007,11,'11:30:00','11:32:00');
INSERT INTO stops_at values (008,11,'11:45:00','11:47:00');
INSERT INTO stops_at values (009,11,'12:00:00','12:02:00');
INSERT INTO stops_at values (010,11,'12:15:00','12:17:00');
INSERT INTO stops_at values (011,11,'12:30:00','12:32:00');
INSERT INTO stops_at values (012,11,'12:45:00','12:47:00');
INSERT INTO stops_at values (013,11,'13:00:00','13:02:00');
INSERT INTO stops_at values (014,11,'13:15:00','13:17:00');
INSERT INTO stops_at values (015,11,'13:30:00','13:32:00');
INSERT INTO stops_at values (016,11,'13:45:00','13:47:00');
INSERT INTO stops_at values (017,11,'14:00:00','14:02:00');
INSERT INTO stops_at values (018,11,'14:15:00','14:17:00');
INSERT INTO stops_at values (019,11,'14:30:00','14:32:00');
INSERT INTO stops_at values (020,11,'14:45:00','14:47:00');
INSERT INTO stops_at values (021,11,'15:00:00','15:02:00');
INSERT INTO stops_at values (022,11,'15:15:00','15:17:00');
INSERT INTO stops_at values (023,11,'15:30:00','15:32:00');
INSERT INTO stops_at values (024,11,'15:45:00','15:47:00');
INSERT INTO stops_at values (025,11,'16:00:00','16:02:00');
INSERT INTO stops_at values (026,11,'16:15:00','16:17:00');

--all stops of train 12 
INSERT INTO stops_at values (001,12,'13:00:00','13:02:00');
INSERT INTO stops_at values (002,12,'13:15:00','13:17:00');
INSERT INTO stops_at values (003,12,'13:30:00','13:32:00');
INSERT INTO stops_at values (004,12,'13:45:00','13:47:00');
INSERT INTO stops_at values (005,12,'14:00:00','14:02:00');
INSERT INTO stops_at values (006,12,'14:15:00','14:17:00');
INSERT INTO stops_at values (007,12,'14:30:00','14:32:00');
INSERT INTO stops_at values (008,12,'14:45:00','14:47:00');
INSERT INTO stops_at values (009,12,'15:00:00','15:02:00');
INSERT INTO stops_at values (010,12,'15:15:00','15:17:00');
INSERT INTO stops_at values (011,12,'15:30:00','15:32:00');
INSERT INTO stops_at values (012,12,'15:45:00','15:47:00');
INSERT INTO stops_at values (013,12,'16:00:00','16:02:00');
INSERT INTO stops_at values (014,12,'16:15:00','16:17:00');
INSERT INTO stops_at values (015,12,'16:30:00','16:32:00');
INSERT INTO stops_at values (016,12,'16:45:00','16:47:00');
INSERT INTO stops_at values (017,12,'17:00:00','17:02:00');
INSERT INTO stops_at values (018,12,'17:15:00','17:17:00');
INSERT INTO stops_at values (019,12,'17:30:00','17:32:00');
INSERT INTO stops_at values (020,12,'17:45:00','17:47:00');
INSERT INTO stops_at values (021,12,'18:00:00','18:02:00');
INSERT INTO stops_at values (022,12,'18:15:00','18:17:00');
INSERT INTO stops_at values (023,12,'18:30:00','18:32:00');
INSERT INTO stops_at values (024,12,'18:45:00','18:47:00');
INSERT INTO stops_at values (025,12,'19:00:00','19:02:00');
INSERT INTO stops_at values (026,12,'19:15:00','19:17:00');

--all stops of train 13 
INSERT INTO stops_at values (001,13,'15:00:00','15:02:00');
INSERT INTO stops_at values (002,13,'15:15:00','15:17:00');
INSERT INTO stops_at values (003,13,'15:30:00','15:32:00');
INSERT INTO stops_at values (004,13,'15:45:00','15:47:00');
INSERT INTO stops_at values (005,13,'16:00:00','16:02:00');
INSERT INTO stops_at values (006,13,'16:15:00','16:17:00');
INSERT INTO stops_at values (007,13,'16:30:00','16:32:00');
INSERT INTO stops_at values (008,13,'16:45:00','16:47:00');
INSERT INTO stops_at values (009,13,'17:00:00','17:02:00');
INSERT INTO stops_at values (010,13,'17:15:00','17:17:00');
INSERT INTO stops_at values (011,13,'17:30:00','17:32:00');
INSERT INTO stops_at values (012,13,'17:45:00','17:47:00');
INSERT INTO stops_at values (013,13,'18:00:00','18:02:00');
INSERT INTO stops_at values (014,13,'18:15:00','18:17:00');
INSERT INTO stops_at values (015,13,'18:30:00','18:32:00');
INSERT INTO stops_at values (016,13,'18:45:00','18:47:00');
INSERT INTO stops_at values (017,13,'19:00:00','19:02:00');
INSERT INTO stops_at values (018,13,'19:15:00','19:17:00');
INSERT INTO stops_at values (019,13,'19:30:00','19:32:00');
INSERT INTO stops_at values (020,13,'19:45:00','19:47:00');
INSERT INTO stops_at values (021,13,'20:00:00','20:02:00');
INSERT INTO stops_at values (022,13,'20:15:00','20:17:00');
INSERT INTO stops_at values (023,13,'20:30:00','20:32:00');
INSERT INTO stops_at values (024,13,'20:45:00','20:47:00');
INSERT INTO stops_at values (025,13,'21:00:00','21:02:00');
INSERT INTO stops_at values (026,13,'21:15:00','21:17:00');

--all stops of train 14 
INSERT INTO stops_at values (001,14,'17:00:00','17:02:00');
INSERT INTO stops_at values (002,14,'17:15:00','17:17:00');
INSERT INTO stops_at values (003,14,'17:30:00','17:32:00');
INSERT INTO stops_at values (004,14,'17:45:00','17:47:00');
INSERT INTO stops_at values (005,14,'18:00:00','18:02:00');
INSERT INTO stops_at values (006,14,'18:15:00','18:17:00');
INSERT INTO stops_at values (007,14,'18:30:00','18:32:00');
INSERT INTO stops_at values (008,14,'18:45:00','18:47:00');
INSERT INTO stops_at values (009,14,'19:00:00','19:02:00');
INSERT INTO stops_at values (010,14,'19:15:00','19:17:00');
INSERT INTO stops_at values (011,14,'19:30:00','19:32:00');
INSERT INTO stops_at values (012,14,'19:45:00','19:47:00');
INSERT INTO stops_at values (013,14,'20:00:00','20:02:00');
INSERT INTO stops_at values (014,14,'20:15:00','20:17:00');
INSERT INTO stops_at values (015,14,'20:30:00','20:32:00');
INSERT INTO stops_at values (016,14,'20:45:00','20:47:00');
INSERT INTO stops_at values (017,14,'21:00:00','21:02:00');
INSERT INTO stops_at values (018,14,'21:15:00','21:17:00');
INSERT INTO stops_at values (019,14,'21:30:00','21:32:00');
INSERT INTO stops_at values (020,14,'21:45:00','21:47:00');
INSERT INTO stops_at values (021,14,'22:00:00','22:02:00');
INSERT INTO stops_at values (022,14,'22:15:00','22:17:00');
INSERT INTO stops_at values (023,14,'22:30:00','22:32:00');
INSERT INTO stops_at values (024,14,'22:45:00','22:47:00');
INSERT INTO stops_at values (025,14,'23:00:00','23:02:00');
INSERT INTO stops_at values (026,14,'23:15:00','23:17:00');

--all stops of train 15 
INSERT INTO stops_at values (001,15,'19:00:00','19:02:00');
INSERT INTO stops_at values (002,15,'19:15:00','19:17:00');
INSERT INTO stops_at values (003,15,'19:30:00','19:32:00');
INSERT INTO stops_at values (004,15,'19:45:00','19:47:00');
INSERT INTO stops_at values (005,15,'20:00:00','20:02:00');
INSERT INTO stops_at values (006,15,'20:15:00','20:17:00');
INSERT INTO stops_at values (007,15,'20:30:00','20:32:00');
INSERT INTO stops_at values (008,15,'20:45:00','20:47:00');
INSERT INTO stops_at values (009,15,'21:00:00','21:02:00');
INSERT INTO stops_at values (010,15,'21:15:00','21:17:00');
INSERT INTO stops_at values (011,15,'21:30:00','21:32:00');
INSERT INTO stops_at values (012,15,'21:45:00','21:47:00');
INSERT INTO stops_at values (013,15,'22:00:00','22:02:00');
INSERT INTO stops_at values (014,15,'22:15:00','22:17:00');
INSERT INTO stops_at values (015,15,'22:30:00','22:32:00');
INSERT INTO stops_at values (016,15,'22:45:00','22:47:00');
INSERT INTO stops_at values (017,15,'23:00:00','23:02:00');
INSERT INTO stops_at values (018,15,'23:15:00','23:17:00');
INSERT INTO stops_at values (019,15,'23:30:00','23:32:00');
INSERT INTO stops_at values (020,15,'23:45:00','23:47:00');
INSERT INTO stops_at values (021,15,'00:00:00','00:02:00');
INSERT INTO stops_at values (022,15,'00:15:00','00:17:00');
INSERT INTO stops_at values (023,15,'00:30:00','00:32:00');
INSERT INTO stops_at values (024,15,'00:45:00','00:47:00');
INSERT INTO stops_at values (025,15,'01:00:00','01:02:00');
INSERT INTO stops_at values (026,15,'01:15:00','01:17:00');

--all stops of train 16 
INSERT INTO stops_at values (001,16,'21:00:00','21:02:00');
INSERT INTO stops_at values (002,16,'21:15:00','21:17:00');
INSERT INTO stops_at values (003,16,'21:30:00','21:32:00');
INSERT INTO stops_at values (004,16,'21:45:00','21:47:00');
INSERT INTO stops_at values (005,16,'22:00:00','22:02:00');
INSERT INTO stops_at values (006,16,'22:15:00','22:17:00');
INSERT INTO stops_at values (007,16,'22:30:00','22:32:00');
INSERT INTO stops_at values (008,16,'22:45:00','22:47:00');
INSERT INTO stops_at values (009,16,'23:00:00','23:02:00');
INSERT INTO stops_at values (010,16,'23:15:00','23:17:00');
INSERT INTO stops_at values (011,16,'23:30:00','23:32:00');
INSERT INTO stops_at values (012,16,'23:45:00','23:47:00');
INSERT INTO stops_at values (013,16,'00:00:00','00:02:00');
INSERT INTO stops_at values (014,16,'00:15:00','00:17:00');
INSERT INTO stops_at values (015,16,'00:30:00','00:32:00');
INSERT INTO stops_at values (016,16,'00:45:00','00:47:00');
INSERT INTO stops_at values (017,16,'01:00:00','01:02:00');
INSERT INTO stops_at values (018,16,'01:15:00','01:17:00');
INSERT INTO stops_at values (019,16,'01:30:00','01:32:00');
INSERT INTO stops_at values (020,16,'01:45:00','01:47:00');
INSERT INTO stops_at values (021,16,'02:00:00','02:02:00');
INSERT INTO stops_at values (022,16,'02:15:00','02:17:00');
INSERT INTO stops_at values (023,16,'02:30:00','02:32:00');
INSERT INTO stops_at values (024,16,'02:45:00','02:47:00');
INSERT INTO stops_at values (025,16,'03:00:00','03:02:00');
INSERT INTO stops_at values (026,16,'03:15:00','03:17:00');

--all stops of train 17 
INSERT INTO stops_at values (026,17,'06:00:00','06:02:00');
INSERT INTO stops_at values (025,17,'06:15:00','06:17:00');
INSERT INTO stops_at values (024,17,'06:30:00','06:32:00');
INSERT INTO stops_at values (023,17,'06:45:00','06:47:00');
INSERT INTO stops_at values (022,17,'07:00:00','07:02:00');
INSERT INTO stops_at values (021,17,'07:15:00','07:17:00');
INSERT INTO stops_at values (020,17,'07:30:00','07:32:00');
INSERT INTO stops_at values (019,17,'07:45:00','07:47:00');
INSERT INTO stops_at values (018,17,'08:00:00','08:02:00');
INSERT INTO stops_at values (017,17,'08:15:00','08:17:00');
INSERT INTO stops_at values (016,17,'08:30:00','08:32:00');
INSERT INTO stops_at values (015,17,'08:45:00','08:47:00');
INSERT INTO stops_at values (014,17,'09:00:00','09:02:00');
INSERT INTO stops_at values (013,17,'09:15:00','09:17:00');
INSERT INTO stops_at values (012,17,'09:30:00','09:32:00');
INSERT INTO stops_at values (011,17,'09:45:00','09:47:00');
INSERT INTO stops_at values (010,17,'10:00:00','10:02:00');
INSERT INTO stops_at values (009,17,'10:15:00','10:17:00');
INSERT INTO stops_at values (008,17,'10:30:00','10:32:00');
INSERT INTO stops_at values (007,17,'10:45:00','10:47:00');
INSERT INTO stops_at values (006,17,'11:00:00','11:02:00');
INSERT INTO stops_at values (005,17,'11:15:00','11:17:00');
INSERT INTO stops_at values (004,17,'11:30:00','11:32:00');
INSERT INTO stops_at values (003,17,'11:45:00','11:47:00');
INSERT INTO stops_at values (002,17,'12:00:00','12:02:00');
INSERT INTO stops_at values (001,17,'12:15:00','12:17:00');

--all stops of train 18 
INSERT INTO stops_at values (026,18,'09:00:00','09:02:00');
INSERT INTO stops_at values (025,18,'09:15:00','09:17:00');
INSERT INTO stops_at values (024,18,'09:30:00','09:32:00');
INSERT INTO stops_at values (023,18,'09:45:00','09:47:00');
INSERT INTO stops_at values (022,18,'10:00:00','10:02:00');
INSERT INTO stops_at values (021,18,'10:15:00','10:17:00');
INSERT INTO stops_at values (020,18,'10:30:00','10:32:00');
INSERT INTO stops_at values (019,18,'10:45:00','10:47:00');
INSERT INTO stops_at values (018,18,'11:00:00','11:02:00');
INSERT INTO stops_at values (017,18,'11:15:00','11:17:00');
INSERT INTO stops_at values (016,18,'11:30:00','11:32:00');
INSERT INTO stops_at values (015,18,'11:45:00','11:47:00');
INSERT INTO stops_at values (014,18,'12:00:00','12:02:00');
INSERT INTO stops_at values (013,18,'12:15:00','12:17:00');
INSERT INTO stops_at values (012,18,'12:30:00','12:32:00');
INSERT INTO stops_at values (011,18,'12:45:00','12:47:00');
INSERT INTO stops_at values (010,18,'13:00:00','13:02:00');
INSERT INTO stops_at values (009,18,'13:15:00','13:17:00');
INSERT INTO stops_at values (008,18,'13:30:00','13:32:00');
INSERT INTO stops_at values (007,18,'13:45:00','13:47:00');
INSERT INTO stops_at values (006,18,'14:00:00','14:02:00');
INSERT INTO stops_at values (005,18,'14:15:00','14:17:00');
INSERT INTO stops_at values (004,18,'14:30:00','14:32:00');
INSERT INTO stops_at values (003,18,'14:45:00','14:47:00');
INSERT INTO stops_at values (002,18,'15:00:00','15:02:00');
INSERT INTO stops_at values (001,18,'15:15:00','15:17:00');

--all stops of train 19 
INSERT INTO stops_at values (026,19,'13:00:00','13:02:00');
INSERT INTO stops_at values (025,19,'13:15:00','13:17:00');
INSERT INTO stops_at values (024,19,'13:30:00','13:32:00');
INSERT INTO stops_at values (023,19,'13:45:00','13:47:00');
INSERT INTO stops_at values (022,19,'14:00:00','14:02:00');
INSERT INTO stops_at values (021,19,'14:15:00','14:17:00');
INSERT INTO stops_at values (020,19,'14:30:00','14:32:00');
INSERT INTO stops_at values (019,19,'14:45:00','14:47:00');
INSERT INTO stops_at values (018,19,'15:00:00','15:02:00');
INSERT INTO stops_at values (017,19,'15:15:00','15:17:00');
INSERT INTO stops_at values (016,19,'15:30:00','15:32:00');
INSERT INTO stops_at values (015,19,'15:45:00','15:47:00');
INSERT INTO stops_at values (014,19,'16:00:00','16:02:00');
INSERT INTO stops_at values (013,19,'16:15:00','16:17:00');
INSERT INTO stops_at values (012,19,'16:30:00','16:32:00');
INSERT INTO stops_at values (011,19,'16:45:00','16:47:00');
INSERT INTO stops_at values (010,19,'17:00:00','17:02:00');
INSERT INTO stops_at values (009,19,'17:15:00','17:17:00');
INSERT INTO stops_at values (008,19,'17:30:00','17:32:00');
INSERT INTO stops_at values (007,19,'17:45:00','17:47:00');
INSERT INTO stops_at values (006,19,'18:00:00','18:02:00');
INSERT INTO stops_at values (005,19,'18:15:00','18:17:00');
INSERT INTO stops_at values (004,19,'18:30:00','18:32:00');
INSERT INTO stops_at values (003,19,'18:45:00','18:47:00');
INSERT INTO stops_at values (002,19,'19:00:00','19:02:00');
INSERT INTO stops_at values (001,19,'19:15:00','19:17:00');

--all stops of train 20 
INSERT INTO stops_at values (026,20,'16:00:00','16:02:00');
INSERT INTO stops_at values (025,20,'16:15:00','16:17:00');
INSERT INTO stops_at values (024,20,'16:30:00','16:32:00');
INSERT INTO stops_at values (023,20,'16:45:00','16:47:00');
INSERT INTO stops_at values (022,20,'17:00:00','17:02:00');
INSERT INTO stops_at values (021,20,'17:15:00','17:17:00');
INSERT INTO stops_at values (020,20,'17:30:00','17:32:00');
INSERT INTO stops_at values (019,20,'17:45:00','17:47:00');
INSERT INTO stops_at values (018,20,'18:00:00','18:02:00');
INSERT INTO stops_at values (017,20,'18:15:00','18:17:00');
INSERT INTO stops_at values (016,20,'18:30:00','18:32:00');
INSERT INTO stops_at values (015,20,'18:45:00','18:47:00');
INSERT INTO stops_at values (014,20,'19:00:00','19:02:00');
INSERT INTO stops_at values (013,20,'19:15:00','19:17:00');
INSERT INTO stops_at values (012,20,'19:30:00','19:32:00');
INSERT INTO stops_at values (011,20,'19:45:00','19:47:00');
INSERT INTO stops_at values (010,20,'20:00:00','20:02:00');
INSERT INTO stops_at values (009,20,'20:15:00','20:17:00');
INSERT INTO stops_at values (008,20,'20:30:00','20:32:00');
INSERT INTO stops_at values (007,20,'20:45:00','20:47:00');
INSERT INTO stops_at values (006,20,'21:00:00','21:02:00');
INSERT INTO stops_at values (005,20,'21:15:00','21:17:00');
INSERT INTO stops_at values (004,20,'21:30:00','21:32:00');
INSERT INTO stops_at values (003,20,'21:45:00','21:47:00');
INSERT INTO stops_at values (002,20,'22:00:00','22:02:00');
INSERT INTO stops_at values (001,20,'22:15:00','22:17:00');

--all stops of train 21 
INSERT INTO stops_at values (026,21,'19:00:00','19:02:00');
INSERT INTO stops_at values (025,21,'19:15:00','19:17:00');
INSERT INTO stops_at values (024,21,'19:30:00','19:32:00');
INSERT INTO stops_at values (023,21,'19:45:00','19:47:00');
INSERT INTO stops_at values (022,21,'20:00:00','20:02:00');
INSERT INTO stops_at values (021,21,'20:15:00','20:17:00');
INSERT INTO stops_at values (020,21,'20:30:00','20:32:00');
INSERT INTO stops_at values (019,21,'20:45:00','20:47:00');
INSERT INTO stops_at values (018,21,'21:00:00','21:02:00');
INSERT INTO stops_at values (017,21,'21:15:00','21:17:00');
INSERT INTO stops_at values (016,21,'21:30:00','21:32:00');
INSERT INTO stops_at values (015,21,'21:45:00','21:47:00');
INSERT INTO stops_at values (014,21,'22:00:00','22:02:00');
INSERT INTO stops_at values (013,21,'22:15:00','22:17:00');
INSERT INTO stops_at values (012,21,'22:30:00','22:32:00');
INSERT INTO stops_at values (011,21,'22:45:00','22:47:00');
INSERT INTO stops_at values (010,21,'23:00:00','23:02:00');
INSERT INTO stops_at values (009,21,'23:15:00','23:17:00');
INSERT INTO stops_at values (008,21,'23:30:00','23:32:00');
INSERT INTO stops_at values (007,21,'23:45:00','23:47:00');
INSERT INTO stops_at values (006,21,'00:00:00','00:02:00');
INSERT INTO stops_at values (005,21,'00:15:00','00:17:00');
INSERT INTO stops_at values (004,21,'00:30:00','00:32:00');
INSERT INTO stops_at values (003,21,'00:45:00','00:47:00');
INSERT INTO stops_at values (002,21,'01:00:00','01:02:00');
INSERT INTO stops_at values (001,21,'01:15:00','01:17:00');

--all stops of train 22 
INSERT INTO stops_at values (001,22,'06:00:00','06:02:00');
INSERT INTO stops_at values (002,22,'06:15:00','06:17:00');
INSERT INTO stops_at values (003,22,'06:30:00','06:32:00');
INSERT INTO stops_at values (004,22,'06:45:00','06:47:00');
INSERT INTO stops_at values (005,22,'07:00:00','07:02:00');
INSERT INTO stops_at values (006,22,'07:15:00','07:17:00');
INSERT INTO stops_at values (007,22,'07:30:00','07:32:00');
INSERT INTO stops_at values (008,22,'07:45:00','07:47:00');
INSERT INTO stops_at values (009,22,'08:00:00','08:02:00');
INSERT INTO stops_at values (010,22,'08:15:00','08:17:00');
INSERT INTO stops_at values (011,22,'08:30:00','08:32:00');
INSERT INTO stops_at values (012,22,'08:45:00','08:47:00');
INSERT INTO stops_at values (013,22,'09:00:00','09:02:00');
INSERT INTO stops_at values (014,22,'09:15:00','09:17:00');
INSERT INTO stops_at values (015,22,'09:30:00','09:32:00');
INSERT INTO stops_at values (016,22,'09:45:00','09:47:00');
INSERT INTO stops_at values (017,22,'10:00:00','10:02:00');
INSERT INTO stops_at values (018,22,'10:15:00','10:17:00');
INSERT INTO stops_at values (019,22,'10:30:00','10:32:00');
INSERT INTO stops_at values (020,22,'10:45:00','10:47:00');
INSERT INTO stops_at values (021,22,'11:00:00','11:02:00');
INSERT INTO stops_at values (022,22,'11:15:00','11:17:00');
INSERT INTO stops_at values (023,22,'11:30:00','11:32:00');
INSERT INTO stops_at values (024,22,'11:45:00','11:47:00');
INSERT INTO stops_at values (025,22,'12:00:00','12:02:00');
INSERT INTO stops_at values (026,22,'12:15:00','12:17:00');

--all stops of train 23 
INSERT INTO stops_at values (001,23,'09:00:00','09:02:00');
INSERT INTO stops_at values (002,23,'09:15:00','09:17:00');
INSERT INTO stops_at values (003,23,'09:30:00','09:32:00');
INSERT INTO stops_at values (004,23,'09:45:00','09:47:00');
INSERT INTO stops_at values (005,23,'10:00:00','10:02:00');
INSERT INTO stops_at values (006,23,'10:15:00','10:17:00');
INSERT INTO stops_at values (007,23,'10:30:00','10:32:00');
INSERT INTO stops_at values (008,23,'10:45:00','10:47:00');
INSERT INTO stops_at values (009,23,'11:00:00','11:02:00');
INSERT INTO stops_at values (010,23,'11:15:00','11:17:00');
INSERT INTO stops_at values (011,23,'11:30:00','11:32:00');
INSERT INTO stops_at values (012,23,'11:45:00','11:47:00');
INSERT INTO stops_at values (013,23,'12:00:00','12:02:00');
INSERT INTO stops_at values (014,23,'12:15:00','12:17:00');
INSERT INTO stops_at values (015,23,'12:30:00','12:32:00');
INSERT INTO stops_at values (016,23,'12:45:00','12:47:00');
INSERT INTO stops_at values (017,23,'13:00:00','13:02:00');
INSERT INTO stops_at values (018,23,'13:15:00','13:17:00');
INSERT INTO stops_at values (019,23,'13:30:00','13:32:00');
INSERT INTO stops_at values (020,23,'13:45:00','13:47:00');
INSERT INTO stops_at values (021,23,'14:00:00','14:02:00');
INSERT INTO stops_at values (022,23,'14:15:00','14:17:00');
INSERT INTO stops_at values (023,23,'14:30:00','14:32:00');
INSERT INTO stops_at values (024,23,'14:45:00','14:47:00');
INSERT INTO stops_at values (025,23,'15:00:00','15:02:00');
INSERT INTO stops_at values (026,23,'15:15:00','15:17:00');

--all stops of train 24 
INSERT INTO stops_at values (001,24,'13:00:00','13:02:00');
INSERT INTO stops_at values (002,24,'13:15:00','13:17:00');
INSERT INTO stops_at values (003,24,'13:30:00','13:32:00');
INSERT INTO stops_at values (004,24,'13:45:00','13:47:00');
INSERT INTO stops_at values (005,24,'14:00:00','14:02:00');
INSERT INTO stops_at values (006,24,'14:15:00','14:17:00');
INSERT INTO stops_at values (007,24,'14:30:00','14:32:00');
INSERT INTO stops_at values (008,24,'14:45:00','14:47:00');
INSERT INTO stops_at values (009,24,'15:00:00','15:02:00');
INSERT INTO stops_at values (010,24,'15:15:00','15:17:00');
INSERT INTO stops_at values (011,24,'15:30:00','15:32:00');
INSERT INTO stops_at values (012,24,'15:45:00','15:47:00');
INSERT INTO stops_at values (013,24,'16:00:00','16:02:00');
INSERT INTO stops_at values (014,24,'16:15:00','16:17:00');
INSERT INTO stops_at values (015,24,'16:30:00','16:32:00');
INSERT INTO stops_at values (016,24,'16:45:00','16:47:00');
INSERT INTO stops_at values (017,24,'17:00:00','17:02:00');
INSERT INTO stops_at values (018,24,'17:15:00','17:17:00');
INSERT INTO stops_at values (019,24,'17:30:00','17:32:00');
INSERT INTO stops_at values (020,24,'17:45:00','17:47:00');
INSERT INTO stops_at values (021,24,'18:00:00','18:02:00');
INSERT INTO stops_at values (022,24,'18:15:00','18:17:00');
INSERT INTO stops_at values (023,24,'18:30:00','18:32:00');
INSERT INTO stops_at values (024,24,'18:45:00','18:47:00');
INSERT INTO stops_at values (025,24,'19:00:00','19:02:00');
INSERT INTO stops_at values (026,24,'19:15:00','19:17:00');

--all stops of train 25 
INSERT INTO stops_at values (001,25,'16:00:00','16:02:00');
INSERT INTO stops_at values (002,25,'16:15:00','16:17:00');
INSERT INTO stops_at values (003,25,'16:30:00','16:32:00');
INSERT INTO stops_at values (004,25,'16:45:00','16:47:00');
INSERT INTO stops_at values (005,25,'17:00:00','17:02:00');
INSERT INTO stops_at values (006,25,'17:15:00','17:17:00');
INSERT INTO stops_at values (007,25,'17:30:00','17:32:00');
INSERT INTO stops_at values (008,25,'17:45:00','17:47:00');
INSERT INTO stops_at values (009,25,'18:00:00','18:02:00');
INSERT INTO stops_at values (010,25,'18:15:00','18:17:00');
INSERT INTO stops_at values (011,25,'18:30:00','18:32:00');
INSERT INTO stops_at values (012,25,'18:45:00','18:47:00');
INSERT INTO stops_at values (013,25,'19:00:00','19:02:00');
INSERT INTO stops_at values (014,25,'19:15:00','19:17:00');
INSERT INTO stops_at values (015,25,'19:30:00','19:32:00');
INSERT INTO stops_at values (016,25,'19:45:00','19:47:00');
INSERT INTO stops_at values (017,25,'20:00:00','20:02:00');
INSERT INTO stops_at values (018,25,'20:15:00','20:17:00');
INSERT INTO stops_at values (019,25,'20:30:00','20:32:00');
INSERT INTO stops_at values (020,25,'20:45:00','20:47:00');
INSERT INTO stops_at values (021,25,'21:00:00','21:02:00');
INSERT INTO stops_at values (022,25,'21:15:00','21:17:00');
INSERT INTO stops_at values (023,25,'21:30:00','21:32:00');
INSERT INTO stops_at values (024,25,'21:45:00','21:47:00');
INSERT INTO stops_at values (025,25,'22:00:00','22:02:00');
INSERT INTO stops_at values (026,25,'22:15:00','22:17:00');

--all stops of train 26 
INSERT INTO stops_at values (001,26,'19:00:00','19:02:00');
INSERT INTO stops_at values (002,26,'19:15:00','19:17:00');
INSERT INTO stops_at values (003,26,'19:30:00','19:32:00');
INSERT INTO stops_at values (004,26,'19:45:00','19:47:00');
INSERT INTO stops_at values (005,26,'20:00:00','20:02:00');
INSERT INTO stops_at values (006,26,'20:15:00','20:17:00');
INSERT INTO stops_at values (007,26,'20:30:00','20:32:00');
INSERT INTO stops_at values (008,26,'20:45:00','20:47:00');
INSERT INTO stops_at values (009,26,'21:00:00','21:02:00');
INSERT INTO stops_at values (010,26,'21:15:00','21:17:00');
INSERT INTO stops_at values (011,26,'21:30:00','21:32:00');
INSERT INTO stops_at values (012,26,'21:45:00','21:47:00');
INSERT INTO stops_at values (013,26,'22:00:00','22:02:00');
INSERT INTO stops_at values (014,26,'22:15:00','22:17:00');
INSERT INTO stops_at values (015,26,'22:30:00','22:32:00');
INSERT INTO stops_at values (016,26,'22:45:00','22:47:00');
INSERT INTO stops_at values (017,26,'23:00:00','23:02:00');
INSERT INTO stops_at values (018,26,'23:15:00','23:17:00');
INSERT INTO stops_at values (019,26,'23:30:00','23:32:00');
INSERT INTO stops_at values (020,26,'23:45:00','23:47:00');
INSERT INTO stops_at values (021,26,'00:00:00','00:02:00');
INSERT INTO stops_at values (022,26,'00:15:00','00:17:00');
INSERT INTO stops_at values (023,26,'00:30:00','00:32:00');
INSERT INTO stops_at values (024,26,'00:45:00','00:47:00');
INSERT INTO stops_at values (025,26,'01:00:00','01:02:00');
INSERT INTO stops_at values (026,26,'01:15:00','01:17:00');



CREATE TABLE IF NOT EXISTS Seats_Free(
  sf_train_num INTEGER,
  sf_seg_id INTEGER,
  sf_date DATE,
  sf_seats_free INTEGER,
  PRIMARY KEY(sf_train_num, sf_seg_id, sf_date),
  FOREIGN KEY (sf_train_num) REFERENCES Trains(train_id),
  FOREIGN KEY (sf_seg_id) references Segments(segment_id)
);

/*
Python script for seats free values for May 1-4
import datetime as dt
for i in range(1,5):
	start_month = dt.datetime(2017,5,i)
	for i in range(1,27): #for all trains
		for j in range(1001,1025):
			print("INSERT INTO Seats_free values (%d,%d,'%s',%d);\n"%(i,j,start_month.strftime("%Y-%m-%d"),448))
*/

CREATE TABLE IF NOT EXISTS Passengers (
 passenger_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
 passenger_lname varchar(20) NOT NULL,
 passenger_fname varchar(20) NOT NULL,
 passenger_billing_address varchar(50) NOT NULL,
 passenger_email varchar(50) DEFAULT NULL
); 



CREATE TABLE IF NOT EXISTS Tickets( 
	trip_id INTEGER PRIMARY KEY AUTOINCREMENT,
	trip_starts INT NOT NULL,
	trip_ends INT NOT NULL,
	trip_train INT NOT NULL,
	trip_date DATETIME,
	passenger_id INT NOT NULL,
	round_trip bool,
	return_train INT DEFAULT NULL,
	return_date DATETIME DEFAULT NULL,
	fare decimal(4,2) NOT NULL,
	cancelled boolean DEFAULT NULL,
	FOREIGN KEY (trip_starts) REFERENCES Stations(station_id),
  	FOREIGN KEY (trip_ends) REFERENCES Stations(station_id),
 	FOREIGN KEY (trip_train) REFERENCES Trains(train_id),
  	FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
  	FOREIGN KEY (return_train) REFERENCES Trains(train_id)
);

-- TRIGGERS FOR THE `Tickets` TABLE

/*This trigger is fired when a NEW ONE_WAY ticket is added to the database.
It decrements the number of free seats on segments that will be traversed by ticket holder*/
CREATE TRIGGER IF NOT EXISTS decrement_free_seats_one_way
  AFTER INSERT ON Tickets
  FOR EACH ROW
  WHEN new.round_trip=0
BEGIN
  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free - 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.trip_train)
        AND (sf_date=new.trip_date);
END;

/*This trigger is fired when a NEW ROUND-TRIP ticket is added to the database .
It decrements the number of free seats on segments that will be traversed by ticket holder*/
CREATE TRIGGER IF NOT EXISTS decrement_free_seats_round_trip
  AFTER INSERT ON Tickets
  FOR EACH ROW
  WHEN new.round_trip=1
BEGIN
  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free - 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.trip_train)
        AND (sf_date=new.trip_date);

  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free - 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.return_train)
        AND (sf_date=new.return_date);
END;

/*This trigger is fired when a ONE-WAY ticket in the `Tickets` table is cancelled.
It increments the number of free seats on segments that would have been traversed by ticket holder*/
CREATE TRIGGER IF NOT EXISTS increment_free_seats_one_way
  AFTER UPDATE ON Tickets
  FOR EACH ROW
  WHEN new.round_trip=0 AND new.cancelled=1
BEGIN
  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free + 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.trip_train)
        AND (sf_date=new.trip_date);
END;

/*This trigger is fired when a ROUND-TRIP ticket in the `Tickets` table is cancelled.
It increments the number of free seats on segments that would have been traversed by ticket holder*/
CREATE TRIGGER IF NOT EXISTS increment_free_seats_round_trip
  AFTER UPDATE ON Tickets
  FOR EACH ROW
  WHEN new.round_trip=1 AND new.cancelled=1
BEGIN
  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free + 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.trip_train)
        AND (sf_date=new.trip_date);

  UPDATE Seats_Free
  SET sf_seats_free = sf_seats_free + 1
  WHERE sf_seg_id IN (SELECT segment_id
                      FROM Segments WHERE (segment_north >= new.trip_starts AND segment_north < new.trip_ends)
                                          OR (segment_north < new.trip_starts AND segment_north >= new.trip_ends))
        AND (sf_train_num=new.return_train)
        AND (sf_date=new.return_date);
END;



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


