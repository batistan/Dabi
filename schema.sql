create table Trains(
	train_num int not null auto_increment,
	train_starts int, 
	train_ends int, 
	direction bool, train_days varchar(5), 
	primary key (train_num),
	FOREIGN KEY(train_starts) REFERENCES Stations(station_id),
	FOREIGN KEY(train_ends) REFERENCES Stations(station_id)
	 );

-- 8 trains (weekdays) north (1)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(034,001,1,"MF"),
	(034,001,1,"MF"),
	(034,001,1,"MF"),

	(034,001,1,"MF"),
	(034,001,1,"MF"),
	(034,001,1,"MF"),

	(034,001,1,"MF"),
	(034,001,1,"MF");

-- 8 trains (weekdays) south (0)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(001,034,0,"MF"),
	(001,034,0,"MF"),
	(001,034,0,"MF"),

	(001,034,0,"MF"),
	(001,034,0,"MF"),
	(001,034,0,"MF"),

	(001,034,0,"MF"),
	(001,034,0,"MF");

-- 5 trains (weekends/holidays) north (1)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(034,001,1,"SSH"),
	(034,001,1,"SSH"),

	(034,001,1,"SSH"),
	(034,001,1,"SSH"),
	
	(034,001,1,"SSH");

-- 5 trains (weekends/holidays) south (0)
insert into Trains 
	(train_starts,train_ends,direction,train_days) values 
	(001,034,0,"SSH"),
	(001,034,0,"SSH"),

	(001,034,0,"SSH"),
	(001,034,0,"SSH"),

	(001,034,0,"SSH");

CREATE TABLE stops_at(
	station_id int,
	train_num int ,
	time_in TIME,
	time_out TIME,
	primary key (station_id, train_num),
	FOREIGN KEY(train_num) REFERENCES Trains(train_num),
	FOREIGN KEY(station_id) REFERENCES Stations(station_id)
);


-- north bound trains, starting at (034) USDC M-F


--all stops of train 1 
INSERT INTO stops_at values (034,1,'04:00:00','04:02:00');
INSERT INTO stops_at values (033,1,'04:15:00','04:17:00');
INSERT INTO stops_at values (032,1,'04:30:00','04:32:00');
INSERT INTO stops_at values (031,1,'04:45:00','04:47:00');
INSERT INTO stops_at values (030,1,'05:00:00','05:02:00');
INSERT INTO stops_at values (029,1,'05:15:00','05:17:00');
INSERT INTO stops_at values (028,1,'05:30:00','05:32:00');
INSERT INTO stops_at values (027,1,'05:45:00','05:47:00');
INSERT INTO stops_at values (026,1,'06:00:00','06:02:00');
INSERT INTO stops_at values (025,1,'06:15:00','06:17:00');
INSERT INTO stops_at values (024,1,'06:30:00','06:32:00');
INSERT INTO stops_at values (023,1,'06:45:00','06:47:00');
INSERT INTO stops_at values (022,1,'07:00:00','07:02:00');
INSERT INTO stops_at values (021,1,'07:15:00','07:17:00');
INSERT INTO stops_at values (020,1,'07:30:00','07:32:00');
INSERT INTO stops_at values (019,1,'07:45:00','07:47:00');
INSERT INTO stops_at values (018,1,'08:00:00','08:02:00');
INSERT INTO stops_at values (017,1,'08:15:00','08:17:00');
INSERT INTO stops_at values (016,1,'08:30:00','08:32:00');
INSERT INTO stops_at values (015,1,'08:45:00','08:47:00');
INSERT INTO stops_at values (014,1,'09:00:00','09:02:00');
INSERT INTO stops_at values (013,1,'09:15:00','09:17:00');
INSERT INTO stops_at values (012,1,'09:30:00','09:32:00');
INSERT INTO stops_at values (011,1,'09:45:00','09:47:00');
INSERT INTO stops_at values (010,1,'10:00:00','10:02:00');
INSERT INTO stops_at values (009,1,'10:15:00','10:17:00');
INSERT INTO stops_at values (008,1,'10:30:00','10:32:00');
INSERT INTO stops_at values (007,1,'10:45:00','10:47:00');
INSERT INTO stops_at values (006,1,'11:00:00','11:02:00');
INSERT INTO stops_at values (005,1,'11:15:00','11:17:00');
INSERT INTO stops_at values (004,1,'11:30:00','11:32:00');
INSERT INTO stops_at values (003,1,'11:45:00','11:47:00');
INSERT INTO stops_at values (002,1,'12:00:00','12:02:00');
INSERT INTO stops_at values (001,1,'12:15:00','12:17:00');

--all stops of train 2 
INSERT INTO stops_at values (034,2,'07:00:00','07:02:00');
INSERT INTO stops_at values (033,2,'07:15:00','07:17:00');
INSERT INTO stops_at values (032,2,'07:30:00','07:32:00');
INSERT INTO stops_at values (031,2,'07:45:00','07:47:00');
INSERT INTO stops_at values (030,2,'08:00:00','08:02:00');
INSERT INTO stops_at values (029,2,'08:15:00','08:17:00');
INSERT INTO stops_at values (028,2,'08:30:00','08:32:00');
INSERT INTO stops_at values (027,2,'08:45:00','08:47:00');
INSERT INTO stops_at values (026,2,'09:00:00','09:02:00');
INSERT INTO stops_at values (025,2,'09:15:00','09:17:00');
INSERT INTO stops_at values (024,2,'09:30:00','09:32:00');
INSERT INTO stops_at values (023,2,'09:45:00','09:47:00');
INSERT INTO stops_at values (022,2,'10:00:00','10:02:00');
INSERT INTO stops_at values (021,2,'10:15:00','10:17:00');
INSERT INTO stops_at values (020,2,'10:30:00','10:32:00');
INSERT INTO stops_at values (019,2,'10:45:00','10:47:00');
INSERT INTO stops_at values (018,2,'11:00:00','11:02:00');
INSERT INTO stops_at values (017,2,'11:15:00','11:17:00');
INSERT INTO stops_at values (016,2,'11:30:00','11:32:00');
INSERT INTO stops_at values (015,2,'11:45:00','11:47:00');
INSERT INTO stops_at values (014,2,'12:00:00','12:02:00');
INSERT INTO stops_at values (013,2,'12:15:00','12:17:00');
INSERT INTO stops_at values (012,2,'12:30:00','12:32:00');
INSERT INTO stops_at values (011,2,'12:45:00','12:47:00');
INSERT INTO stops_at values (010,2,'13:00:00','13:02:00');
INSERT INTO stops_at values (009,2,'13:15:00','13:17:00');
INSERT INTO stops_at values (008,2,'13:30:00','13:32:00');
INSERT INTO stops_at values (007,2,'13:45:00','13:47:00');
INSERT INTO stops_at values (006,2,'14:00:00','14:02:00');
INSERT INTO stops_at values (005,2,'14:15:00','14:17:00');
INSERT INTO stops_at values (004,2,'14:30:00','14:32:00');
INSERT INTO stops_at values (003,2,'14:45:00','14:47:00');
INSERT INTO stops_at values (002,2,'15:00:00','15:02:00');
INSERT INTO stops_at values (001,2,'15:15:00','15:17:00');

