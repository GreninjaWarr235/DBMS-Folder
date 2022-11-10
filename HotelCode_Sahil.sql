-- Creating the Database
CREATE DATABASE SAHIL_HOTEL;
USE SAHIL_HOTEL;

-- Creating the Table (Hotel)
CREATE TABLE Hotel (
 HotelName varchar(255) NOT NULL,
 ContactNumber int NOT NULL,
 LocationStreetName varchar(255) NOT NULL,
 LocationPincode int NOT NULL,
 LocationCity varchar(255) NOT NULL,
 HotelID int NOT NULL,
 Rating int,
 PRIMARY KEY (HotelID)
);

-- Inserting a Row into Table
INSERT INTO Hotel VALUES('Aparna', 999999999, 'Salisbury Road', 400987, 'Mumbai', 103, 4);
SELECT * FROM Hotel;

-- Alter Table
ALTER TABLE Hotel
ADD HotelEmail varchar(255);
SELECT * FROM Hotel;

-- Creating the Table (Room)
CREATE TABLE Room (
 RoomNumber int,
 RoomAvailability varchar(5) NOT NULL,
 RoomSize varchar(50) NOT NULL,
 RoomType varchar(50) NOT NULL,
 RoomPrice int NOT NULL,
 PRIMARY KEY (RoomNumber),
 HotelID int NOT NULL,
 FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

-- Inserting Rows into Table
INSERT INTO Room VALUES(237, 'NO', '2 persons', 'A.C', 2000, 103);
INSERT INTO Room VALUES(069, 'YES', '3 persons', 'Deluxe', 5000, 103);
INSERT INTO Room VALUES(235, 'YES', '1 person', 'A.C', 1000, 103);
INSERT INTO Room VALUES(123, 'YES', '4 persons', 'Non-A.C', 3000, 103);
INSERT INTO Room VALUES(420, 'YES', '3 persons', 'A.C', 4000, 103);
INSERT INTO Room VALUES(666, 'YES', '3 persons', 'A.C', 4000, 103);
SELECT * FROM Room;

-- Truncate
TRUNCATE TABLE Room;
SELECT * FROM Room;

-- Rename
RENAME TABLE Hotel TO HotelSahil;

-- Drop
DROP TABLE Room;
SELECT * FROM Room;

-- Order (Ascending)
SELECT * FROM Room
ORDER BY RoomType ASC;

-- Update
UPDATE Room
SET RoomAvailability = 'NO', RoomSize = '2 persons'
WHERE RoomNumber = 069;
UPDATE Room
SET RoomAvailability = 'NO', RoomSize = '4 persons'
WHERE RoomNumber = 420;
SELECT * FROM Room;

-- Delete Row
DELETE FROM Room WHERE RoomNumber = 666;
SELECT * FROM Room;

-- Wildcard
SELECT * FROM Room
WHERE RoomType LIKE '%A%';

-- Where
SELECT * FROM Room
WHERE RoomType = 'A.C' AND RoomSize = '2 persons';

-- Creating the Table (Customers)
CREATE TABLE Customers (
	CustomerName varchar(255) NOT NULL,
    DOB varchar(10) NOT NULL,
    Aadhar int NOT NULL,
    Address varchar(255) NOT NULL,
    Contact int NOT NULL,
    RoomNumber int,
    PRIMARY KEY (Aadhar),
    FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber) 
);

-- Inserting Rows into Table
INSERT INTO Customers VALUES('Sahil', '23/05/2003', 654898988, 'Mumbai', 999999999, null);
INSERT INTO Customers VALUES('Mufaddal', '16/09/2003', 646448884, 'Mumbai', 888888888, 237);
INSERT INTO Customers VALUES('Vignesh', '16/12/2003', 879128959, 'Solapur', 777777777, 069);
INSERT INTO Customers VALUES('Swapnil', '15/11/2003', 778945888, 'Mumbai', 898989898, null);
INSERT INTO Customers VALUES('Aryan', '14/04/2003', 587899489, 'Mumbai', 787878787, null);
INSERT INTO Customers VALUES('SRK', '12/10/1968', 659442484, 'Delhi', 979797979, 420);
SELECT * FROM Customers;

-- Drop
DROP TABLE Customers;
SELECT * FROM Customers;

-- Inner Join
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Room.RoomNumber
FROM Customers
INNER JOIN Room
ON Customers.RoomNumber = Room.RoomNumber;

-- Natural Join
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Room.RoomNumber
FROM Customers
NATURAL JOIN Room;

-- Left Join
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Customers.RoomNumber
FROM Customers
LEFT JOIN Room
ON Customers.RoomNumber = Room.RoomNumber;

-- Right Join
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Room.RoomNumber
FROM Customers
RIGHT JOIN Room
ON Customers.RoomNumber = Room.RoomNumber;

-- Full Join
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Room.RoomNumber
FROM Customers
LEFT JOIN Room
ON Customers.RoomNumber = Room.RoomNumber
UNION
SELECT Customers.CustomerName, Customers.Aadhar, Customers.Contact, Room.RoomType, Room.RoomSize, Room.RoomNumber
FROM Customers
RIGHT JOIN Room
ON Customers.RoomNumber = Room.RoomNumber;

