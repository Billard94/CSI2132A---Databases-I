-- Alexandre Billard
-- 6812210
-- Lab 4

SET search_path='Lab'


--To Rename a schema before restoring the backup

ALTER SCHEMA "Lab"
RENAME  TO "Laboriginal";


-- SELECT * FROM artist
-- SELECT * FROM artwork
-- SELECT * FROM customer
-- SELECT * FROM likeartist

---First Select Queries example

--1).
SELECT C.name,C.custid
FROM customer C,likeartist L
WHERE C.custid=L.custid AND L.aname='Picasso'

--2).
SELECT C.name
FROM customer C,likeartist L, artist A
WHERE C.custid=L.custid AND L.aname=A.aname
 AND A.style='Cubism' AND C.amount > 30000


--- You can also do the above query using the following method
SELECT C.name
FROM customer C
INNER JOIN likeartist L ON C.custid=L.custid
INNER JOIN artist A ON L.aname=A.aname
WHERE A.style='Cubism' AND C.amount > 30000




-----------//Working with Sailors data//----------------
SET SEARCH_PATH='sailors'

-- SELECT * FROM Sailors
-- SELECT * FROM Reserves
-- SELECT * FROM Boats


SELECT * FROM Sailors S, Reserves R, Boats B

--- Using 'IN' Command---------

--1).
SELECT S.sname
FROM Sailors S,Reserves R,Boats B
WHERE S.sid=R.sid AND R.bid=B.bid
AND B.color ='red'
AND S.SID IN (SELECT S1.SID
		FROM Sailors S1,Reserves R1,Boats B1
		WHERE S1.sid=R1.sid AND R1.bid=B1.bid
		AND B1.color='green')


----Exercis Using 'IN' command for Artist(previous schema)----
SET search_path='Lab'

SELECT C.name
FROM customer C,likeartist L, artist A
WHERE C.custid=L.custid AND L.aname=A.aname
AND A.birthplace='Florence'
AND C.custid IN (SELECT C1.custid
		FROM customer C1,likeartist L1, artist A1
		WHERE C1.custid=L1.custid AND L1.aname=A1.aname
		AND A1.birthplace='Malaga' )




--Aggregate Functions--
SET Search_Path='sailors'

--1).
SELECT S.rating, avg(S.age), COUNT(*)Numsailors
FROM Sailors S
WHERE   S.age >=18
GROUP BY S.rating
HAVING COUNT(*) >1

--2).
SELECT S.rating,MIN(S.age)
FROM sailors S
WHERE S.age>=18
GROUP BY S.rating
HAVING ( SELECT COUNT(*)
	FROM sailors S1
	WHERE S1.rating=S.rating
	)>=2


--Inserting some more data to artwork table
SET search_path='Lab'

INSERT INTO artwork(title,year,type,price,aname)
VALUES ('Saints', 1470, 'Renaissance', 30000.00, 'Leonardo')
,('Hand of god', 1510, 'Renaissance', 52000.00, 'Michelangelo')
,('Murder', 1600, 'Baroque', 15000.00, 'Caravaggio')
,('Green', 1950, 'Modern', 5000.00, 'John')


----Exercise-----
--1).
SELECT AVG(A.price)
FROM artwork A
WHERE A.year >1470
GROUP BY A.type
HAVING COUNT(*)>1

--2)
SELECT AVG(A.price)
FROM artwork A
WHERE A.year >1470
GROUP BY A.type
HAVING
	(SELECT COUNT(*)
	FROM artwork A1
	WHERE A1.type=A.type
	)>1


---------Using Not exists-------
SET Search_Path='sailors'

SELECT S.sname
FROM Sailors S
WHERE NOT EXISTS (
		SELECT B.bid
		FROM Boats B
		WHERE NOT EXISTS (
				SELECT R.bid
				FROM Reserves R
				WHERE R.bid = B.bid AND
				R.sid = S.sid
				)
		)




--Inserting  into likeartist--
SET search_path='Lab'

INSERT INTO likeartist(custid,aname)
VALUES(2,'Caravaggio')
,(2,'Hans Hofmann')
,(2,'John')
,(2,'Josefa')
,(2,'Michelangelo')


--1).
SELECT C.name
FROM customer C
WHERE NOT EXISTS(
		SELECT A.aname
		FROM artist A
		WHERE NOT EXISTS
				(
				SELECT L.aname
				FROM likeartist L
				WHERE L.custid=C.custid
				AND L.aname=A.aname)

				)





----Using Temp tables--------
SET Search_Path='sailors'


SELECT Temp.rating,Temp.Average
FROM(
	SELECT S.rating as rating ,AVG(age) Average
	FROM sailors S
	GROUP BY S.rating
)AS Temp

WHERE Temp.Average=(
		SELECT MIN(T.Average) AS MinAverage
		FROM (
			SELECT 	S.rating,AVG(age) Average
			FROM sailors S
			GROUP BY S.rating
		)T
)



----Exercise for temp tables----

SET search_path='Lab'

DELETE FROM artwork WHERE price = 4000.00;


--1).

SELECT Temp.ArtType, Temp.AvgPrice
FROM(
	SELECT A.Type AS ArtType,AVG(A.price) AS AvgPrice
	FROM artwork A
	GROUP BY A.Type
	)AS Temp

WHERE Temp.AvgPrice= (
			SELECT MIN(T.price) AS Minprice
			FROM(
				SELECT A.Type,AVG(A.price) AS price
				FROM artwork A
				GROUP BY A.Type
				) AS T
			)


------------END of Scripts-------------