--all stops of train 3 
INSERT INTO stops_at values (034,3,'10:00:00','10:02:00');
INSERT INTO stops_at values (033,3,'10:15:00','10:17:00');
INSERT INTO stops_at values (032,3,'10:30:00','10:32:00');
INSERT INTO stops_at values (031,3,'10:45:00','10:47:00');
INSERT INTO stops_at values (030,3,'11:00:00','11:02:00');
INSERT INTO stops_at values (029,3,'11:15:00','11:17:00');
INSERT INTO stops_at values (028,3,'11:30:00','11:32:00');
INSERT INTO stops_at values (027,3,'11:45:00','11:47:00');
INSERT INTO stops_at values (026,3,'12:00:00','12:02:00');
INSERT INTO stops_at values (025,3,'12:15:00','12:17:00');
INSERT INTO stops_at values (024,3,'12:30:00','12:32:00');
INSERT INTO stops_at values (023,3,'12:45:00','12:47:00');
INSERT INTO stops_at values (022,3,'13:00:00','13:02:00');
INSERT INTO stops_at values (021,3,'13:15:00','13:17:00');
INSERT INTO stops_at values (020,3,'13:30:00','13:32:00');
INSERT INTO stops_at values (019,3,'13:45:00','13:47:00');
INSERT INTO stops_at values (018,3,'14:00:00','14:02:00');
INSERT INTO stops_at values (017,3,'14:15:00','14:17:00');
INSERT INTO stops_at values (016,3,'14:30:00','14:32:00');
INSERT INTO stops_at values (015,3,'14:45:00','14:47:00');
INSERT INTO stops_at values (014,3,'15:00:00','15:02:00');
INSERT INTO stops_at values (013,3,'15:15:00','15:17:00');
INSERT INTO stops_at values (012,3,'15:30:00','15:32:00');
INSERT INTO stops_at values (011,3,'15:45:00','15:47:00');
INSERT INTO stops_at values (010,3,'16:00:00','16:02:00');
INSERT INTO stops_at values (009,3,'16:15:00','16:17:00');
INSERT INTO stops_at values (008,3,'16:30:00','16:32:00');
INSERT INTO stops_at values (007,3,'16:45:00','16:47:00');
INSERT INTO stops_at values (006,3,'17:00:00','17:02:00');
INSERT INTO stops_at values (005,3,'17:15:00','17:17:00');
INSERT INTO stops_at values (004,3,'17:30:00','17:32:00');
INSERT INTO stops_at values (003,3,'17:45:00','17:47:00');
INSERT INTO stops_at values (002,3,'18:00:00','18:02:00');
INSERT INTO stops_at values (001,3,'18:15:00','18:17:00');

--all stops of train 4 
INSERT INTO stops_at values (034,4,'13:00:00','13:02:00');
INSERT INTO stops_at values (033,4,'13:15:00','13:17:00');
INSERT INTO stops_at values (032,4,'13:30:00','13:32:00');
INSERT INTO stops_at values (031,4,'13:45:00','13:47:00');
INSERT INTO stops_at values (030,4,'14:00:00','14:02:00');
INSERT INTO stops_at values (029,4,'14:15:00','14:17:00');
INSERT INTO stops_at values (028,4,'14:30:00','14:32:00');
INSERT INTO stops_at values (027,4,'14:45:00','14:47:00');
INSERT INTO stops_at values (026,4,'15:00:00','15:02:00');
INSERT INTO stops_at values (025,4,'15:15:00','15:17:00');
INSERT INTO stops_at values (024,4,'15:30:00','15:32:00');
INSERT INTO stops_at values (023,4,'15:45:00','15:47:00');
INSERT INTO stops_at values (022,4,'16:00:00','16:02:00');
INSERT INTO stops_at values (021,4,'16:15:00','16:17:00');
INSERT INTO stops_at values (020,4,'16:30:00','16:32:00');
INSERT INTO stops_at values (019,4,'16:45:00','16:47:00');
INSERT INTO stops_at values (018,4,'17:00:00','17:02:00');
INSERT INTO stops_at values (017,4,'17:15:00','17:17:00');
INSERT INTO stops_at values (016,4,'17:30:00','17:32:00');
INSERT INTO stops_at values (015,4,'17:45:00','17:47:00');
INSERT INTO stops_at values (014,4,'18:00:00','18:02:00');
INSERT INTO stops_at values (013,4,'18:15:00','18:17:00');
INSERT INTO stops_at values (012,4,'18:30:00','18:32:00');
INSERT INTO stops_at values (011,4,'18:45:00','18:47:00');
INSERT INTO stops_at values (010,4,'19:00:00','19:02:00');
INSERT INTO stops_at values (009,4,'19:15:00','19:17:00');
INSERT INTO stops_at values (008,4,'19:30:00','19:32:00');
INSERT INTO stops_at values (007,4,'19:45:00','19:47:00');
INSERT INTO stops_at values (006,4,'20:00:00','20:02:00');
INSERT INTO stops_at values (005,4,'20:15:00','20:17:00');
INSERT INTO stops_at values (004,4,'20:30:00','20:32:00');
INSERT INTO stops_at values (003,4,'20:45:00','20:47:00');
INSERT INTO stops_at values (002,4,'21:00:00','21:02:00');
INSERT INTO stops_at values (001,4,'21:15:00','21:17:00');

