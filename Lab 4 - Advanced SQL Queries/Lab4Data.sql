-- Alexandre Billard
-- 6812210
-- Lab 4


﻿SET search_path = "laboratories";

--------------CREATE TABLE exercise------------------------------

CREATE TABLE Artist
(
AName VARCHAR(20),
Birthplace VARCHAR(20),
Style VARCHAR(20),
DateOfBirth DATE,
PRIMARY KEY (AName)
);

CREATE TABLE Artwork
(
Title VARCHAR(20),
Year INTEGER,
Type VARCHAR(20),
Price NUMERIC(8,2),
AName VARCHAR(20),
PRIMARY KEY (Title),
CONSTRAINT Artwork_aname_fk FOREIGN KEY (AName) REFERENCES Artist
);

CREATE TABLE Customer
(
CustId INTEGER,
Name VARCHAR(20),
Address VARCHAR(20),
Amount NUMERIC(8,2),
PRIMARY KEY (CustId)
);

CREATE TABLE LikeArtist
(
CustId INTEGER,
AName VARCHAR(20),
PRIMARY KEY(Aname, CustId),
FOREIGN KEY (Aname) REFERENCES Artist,
FOREIGN KEY (CustId) REFERENCES Customer
);

-------------Inserting into values-----------------------

INSERT INTO Customer(CustId,Name,Address,Amount)
VALUES	(1,'John', 'Ottawa', 8.5),
	(2,'Amy', 'Orleans', 9.0),
	(3,'Peter', 'Gatineau', 6.3);

INSERT INTO Artist(AName,Birthplace, Style, DateOfBirth)
VALUES ('Caravaggio', 'Milan', 'Baroque', '1571-09-28'),
	('Smith', 'Ottawa', 'Modern', '1977-12-12'),
	('Picasso', 'Malaga', 'Cubism', '1881-10-25');

INSERT INTO Artwork(Title,Year,Type,Price,AName)
VALUES 	('Blue', 2000, 'Modern', 10000.00, 'Smith'),
	('The Cardsharps', 1594, 'Baroque', 40000.00, 'Caravaggio');

--------UPDATE Exercise------------------

UPDATE Customer SET name='Bruce' WHERE custid=1;

UPDATE Customer SET amount=9.8 , address='Gatineau';

-----------DELETE Exercise-----------------

DELETE FROM Customer WHERE name='Bruce';

DELETE FROM Customer;

----------------ALTER TABLE Exercise---------------

ALTER TABLE Artist ADD COLUMN Country VARCHAR(20);

ALTER TABLE Customer ADD COLUMN Rating INT
	CHECK (Rating BETWEEN 1 AND 10);

-----------More INSERT Exercise-----------------

INSERT INTO Artist(AName, Birthplace, Style, Dateofbirth, Country)
VALUES 	('Leonardo', 'Florence', 'Renaissance', '04-15-1452', 'Italy'),
	('Michelangelo', 'Arezzo', 'Renaissance', '03-06-1475', 'Italy'),
	('Josefa', 'Seville', 'Baroque', '09-09-1630', 'Spain'),
	('Hans Hofmann', 'Weisenburg', 'Modern', '02-17-1966', 'Germany'),
	('John', 'SanFrancisco', 'Modern', '02-17-1920', 'USA');

INSERT INTO Artwork(Title, Year, Type, Price, AName)
VALUES 	('Waves', 2000, null, 4000.00, 'John'),
	('Three Musicians', 1921,'Modern',11000.00,'Picasso');

INSERT INTO Customer(CustId, Name, Address, Amount, Rating)
VALUES 	(1,'Emre','Preston',20000.00,5),
	(2,'Saeid',null,40000.00,6);

INSERT INTO LikeArtist(CustId, AName)
VALUES 	(1,'Picasso'),
	(2,'Picasso'),
	(2,'Leonardo');

----------------More ALTER TABLE Exercise---------------

ALTER TABLE Artwork DROP CONSTRAINT Artwork_aname_fk;

ALTER TABLE Artwork ADD CONSTRAINT Artwork_aname_fk
FOREIGN KEY(aname) REFERENCES Artist(aname) ON DELETE CASCADE ON UPDATE CASCADE;

-----------More DELETE Exercise-----------------

DELETE FROM Artist WHERE aname='Smith';