SELECT * FROM Room;

-- Aggregate Functions
-- Count Function
SELECT COUNT(RoomPrice) AS RP3500
FROM Room
WHERE RoomPrice > 3500;

SELECT COUNT(RoomNumber) AS RN200
FROM Room
WHERE RoomNumber < 200;

-- Min Function
SELECT MIN(RoomNumber) AS MinRoomNumber
FROM Room
WHERE RoomType = 'A.C';

SELECT MIN(RoomNumber) AS MRNA
FROM Room
WHERE RoomAvailability = 'YES' AND RoomPrice >= 3500;

-- Max Function
SELECT MAX(RoomNumber) AS MaxRoomNumber
FROM Room
WHERE RoomSize = '2 persons';

SELECT MAX(RoomNumber) AS MRNRT
FROM Room
WHERE RoomType = 'A.C';

-- Average Function
SELECT AVG(RoomPrice) AS AvgRoomPrice
FROM Room
WHERE RoomAvailability = 'YES';

SELECT AVG(RoomPrice) AS ARPRT
FROM Room
WHERE RoomType = 'A.C';

SELECT AVG(RoomPrice) AS ARPRN
FROM Room
WHERE RoomNumber < 400;

-- Sum Function
SELECT SUM(RoomPrice) AS SumRoomPrice
FROM Room
WHERE RoomSize = '4 persons';

SELECT SUM(RoomPrice) AS SRPRA
FROM Room
WHERE RoomAvailability = 'NO';

SELECT SUM(RoomPrice) AS SRPRN
FROM Room
WHERE RoomNumber > 300;

-- Group By
SELECT RoomType, SUM(RoomPrice) AS SRP
FROM Room
GROUP BY RoomType
ORDER BY RoomType DESC;

-- Having 
SELECT RoomType, SUM(RoomPrice) AS HSRP
FROM Room
GROUP BY RoomType
HAVING HSRP >= 5000
ORDER BY RoomType DESC;

-- Hey I'm using Git

-- Subqueries
-- Sub 1 (Complex)
SELECT *
FROM Room 
WHERE RoomAvailability = (
	SELECT DISTINCT RoomAvailability 
	FROM Room 
    WHERE RoomPrice = (
		SELECT MIN(RoomPrice)
        FROM Room
        WHERE RoomNumber > 300
    )
);

-- Sub 2 (Complex)
SELECT *
FROM Room
WHERE RoomPrice = (
	SELECT MIN(RoomPrice) FROM Room
) OR RoomPrice = (
	SELECT MAX(RoomPrice) FROM Room 
);

-- Sub 3 (Complex)
SELECT * 
FROM Room 
WHERE RoomNumber = (
	SELECT RoomNumber 
    FROM Customers
    WHERE Contact = (
		SELECT MIN(Contact) 
        FROM Customers
		WHERE Address LIKE 'S%'
    )
);

-- Sub 4 (Complex)
SELECT RoomType, RoomPrice, RoomAvailability 
FROM Room
WHERE RoomNumber IN (
	SELECT RoomNumber 
    FROM Customers
    WHERE Address IN (
		SELECT Address 
        FROM Customers
        WHERE Address = 'Delhi'
    )
);

-- Sub 5 
SELECT * FROM Room
WHERE RoomPrice > (
	SELECT MIN(RoomPrice)
    FROM Room
); 

-- Sub 6 
SELECT * FROM Room
WHERE RoomNumber = (
	SELECT RoomNumber
    FROM Room
    WHERE RoomAvailability = 'NO' AND RoomNumber > 200
);

-- Sub 7
SELECT CustomerName, DOB, Aadhar  
FROM Customers
WHERE RoomNumber = (
	SELECT RoomNumber
    FROM Room
    WHERE RoomPrice > 4500
);

-- Sub 8
SELECT RoomNumber, RoomSize, RoomAvailability, RoomType 
FROM Room
WHERE RoomPrice >= (
	SELECT AVG(RoomPrice)
    FROM Room
);

-- Sub 9 
SELECT * FROM Room 
WHERE RoomNumber IN (
	SELECT RoomNumber
	FROM Room
	WHERE RoomSize = '2 persons' OR RoomSize = '3 persons'
)
ORDER BY RoomAvailability;

-- Sub 10 
SELECT RoomNumber, RoomType, RoomSize, RoomPrice 
FROM Room
WHERE RoomNumber IN (
	SELECT RoomNumber
	FROM Customers
	WHERE Contact > 777777777
);

-- Sub 11 
SELECT * FROM Room 
WHERE RoomSize IN (
	SELECT RoomSize 
	FROM Room
	HAVING RoomPrice >= AVG(RoomPrice) AND RoomPrice <= MAX(RoomPrice)
);

-- Sub 12
UPDATE Customers
SET Address = 'Delhi' 
WHERE RoomNumber = (
	SELECT RoomNumber 
	FROM Room 
	WHERE RoomType = 'Deluxe' AND RoomSize = '3 persons'
);
SELECT * FROM Customers;

-- Drop database 
DROP DATABASE SAHIL_HOTEL;