--all stops of train 5 
INSERT INTO stops_at values (034,5,'15:00:00','15:02:00');
INSERT INTO stops_at values (033,5,'15:15:00','15:17:00');
INSERT INTO stops_at values (032,5,'15:30:00','15:32:00');
INSERT INTO stops_at values (031,5,'15:45:00','15:47:00');
INSERT INTO stops_at values (030,5,'16:00:00','16:02:00');
INSERT INTO stops_at values (029,5,'16:15:00','16:17:00');
INSERT INTO stops_at values (028,5,'16:30:00','16:32:00');
INSERT INTO stops_at values (027,5,'16:45:00','16:47:00');
INSERT INTO stops_at values (026,5,'17:00:00','17:02:00');
INSERT INTO stops_at values (025,5,'17:15:00','17:17:00');
INSERT INTO stops_at values (024,5,'17:30:00','17:32:00');
INSERT INTO stops_at values (023,5,'17:45:00','17:47:00');
INSERT INTO stops_at values (022,5,'18:00:00','18:02:00');
INSERT INTO stops_at values (021,5,'18:15:00','18:17:00');
INSERT INTO stops_at values (020,5,'18:30:00','18:32:00');
INSERT INTO stops_at values (019,5,'18:45:00','18:47:00');
INSERT INTO stops_at values (018,5,'19:00:00','19:02:00');
INSERT INTO stops_at values (017,5,'19:15:00','19:17:00');
INSERT INTO stops_at values (016,5,'19:30:00','19:32:00');
INSERT INTO stops_at values (015,5,'19:45:00','19:47:00');
INSERT INTO stops_at values (014,5,'20:00:00','20:02:00');
INSERT INTO stops_at values (013,5,'20:15:00','20:17:00');
INSERT INTO stops_at values (012,5,'20:30:00','20:32:00');
INSERT INTO stops_at values (011,5,'20:45:00','20:47:00');
INSERT INTO stops_at values (010,5,'21:00:00','21:02:00');
INSERT INTO stops_at values (009,5,'21:15:00','21:17:00');
INSERT INTO stops_at values (008,5,'21:30:00','21:32:00');
INSERT INTO stops_at values (007,5,'21:45:00','21:47:00');
INSERT INTO stops_at values (006,5,'22:00:00','22:02:00');
INSERT INTO stops_at values (005,5,'22:15:00','22:17:00');
INSERT INTO stops_at values (004,5,'22:30:00','22:32:00');
INSERT INTO stops_at values (003,5,'22:45:00','22:47:00');
INSERT INTO stops_at values (002,5,'23:00:00','23:02:00');
INSERT INTO stops_at values (001,5,'23:15:00','23:17:00');

--all stops of train 6 
INSERT INTO stops_at values (034,6,'17:00:00','17:02:00');
INSERT INTO stops_at values (033,6,'17:15:00','17:17:00');
INSERT INTO stops_at values (032,6,'17:30:00','17:32:00');
INSERT INTO stops_at values (031,6,'17:45:00','17:47:00');
INSERT INTO stops_at values (030,6,'18:00:00','18:02:00');
INSERT INTO stops_at values (029,6,'18:15:00','18:17:00');
INSERT INTO stops_at values (028,6,'18:30:00','18:32:00');
INSERT INTO stops_at values (027,6,'18:45:00','18:47:00');
INSERT INTO stops_at values (026,6,'19:00:00','19:02:00');
INSERT INTO stops_at values (025,6,'19:15:00','19:17:00');
INSERT INTO stops_at values (024,6,'19:30:00','19:32:00');
INSERT INTO stops_at values (023,6,'19:45:00','19:47:00');
INSERT INTO stops_at values (022,6,'20:00:00','20:02:00');
INSERT INTO stops_at values (021,6,'20:15:00','20:17:00');
INSERT INTO stops_at values (020,6,'20:30:00','20:32:00');
INSERT INTO stops_at values (019,6,'20:45:00','20:47:00');
INSERT INTO stops_at values (018,6,'21:00:00','21:02:00');
INSERT INTO stops_at values (017,6,'21:15:00','21:17:00');
INSERT INTO stops_at values (016,6,'21:30:00','21:32:00');
INSERT INTO stops_at values (015,6,'21:45:00','21:47:00');
INSERT INTO stops_at values (014,6,'22:00:00','22:02:00');
INSERT INTO stops_at values (013,6,'22:15:00','22:17:00');
INSERT INTO stops_at values (012,6,'22:30:00','22:32:00');
INSERT INTO stops_at values (011,6,'22:45:00','22:47:00');
INSERT INTO stops_at values (010,6,'23:00:00','23:02:00');
INSERT INTO stops_at values (009,6,'23:15:00','23:17:00');
INSERT INTO stops_at values (008,6,'23:30:00','23:32:00');
INSERT INTO stops_at values (007,6,'23:45:00','23:47:00');
INSERT INTO stops_at values (006,6,'00:00:00','00:02:00');
INSERT INTO stops_at values (005,6,'00:15:00','00:17:00');
INSERT INTO stops_at values (004,6,'00:30:00','00:32:00');
INSERT INTO stops_at values (003,6,'00:45:00','00:47:00');
INSERT INTO stops_at values (002,6,'01:00:00','01:02:00');
INSERT INTO stops_at values (001,6,'01:15:00','01:17:00');

