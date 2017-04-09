CREATE TABLE Stations (
  station_id INTEGER PRIMARY KEY AUTOINCREMENT,
  station_name TEXT NOT NULL,
  station_code TEXT NOT NULL
);

CREATE TABLE Segments (
  segment_id INTEGER PRIMARY KEY AUTOINCREMENT,
  segment_north INTEGER NOT NULL,
  segment_south INTEGER NOT NULL,
  FOREIGN KEY (segment_north) REFERENCES Stations(station_id),
  FOREIGN KEY (segment_south) REFERENCES Stations(station_id)
);