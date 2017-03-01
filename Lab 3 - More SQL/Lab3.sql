-- Alexandre Billard
-- 6812210
-- Lab 3





--SET search_path='Lab'

--SELECT * FROM  Artist
--SELECT * FROM  Customer
--SELECT * FROM Artwork
--SELECT * FROM LikeArtist



----------------Altering table exercise---------------

--1).
ALTER TABLE Artist
ADD COLUMN Country VARCHAR(20)

--2).
ALTER TABLE Customer
ADD COLUMN Rating INT
CHECK (Rating BETWEEN 1 AND 10)


----To check the correctness of the above constarint run the below query which should throw error--------
INSERT INTO Customer(CustId,Name,Address,Amount,Rating )
VALUES(5,'John','Ottawa',8.5,15)







-----------Insertions------------------
INSERT INTO Artist(aname,birthplace,style,dateofbirth,country)
VALUES ('Leonardo','Florence','Renaissance','04-15-1452','Italy')
,('Michelangelo','Arezzo','Renaissance','03-06-1475','Italy')
,('Josefa','Seville','Baroque','09-09-1630','Spain')
,('Hans Hofmann','Weisenburg','Modern','02-17-1966','Germany')
,('John','SanFrancisco','Modern','02-17-1920','USA');


INSERT INTO Artwork(title,year,type,price,aname)
VALUES ('Waves', 2000, null, 4000.00, 'John')
,('Three Musicians', 1921,'Modern',11000.00,'Picasso')

INSERT INTO Customer(custid,name,address,amount,rating)
VALUES (1,'Emre','Preston',20000.00,5)
,(2,'Saeid',null,40000.00,6)

INSERT INTO LikeArtist(custid,aname)
VALUES (1,'Picasso')
,(2,'Picasso')
,(2,'Leonardo')





------------Exercise: SQL Queries on single table -------------

-- a).
SELECT aname,birthplace
FROM Artist

--b).
SELECT title,price
FROM Artwork
WHERE year > 1600

--c).
SELECT title,type
FROM Artwork
WHERE year = 2000 OR aname='Picasso'

--d).
SELECT aname,birthplace
FROM Artist
WHERE EXTRACT(YEAR FROM dateofbirth) BETWEEN 1880 AND 1930

--e).
SELECT aname,country
FROM Artist
WHERE style IN('Modern','Baroque','Renaissance')

--f).
SELECT * FROM Artwork
ORDER BY title





------Exercise:SQL Queries involving multiple tables-----

--1).
SELECT C.custid,C.name
FROM Customer C,LikeArtist L
WHERE C.custid=L.custid AND L.aname='Picasso'

--2).
SELECT C.name
FROM Customer C,LikeArtist L, Artist A
WHERE C.custid=L.custid AND A.aname=L.aname
AND A.style='Renaissance' AND C.amount > 30000




---------------Delting Rows-------------

---------The following delete statement will throw error as aname from Artist table is referenced as fkey in Artwork table---------
DELETE FROM Artist
WHERE aname='John'


-----------So first drop the fkey constraint and then run the below alter statement to create a Cascading fkey constraint------
ALTER Table Artwork
ADD Constraint Artwork_aname_fk
FOREIGN KEY(aname) REFERENCES Artist(aname)
ON DELETE CASCADE
ON UPDATE CASCADE

------------Now you can run the above delete query successfully-----------------