--all stops of train 7 
INSERT INTO stops_at values (034,7,'19:00:00','19:02:00');
INSERT INTO stops_at values (033,7,'19:15:00','19:17:00');
INSERT INTO stops_at values (032,7,'19:30:00','19:32:00');
INSERT INTO stops_at values (031,7,'19:45:00','19:47:00');
INSERT INTO stops_at values (030,7,'20:00:00','20:02:00');
INSERT INTO stops_at values (029,7,'20:15:00','20:17:00');
INSERT INTO stops_at values (028,7,'20:30:00','20:32:00');
INSERT INTO stops_at values (027,7,'20:45:00','20:47:00');
INSERT INTO stops_at values (026,7,'21:00:00','21:02:00');
INSERT INTO stops_at values (025,7,'21:15:00','21:17:00');
INSERT INTO stops_at values (024,7,'21:30:00','21:32:00');
INSERT INTO stops_at values (023,7,'21:45:00','21:47:00');
INSERT INTO stops_at values (022,7,'22:00:00','22:02:00');
INSERT INTO stops_at values (021,7,'22:15:00','22:17:00');
INSERT INTO stops_at values (020,7,'22:30:00','22:32:00');
INSERT INTO stops_at values (019,7,'22:45:00','22:47:00');
INSERT INTO stops_at values (018,7,'23:00:00','23:02:00');
INSERT INTO stops_at values (017,7,'23:15:00','23:17:00');
INSERT INTO stops_at values (016,7,'23:30:00','23:32:00');
INSERT INTO stops_at values (015,7,'23:45:00','23:47:00');
INSERT INTO stops_at values (014,7,'00:00:00','00:02:00');
INSERT INTO stops_at values (013,7,'00:15:00','00:17:00');
INSERT INTO stops_at values (012,7,'00:30:00','00:32:00');
INSERT INTO stops_at values (011,7,'00:45:00','00:47:00');
INSERT INTO stops_at values (010,7,'01:00:00','01:02:00');
INSERT INTO stops_at values (009,7,'01:15:00','01:17:00');
INSERT INTO stops_at values (008,7,'01:30:00','01:32:00');
INSERT INTO stops_at values (007,7,'01:45:00','01:47:00');
INSERT INTO stops_at values (006,7,'02:00:00','02:02:00');
INSERT INTO stops_at values (005,7,'02:15:00','02:17:00');
INSERT INTO stops_at values (004,7,'02:30:00','02:32:00');
INSERT INTO stops_at values (003,7,'02:45:00','02:47:00');
INSERT INTO stops_at values (002,7,'03:00:00','03:02:00');
INSERT INTO stops_at values (001,7,'03:15:00','03:17:00');

--all stops of train 8 
INSERT INTO stops_at values (034,8,'21:00:00','21:02:00');
INSERT INTO stops_at values (033,8,'21:15:00','21:17:00');
INSERT INTO stops_at values (032,8,'21:30:00','21:32:00');
INSERT INTO stops_at values (031,8,'21:45:00','21:47:00');
INSERT INTO stops_at values (030,8,'22:00:00','22:02:00');
INSERT INTO stops_at values (029,8,'22:15:00','22:17:00');
INSERT INTO stops_at values (028,8,'22:30:00','22:32:00');
INSERT INTO stops_at values (027,8,'22:45:00','22:47:00');
INSERT INTO stops_at values (026,8,'23:00:00','23:02:00');
INSERT INTO stops_at values (025,8,'23:15:00','23:17:00');
INSERT INTO stops_at values (024,8,'23:30:00','23:32:00');
INSERT INTO stops_at values (023,8,'23:45:00','23:47:00');
INSERT INTO stops_at values (022,8,'00:00:00','00:02:00');
INSERT INTO stops_at values (021,8,'00:15:00','00:17:00');
INSERT INTO stops_at values (020,8,'00:30:00','00:32:00');
INSERT INTO stops_at values (019,8,'00:45:00','00:47:00');
INSERT INTO stops_at values (018,8,'01:00:00','01:02:00');
INSERT INTO stops_at values (017,8,'01:15:00','01:17:00');
INSERT INTO stops_at values (016,8,'01:30:00','01:32:00');
INSERT INTO stops_at values (015,8,'01:45:00','01:47:00');
INSERT INTO stops_at values (014,8,'02:00:00','02:02:00');
INSERT INTO stops_at values (013,8,'02:15:00','02:17:00');
INSERT INTO stops_at values (012,8,'02:30:00','02:32:00');
INSERT INTO stops_at values (011,8,'02:45:00','02:47:00');
INSERT INTO stops_at values (010,8,'03:00:00','03:02:00');
INSERT INTO stops_at values (009,8,'03:15:00','03:17:00');
INSERT INTO stops_at values (008,8,'03:30:00','03:32:00');
INSERT INTO stops_at values (007,8,'03:45:00','03:47:00');
INSERT INTO stops_at values (006,8,'04:00:00','04:02:00');
INSERT INTO stops_at values (005,8,'04:15:00','04:17:00');
INSERT INTO stops_at values (004,8,'04:30:00','04:32:00');
INSERT INTO stops_at values (003,8,'04:45:00','04:47:00');
INSERT INTO stops_at values (002,8,'05:00:00','05:02:00');
INSERT INTO stops_at values (001,8,'05:15:00','05:17:00');


