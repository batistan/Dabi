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
INSERT INTO Stations VALUES (003, 'Route 128, MA', 'RTMS');
INSERT INTO Stations VALUES (004, 'Providence, RI', 'PRVD');
INSERT INTO Stations VALUES (006, 'Kingston, RI', 'KING');
INSERT INTO Stations VALUES (007, 'Westerly, RI', 'WSLY');
INSERT INTO Stations VALUES (008, 'Mystic, CT', 'MYST');
INSERT INTO Stations VALUES (009, 'New London, CT', 'NLND');
INSERT INTO Stations VALUES (010, 'Old Saybrook, CT', 'OSYB');
INSERT INTO Stations VALUES (011, 'Springfiel, CT', 'SPRG');
INSERT INTO Stations VALUES (012, 'Windsor Locks, CT', 'WNLK');
INSERT INTO Stations VALUES (013, 'Windso, CT', 'WNSR');
INSERT INTO Stations VALUES (014, 'Hartford, CT', 'HRTD');
INSERT INTO Stations VALUES (015, 'Berlin, CT', 'BRLN');
INSERT INTO Stations VALUES (016, 'Meriden, CT', 'MRDN');
INSERT INTO Stations VALUES (017, 'Wallingford, CT', 'WLFD');
INSERT INTO Stations VALUES (018, 'New Haven, CT', 'NHVN');
INSERT INTO Stations VALUES (019, 'Bridgeport, CT', 'BDPR');
INSERT INTO Stations VALUES (020, 'Stamford, CT', 'STMF');
INSERT INTO Stations VALUES (021, 'New Rochelle, NY', 'NRCH');
INSERT INTO Stations VALUES (022, 'New York Penn Station, NY', 'NYPS');
INSERT INTO Stations VALUES (023, 'Newark Penn Station, NJ', 'NJPS');
INSERT INTO Stations VALUES (024, 'Newark Liberty Airport, NJ', 'LIBR');
INSERT INTO Stations VALUES (025, 'Metropark, NJ', 'MTRP');
INSERT INTO Stations VALUES (026, 'Trenton, NJ', 'TRNT');
INSERT INTO Stations VALUES (027, '30th Street Station, PA', 'PHLY');
INSERT INTO Stations VALUES (028, 'Wilmington, DE', 'WGTN');
INSERT INTO Stations VALUES (029, 'Newark, DE', 'NRDE');
INSERT INTO Stations VALUES (030, 'Aberdeen, MD', 'ABRD');
INSERT INTO Stations VALUES (031, 'Baltimore Penn Station, MD', 'MDPS');
INSERT INTO Stations VALUES (032, 'BWI Marshall Airport, MD', 'BWIM');
INSERT INTO Stations VALUES (033, 'New Carrollton, MD', 'NCRL');
INSERT INTO Stations VALUES (034, 'Union Station, DC', 'USDC');


INSERT INTO Segments VALUES (1001,001, 002 );
INSERT INTO Segments VALUES (1002,002, 003 );
INSERT INTO Segments VALUES (1003,003, 004 );
INSERT INTO Segments VALUES (1004,004, 005 );
INSERT INTO Segments VALUES (1005,005, 006 );
INSERT INTO Segments VALUES (1006,006, 007 );
INSERT INTO Segments VALUES (1007,007, 008 );
INSERT INTO Segments VALUES (1008,008, 009 );
INSERT INTO Segments VALUES (1009,009, 010 );
INSERT INTO Segments VALUES (1010,010, 011 );
INSERT INTO Segments VALUES (1011,011, 012 );
INSERT INTO Segments VALUES (1012,012, 013 );
INSERT INTO Segments VALUES (1013,013, 014 );
INSERT INTO Segments VALUES (1014,014, 015 );
INSERT INTO Segments VALUES (1015,015, 016 );
INSERT INTO Segments VALUES (1016,016, 017 );
INSERT INTO Segments VALUES (1017,017, 018 );
INSERT INTO Segments VALUES (1018,018, 019 );
INSERT INTO Segments VALUES (1019,019, 020 );
INSERT INTO Segments VALUES (1020,020, 021 );
INSERT INTO Segments VALUES (1021,021, 022 );
INSERT INTO Segments VALUES (1022,022, 023 );
INSERT INTO Segments VALUES (1023,023, 024 );
INSERT INTO Segments VALUES (1024,024, 025 );
INSERT INTO Segments VALUES (1025,025, 026 );
INSERT INTO Segments VALUES (1026,026, 027 );
INSERT INTO Segments VALUES (1027,027, 028 );
INSERT INTO Segments VALUES (1028,028, 029 );
INSERT INTO Segments VALUES (1029,029, 030 );
INSERT INTO Segments VALUES (1030,030, 031 );
INSERT INTO Segments VALUES (1031,031, 032 );
INSERT INTO Segments VALUES (1032,032, 033 );
INSERT INTO Segments VALUES (1033,033, 034 );