-- south bound trains MF

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
INSERT INTO stops_at values (027,9,'10:30:00','10:32:00');
INSERT INTO stops_at values (028,9,'10:45:00','10:47:00');
INSERT INTO stops_at values (029,9,'11:00:00','11:02:00');
INSERT INTO stops_at values (030,9,'11:15:00','11:17:00');
INSERT INTO stops_at values (031,9,'11:30:00','11:32:00');
INSERT INTO stops_at values (032,9,'11:45:00','11:47:00');
INSERT INTO stops_at values (033,9,'12:00:00','12:02:00');
INSERT INTO stops_at values (034,9,'12:15:00','12:17:00');

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
INSERT INTO stops_at values (027,10,'13:30:00','13:32:00');
INSERT INTO stops_at values (028,10,'13:45:00','13:47:00');
INSERT INTO stops_at values (029,10,'14:00:00','14:02:00');
INSERT INTO stops_at values (030,10,'14:15:00','14:17:00');
INSERT INTO stops_at values (031,10,'14:30:00','14:32:00');
INSERT INTO stops_at values (032,10,'14:45:00','14:47:00');
INSERT INTO stops_at values (033,10,'15:00:00','15:02:00');
INSERT INTO stops_at values (034,10,'15:15:00','15:17:00');

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
INSERT INTO stops_at values (027,11,'16:30:00','16:32:00');
INSERT INTO stops_at values (028,11,'16:45:00','16:47:00');
INSERT INTO stops_at values (029,11,'17:00:00','17:02:00');
INSERT INTO stops_at values (030,11,'17:15:00','17:17:00');
INSERT INTO stops_at values (031,11,'17:30:00','17:32:00');
INSERT INTO stops_at values (032,11,'17:45:00','17:47:00');
INSERT INTO stops_at values (033,11,'18:00:00','18:02:00');
INSERT INTO stops_at values (034,11,'18:15:00','18:17:00');

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
INSERT INTO stops_at values (027,12,'19:30:00','19:32:00');
INSERT INTO stops_at values (028,12,'19:45:00','19:47:00');
INSERT INTO stops_at values (029,12,'20:00:00','20:02:00');
INSERT INTO stops_at values (030,12,'20:15:00','20:17:00');
INSERT INTO stops_at values (031,12,'20:30:00','20:32:00');
INSERT INTO stops_at values (032,12,'20:45:00','20:47:00');
INSERT INTO stops_at values (033,12,'21:00:00','21:02:00');
INSERT INTO stops_at values (034,12,'21:15:00','21:17:00');

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
INSERT INTO stops_at values (027,13,'21:30:00','21:32:00');
INSERT INTO stops_at values (028,13,'21:45:00','21:47:00');
INSERT INTO stops_at values (029,13,'22:00:00','22:02:00');
INSERT INTO stops_at values (030,13,'22:15:00','22:17:00');
INSERT INTO stops_at values (031,13,'22:30:00','22:32:00');
INSERT INTO stops_at values (032,13,'22:45:00','22:47:00');
INSERT INTO stops_at values (033,13,'23:00:00','23:02:00');
INSERT INTO stops_at values (034,13,'23:15:00','23:17:00');

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
INSERT INTO stops_at values (027,14,'23:30:00','23:32:00');
INSERT INTO stops_at values (028,14,'23:45:00','23:47:00');
INSERT INTO stops_at values (029,14,'00:00:00','00:02:00');
INSERT INTO stops_at values (030,14,'00:15:00','00:17:00');
INSERT INTO stops_at values (031,14,'00:30:00','00:32:00');
INSERT INTO stops_at values (032,14,'00:45:00','00:47:00');
INSERT INTO stops_at values (033,14,'01:00:00','01:02:00');
INSERT INTO stops_at values (034,14,'01:15:00','01:17:00');

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
INSERT INTO stops_at values (027,15,'01:30:00','01:32:00');
INSERT INTO stops_at values (028,15,'01:45:00','01:47:00');
INSERT INTO stops_at values (029,15,'02:00:00','02:02:00');
INSERT INTO stops_at values (030,15,'02:15:00','02:17:00');
INSERT INTO stops_at values (031,15,'02:30:00','02:32:00');
INSERT INTO stops_at values (032,15,'02:45:00','02:47:00');
INSERT INTO stops_at values (033,15,'03:00:00','03:02:00');
INSERT INTO stops_at values (034,15,'03:15:00','03:17:00');

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
INSERT INTO stops_at values (027,16,'03:30:00','03:32:00');
INSERT INTO stops_at values (028,16,'03:45:00','03:47:00');
INSERT INTO stops_at values (029,16,'04:00:00','04:02:00');
INSERT INTO stops_at values (030,16,'04:15:00','04:17:00');
INSERT INTO stops_at values (031,16,'04:30:00','04:32:00');
INSERT INTO stops_at values (032,16,'04:45:00','04:47:00');
INSERT INTO stops_at values (033,16,'05:00:00','05:02:00');
INSERT INTO stops_at values (034,16,'05:15:00','05:17:00');

-- north bound trains SSH


--all stops of train 17 
INSERT INTO stops_at values (034,17,'06:00:00','06:02:00');
INSERT INTO stops_at values (033,17,'06:15:00','06:17:00');
INSERT INTO stops_at values (032,17,'06:30:00','06:32:00');
INSERT INTO stops_at values (031,17,'06:45:00','06:47:00');
INSERT INTO stops_at values (030,17,'07:00:00','07:02:00');
INSERT INTO stops_at values (029,17,'07:15:00','07:17:00');
INSERT INTO stops_at values (028,17,'07:30:00','07:32:00');
INSERT INTO stops_at values (027,17,'07:45:00','07:47:00');
INSERT INTO stops_at values (026,17,'08:00:00','08:02:00');
INSERT INTO stops_at values (025,17,'08:15:00','08:17:00');
INSERT INTO stops_at values (024,17,'08:30:00','08:32:00');
INSERT INTO stops_at values (023,17,'08:45:00','08:47:00');
INSERT INTO stops_at values (022,17,'09:00:00','09:02:00');
INSERT INTO stops_at values (021,17,'09:15:00','09:17:00');
INSERT INTO stops_at values (020,17,'09:30:00','09:32:00');
INSERT INTO stops_at values (019,17,'09:45:00','09:47:00');
INSERT INTO stops_at values (018,17,'10:00:00','10:02:00');
INSERT INTO stops_at values (017,17,'10:15:00','10:17:00');
INSERT INTO stops_at values (016,17,'10:30:00','10:32:00');
INSERT INTO stops_at values (015,17,'10:45:00','10:47:00');
INSERT INTO stops_at values (014,17,'11:00:00','11:02:00');
INSERT INTO stops_at values (013,17,'11:15:00','11:17:00');
INSERT INTO stops_at values (012,17,'11:30:00','11:32:00');
INSERT INTO stops_at values (011,17,'11:45:00','11:47:00');
INSERT INTO stops_at values (010,17,'12:00:00','12:02:00');
INSERT INTO stops_at values (009,17,'12:15:00','12:17:00');
INSERT INTO stops_at values (008,17,'12:30:00','12:32:00');
INSERT INTO stops_at values (007,17,'12:45:00','12:47:00');
INSERT INTO stops_at values (006,17,'13:00:00','13:02:00');
INSERT INTO stops_at values (005,17,'13:15:00','13:17:00');
INSERT INTO stops_at values (004,17,'13:30:00','13:32:00');
INSERT INTO stops_at values (003,17,'13:45:00','13:47:00');
INSERT INTO stops_at values (002,17,'14:00:00','14:02:00');
INSERT INTO stops_at values (001,17,'14:15:00','14:17:00');

--all stops of train 18 
INSERT INTO stops_at values (034,18,'09:00:00','09:02:00');
INSERT INTO stops_at values (033,18,'09:15:00','09:17:00');
INSERT INTO stops_at values (032,18,'09:30:00','09:32:00');
INSERT INTO stops_at values (031,18,'09:45:00','09:47:00');
INSERT INTO stops_at values (030,18,'10:00:00','10:02:00');
INSERT INTO stops_at values (029,18,'10:15:00','10:17:00');
INSERT INTO stops_at values (028,18,'10:30:00','10:32:00');
INSERT INTO stops_at values (027,18,'10:45:00','10:47:00');
INSERT INTO stops_at values (026,18,'11:00:00','11:02:00');
INSERT INTO stops_at values (025,18,'11:15:00','11:17:00');
INSERT INTO stops_at values (024,18,'11:30:00','11:32:00');
INSERT INTO stops_at values (023,18,'11:45:00','11:47:00');
INSERT INTO stops_at values (022,18,'12:00:00','12:02:00');
INSERT INTO stops_at values (021,18,'12:15:00','12:17:00');
INSERT INTO stops_at values (020,18,'12:30:00','12:32:00');
INSERT INTO stops_at values (019,18,'12:45:00','12:47:00');
INSERT INTO stops_at values (018,18,'13:00:00','13:02:00');
INSERT INTO stops_at values (017,18,'13:15:00','13:17:00');
INSERT INTO stops_at values (016,18,'13:30:00','13:32:00');
INSERT INTO stops_at values (015,18,'13:45:00','13:47:00');
INSERT INTO stops_at values (014,18,'14:00:00','14:02:00');
INSERT INTO stops_at values (013,18,'14:15:00','14:17:00');
INSERT INTO stops_at values (012,18,'14:30:00','14:32:00');
INSERT INTO stops_at values (011,18,'14:45:00','14:47:00');
INSERT INTO stops_at values (010,18,'15:00:00','15:02:00');
INSERT INTO stops_at values (009,18,'15:15:00','15:17:00');
INSERT INTO stops_at values (008,18,'15:30:00','15:32:00');
INSERT INTO stops_at values (007,18,'15:45:00','15:47:00');
INSERT INTO stops_at values (006,18,'16:00:00','16:02:00');
INSERT INTO stops_at values (005,18,'16:15:00','16:17:00');
INSERT INTO stops_at values (004,18,'16:30:00','16:32:00');
INSERT INTO stops_at values (003,18,'16:45:00','16:47:00');
INSERT INTO stops_at values (002,18,'17:00:00','17:02:00');
INSERT INTO stops_at values (001,18,'17:15:00','17:17:00');

--all stops of train 19 
INSERT INTO stops_at values (034,19,'13:00:00','13:02:00');
INSERT INTO stops_at values (033,19,'13:15:00','13:17:00');
INSERT INTO stops_at values (032,19,'13:30:00','13:32:00');
INSERT INTO stops_at values (031,19,'13:45:00','13:47:00');
INSERT INTO stops_at values (030,19,'14:00:00','14:02:00');
INSERT INTO stops_at values (029,19,'14:15:00','14:17:00');
INSERT INTO stops_at values (028,19,'14:30:00','14:32:00');
INSERT INTO stops_at values (027,19,'14:45:00','14:47:00');
INSERT INTO stops_at values (026,19,'15:00:00','15:02:00');
INSERT INTO stops_at values (025,19,'15:15:00','15:17:00');
INSERT INTO stops_at values (024,19,'15:30:00','15:32:00');
INSERT INTO stops_at values (023,19,'15:45:00','15:47:00');
INSERT INTO stops_at values (022,19,'16:00:00','16:02:00');
INSERT INTO stops_at values (021,19,'16:15:00','16:17:00');
INSERT INTO stops_at values (020,19,'16:30:00','16:32:00');
INSERT INTO stops_at values (019,19,'16:45:00','16:47:00');
INSERT INTO stops_at values (018,19,'17:00:00','17:02:00');
INSERT INTO stops_at values (017,19,'17:15:00','17:17:00');
INSERT INTO stops_at values (016,19,'17:30:00','17:32:00');
INSERT INTO stops_at values (015,19,'17:45:00','17:47:00');
INSERT INTO stops_at values (014,19,'18:00:00','18:02:00');
INSERT INTO stops_at values (013,19,'18:15:00','18:17:00');
INSERT INTO stops_at values (012,19,'18:30:00','18:32:00');
INSERT INTO stops_at values (011,19,'18:45:00','18:47:00');
INSERT INTO stops_at values (010,19,'19:00:00','19:02:00');
INSERT INTO stops_at values (009,19,'19:15:00','19:17:00');
INSERT INTO stops_at values (008,19,'19:30:00','19:32:00');
INSERT INTO stops_at values (007,19,'19:45:00','19:47:00');
INSERT INTO stops_at values (006,19,'20:00:00','20:02:00');
INSERT INTO stops_at values (005,19,'20:15:00','20:17:00');
INSERT INTO stops_at values (004,19,'20:30:00','20:32:00');
INSERT INTO stops_at values (003,19,'20:45:00','20:47:00');
INSERT INTO stops_at values (002,19,'21:00:00','21:02:00');
INSERT INTO stops_at values (001,19,'21:15:00','21:17:00');

--all stops of train 20 
INSERT INTO stops_at values (034,20,'16:00:00','16:02:00');
INSERT INTO stops_at values (033,20,'16:15:00','16:17:00');
INSERT INTO stops_at values (032,20,'16:30:00','16:32:00');
INSERT INTO stops_at values (031,20,'16:45:00','16:47:00');
INSERT INTO stops_at values (030,20,'17:00:00','17:02:00');
INSERT INTO stops_at values (029,20,'17:15:00','17:17:00');
INSERT INTO stops_at values (028,20,'17:30:00','17:32:00');
INSERT INTO stops_at values (027,20,'17:45:00','17:47:00');
INSERT INTO stops_at values (026,20,'18:00:00','18:02:00');
INSERT INTO stops_at values (025,20,'18:15:00','18:17:00');
INSERT INTO stops_at values (024,20,'18:30:00','18:32:00');
INSERT INTO stops_at values (023,20,'18:45:00','18:47:00');
INSERT INTO stops_at values (022,20,'19:00:00','19:02:00');
INSERT INTO stops_at values (021,20,'19:15:00','19:17:00');
INSERT INTO stops_at values (020,20,'19:30:00','19:32:00');
INSERT INTO stops_at values (019,20,'19:45:00','19:47:00');
INSERT INTO stops_at values (018,20,'20:00:00','20:02:00');
INSERT INTO stops_at values (017,20,'20:15:00','20:17:00');
INSERT INTO stops_at values (016,20,'20:30:00','20:32:00');
INSERT INTO stops_at values (015,20,'20:45:00','20:47:00');
INSERT INTO stops_at values (014,20,'21:00:00','21:02:00');
INSERT INTO stops_at values (013,20,'21:15:00','21:17:00');
INSERT INTO stops_at values (012,20,'21:30:00','21:32:00');
INSERT INTO stops_at values (011,20,'21:45:00','21:47:00');
INSERT INTO stops_at values (010,20,'22:00:00','22:02:00');
INSERT INTO stops_at values (009,20,'22:15:00','22:17:00');
INSERT INTO stops_at values (008,20,'22:30:00','22:32:00');
INSERT INTO stops_at values (007,20,'22:45:00','22:47:00');
INSERT INTO stops_at values (006,20,'23:00:00','23:02:00');
INSERT INTO stops_at values (005,20,'23:15:00','23:17:00');
INSERT INTO stops_at values (004,20,'23:30:00','23:32:00');
INSERT INTO stops_at values (003,20,'23:45:00','23:47:00');
INSERT INTO stops_at values (002,20,'00:00:00','00:02:00');
INSERT INTO stops_at values (001,20,'00:15:00','00:17:00');

--all stops of train 21 
INSERT INTO stops_at values (034,21,'19:00:00','19:02:00');
INSERT INTO stops_at values (033,21,'19:15:00','19:17:00');
INSERT INTO stops_at values (032,21,'19:30:00','19:32:00');
INSERT INTO stops_at values (031,21,'19:45:00','19:47:00');
INSERT INTO stops_at values (030,21,'20:00:00','20:02:00');
INSERT INTO stops_at values (029,21,'20:15:00','20:17:00');
INSERT INTO stops_at values (028,21,'20:30:00','20:32:00');
INSERT INTO stops_at values (027,21,'20:45:00','20:47:00');
INSERT INTO stops_at values (026,21,'21:00:00','21:02:00');
INSERT INTO stops_at values (025,21,'21:15:00','21:17:00');
INSERT INTO stops_at values (024,21,'21:30:00','21:32:00');
INSERT INTO stops_at values (023,21,'21:45:00','21:47:00');
INSERT INTO stops_at values (022,21,'22:00:00','22:02:00');
INSERT INTO stops_at values (021,21,'22:15:00','22:17:00');
INSERT INTO stops_at values (020,21,'22:30:00','22:32:00');
INSERT INTO stops_at values (019,21,'22:45:00','22:47:00');
INSERT INTO stops_at values (018,21,'23:00:00','23:02:00');
INSERT INTO stops_at values (017,21,'23:15:00','23:17:00');
INSERT INTO stops_at values (016,21,'23:30:00','23:32:00');
INSERT INTO stops_at values (015,21,'23:45:00','23:47:00');
INSERT INTO stops_at values (014,21,'00:00:00','00:02:00');
INSERT INTO stops_at values (013,21,'00:15:00','00:17:00');
INSERT INTO stops_at values (012,21,'00:30:00','00:32:00');
INSERT INTO stops_at values (011,21,'00:45:00','00:47:00');
INSERT INTO stops_at values (010,21,'01:00:00','01:02:00');
INSERT INTO stops_at values (009,21,'01:15:00','01:17:00');
INSERT INTO stops_at values (008,21,'01:30:00','01:32:00');
INSERT INTO stops_at values (007,21,'01:45:00','01:47:00');
INSERT INTO stops_at values (006,21,'02:00:00','02:02:00');
INSERT INTO stops_at values (005,21,'02:15:00','02:17:00');
INSERT INTO stops_at values (004,21,'02:30:00','02:32:00');
INSERT INTO stops_at values (003,21,'02:45:00','02:47:00');
INSERT INTO stops_at values (002,21,'03:00:00','03:02:00');
INSERT INTO stops_at values (001,21,'03:15:00','03:17:00');


-- south bound trains SSH


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
INSERT INTO stops_at values (027,22,'12:30:00','12:32:00');
INSERT INTO stops_at values (028,22,'12:45:00','12:47:00');
INSERT INTO stops_at values (029,22,'13:00:00','13:02:00');
INSERT INTO stops_at values (030,22,'13:15:00','13:17:00');
INSERT INTO stops_at values (031,22,'13:30:00','13:32:00');
INSERT INTO stops_at values (032,22,'13:45:00','13:47:00');
INSERT INTO stops_at values (033,22,'14:00:00','14:02:00');
INSERT INTO stops_at values (034,22,'14:15:00','14:17:00');

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
INSERT INTO stops_at values (027,23,'15:30:00','15:32:00');
INSERT INTO stops_at values (028,23,'15:45:00','15:47:00');
INSERT INTO stops_at values (029,23,'16:00:00','16:02:00');
INSERT INTO stops_at values (030,23,'16:15:00','16:17:00');
INSERT INTO stops_at values (031,23,'16:30:00','16:32:00');
INSERT INTO stops_at values (032,23,'16:45:00','16:47:00');
INSERT INTO stops_at values (033,23,'17:00:00','17:02:00');
INSERT INTO stops_at values (034,23,'17:15:00','17:17:00');

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
INSERT INTO stops_at values (027,24,'19:30:00','19:32:00');
INSERT INTO stops_at values (028,24,'19:45:00','19:47:00');
INSERT INTO stops_at values (029,24,'20:00:00','20:02:00');
INSERT INTO stops_at values (030,24,'20:15:00','20:17:00');
INSERT INTO stops_at values (031,24,'20:30:00','20:32:00');
INSERT INTO stops_at values (032,24,'20:45:00','20:47:00');
INSERT INTO stops_at values (033,24,'21:00:00','21:02:00');
INSERT INTO stops_at values (034,24,'21:15:00','21:17:00');

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
INSERT INTO stops_at values (027,25,'22:30:00','22:32:00');
INSERT INTO stops_at values (028,25,'22:45:00','22:47:00');
INSERT INTO stops_at values (029,25,'23:00:00','23:02:00');
INSERT INTO stops_at values (030,25,'23:15:00','23:17:00');
INSERT INTO stops_at values (031,25,'23:30:00','23:32:00');
INSERT INTO stops_at values (032,25,'23:45:00','23:47:00');
INSERT INTO stops_at values (033,25,'00:00:00','00:02:00');
INSERT INTO stops_at values (034,25,'00:15:00','00:17:00');

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
INSERT INTO stops_at values (027,26,'01:30:00','01:32:00');
INSERT INTO stops_at values (028,26,'01:45:00','01:47:00');
INSERT INTO stops_at values (029,26,'02:00:00','02:02:00');
INSERT INTO stops_at values (030,26,'02:15:00','02:17:00');
INSERT INTO stops_at values (031,26,'02:30:00','02:32:00');
INSERT INTO stops_at values (032,26,'02:45:00','02:47:00');
INSERT INTO stops_at values (033,26,'03:00:00','03:02:00');
INSERT INTO stops_at values (034,26,'03:15:00','03:17:00');

CREATE TABLE IF NOT EXISTS Seats_Free(
  sf_train_num INTEGER,
  sf_seg_id INTEGER,
  sf_date DATE,
  sf_seats_free INTEGER,
  PRIMARY KEY(sf_train_num, sf_seg_id, sf_date),
  FOREIGN KEY (sf_train_num) REFERENCES Trains(train_id),
  FOREIGN KEY (sf_seg_id) references Segments(segment_id)
);

-- Placeholder values
INSERT INTO Seats_Free VALUES (001, 1001, 2017-04-10, 448);
INSERT INTO Seats_Free VALUES (001, 1002, 2017-04-10, 447);
INSERT INTO Seats_Free VALUES (001, 1003, 2017-04-10, 446);
INSERT INTO Seats_Free VALUES (001, 1004, 2017-04-10, 445);
INSERT INTO Seats_Free VALUES (001, 1005, 2017-04-10, 444);
INSERT INTO Seats_Free VALUES (001, 1006, 2017-04-10, 443);
INSERT INTO Seats_Free VALUES (001, 1007, 2017-04-10, 442);
INSERT INTO Seats_Free VALUES (001, 1008, 2017-04-10, 441);
INSERT INTO Seats_Free VALUES (001, 1009, 2017-04-10, 440);
INSERT INTO Seats_Free VALUES (001, 1010, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1011, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1012, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1013, 2017-04-10, 438);
INSERT INTO Seats_Free VALUES (001, 1014, 2017-04-10, 437);
INSERT INTO Seats_Free VALUES (001, 1015, 2017-04-10, 430);
INSERT INTO Seats_Free VALUES (001, 1016, 2017-04-10, 435);
INSERT INTO Seats_Free VALUES (001, 1017, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1018, 2017-04-10, 423);
INSERT INTO Seats_Free VALUES (001, 1019, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1020, 2017-04-10, 444);
INSERT INTO Seats_Free VALUES (001, 1021, 2017-04-10, 437);
INSERT INTO Seats_Free VALUES (001, 1023, 2017-04-10, 435);
INSERT INTO Seats_Free VALUES (001, 1024, 2017-04-10, 432);
INSERT INTO Seats_Free VALUES (001, 1025, 2017-04-10, 425);
INSERT INTO Seats_Free VALUES (001, 1026, 2017-04-10, 432);
INSERT INTO Seats_Free VALUES (001, 1027, 2017-04-10, 439);
INSERT INTO Seats_Free VALUES (001, 1028, 2017-04-10, 437);
INSERT INTO Seats_Free VALUES (001, 1029, 2017-04-10, 430);
INSERT INTO Seats_Free VALUES (001, 1030, 2017-04-10, 444);
INSERT INTO Seats_Free VALUES (001, 1031, 2017-04-10, 432);
INSERT INTO Seats_Free VALUES (001, 1032, 2017-04-10, 432);
INSERT INTO Seats_Free VALUES (001, 1033, 2017-04-10, 418);

