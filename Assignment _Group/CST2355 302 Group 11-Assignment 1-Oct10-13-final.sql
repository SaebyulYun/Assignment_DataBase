-- -----------------------------------------------------
-- CST2355 302 Group 11 - Assignment 1
-- -----------------------------------------------------
-- Group members Name: Kuang-I, Ho / 041096978 / ho000104@algonquinlive.com 
--                     Seabyul Yun / 041091398 / yun00014@algonquinlive.com 
--	                   Jason Zhang / 041096314 / zhan0820@algonquinlive.com   
-- Test Data file: insert commands to insert the data and test the data

CREATE DATABASE toolRental;
GO
USE toolRental;
GO
-- -----------------------------------------------------
-- Table Customer
-- -----------------------------------------------------
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
  CustomerID INT IDENTITY(1,1) PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%'),
  Phone VARCHAR(15) NOT NULL,
  Addressinfo VARCHAR(150) NOT NULL,  
  CustomerType VARCHAR(10) 
);
GO
INSERT INTO Customer (FirstName, LastName, Email, Phone, Addressinfo, CustomerType)
VALUES
    ('Elaine', 'Ho', 'ho000104@algonquinlive.com', '613-111-55555', '12 Woodroffe Ave, Ottawa, ON', null),
	('Seabyul', 'Yun', 'yun00014@algonquinlive.com', '416-002-8888', '350 Victoria St, Toronto, ON M5B 2K3', null),
	('Jason', 'Zhang', 'zhan0820@algonquinlive.com', '613-858-5456', '238 Mount Nebo Way, Gloucester, ON K1X 0C8', null), 
	('Hans', 'Kang', 'hans@gmail.com', '416-111-8888', '123 Nepean Raod, Nepean, Ottawa, K4Y 0W0', 'Employee'),
	('Benson', 'Cheng', 'Benson@outlook.com', '613-555-8888', '455 Carling Ave, Ottawa, M6Y 1T7', 'Corporate'),
	('Jimin', 'Pack', 'ho000104@algonquinlive.com', '613-111-55555', '12 Woodroffe Ave, Ottawa, ON K0J 3J1', null),
	('Candice','Molly', 'yun00014@algonquinlive.com', '416-002-8888', '350 Victoria St, Toronto, ON M5B 2K3', null),
	('Serah', 'Jackson', 'zhan0820@algonquinlive.com', '613-858-5456', '238 Mount Nebo Way, Gloucester, ON K1X 0C8', null),
	('Pilib', 'Holy', 'pilib@algonquinlive.com', '131-000-5155', '89 Billigon Ave, Toronto, ON M4N 9I8', null),
	('Julian', 'Lolling', 'julian00014@algonquinlive.com', '989-910-8188', '111 Rorence St, Toronto, ON A5L 2K0', null),
	('Keren', 'Biliski', 'keren0820@algonquinlive.com', '541-351-5400', '131 Kings street, Kinston, ON S1X 1C4', null),
	('Edison', 'Berry', 'edison@outlook.com', '123-121-1231', '82 Riverside Ave, Galax, VA, US, 24333', 'Corporate'),
	('Mellisa', 'Norh', 'mellisa@outlook.com', '093-131-2341', '1092 Zimmerman Lane, LA, US, 90013', 'Corporate'),
	('Bell', 'Richard', 'bell@outlook.com', '144-636-2342', '731 Princess St, Kingston, ON, Canada, X5Y 0P7', 'Emloyee'),
	('Naomi', 'Kembell', 'Naomi@outlook.com', '443-844-1212', '44992 rue Levy, Montreal, QB, Canada H3C 5K4', 'Corporate'),
	('Zack', 'Holand', 'zack@outlook.com', '778-009-1981', ' 2521 90th Avenue, Delia, Alberta, Canada T0J 0W0', 'Employee'),
	('kelly', 'Song', 'kelly@outlook.com', '342-123-7744', '1538 Toy Avenue, Oshawa, ON, L1H 7K5, Canada','Corporate'),
	('Pan', 'Ying', 'zack@outlook.com', '776-229-0181', '4693 Woodvale Drive, Dutton, ON, Canada, N0L 1J0', 'Employee'),
	('Bradly', 'Kim', 'bradly@outlook.com', '331-257-8796', '1027 Morris Valley Road, Hemlock Valley, BC, Canada, V0M 1A0', 'Employee'),
	('Elias', 'Treby', 'elias@outlook.com', '338-229-1381', '95 Charleton Ave, Hamilton, ON, Canada L8N 3X3', 'Corporate'),
	('Emma', 'Twang', 'emma@outlook.com', '723-982-0215', '3635 Deer Haven Drive, Greenwood, South Carolina, US, 29646', 'Corporate');
GO 
select * from Customer; 
GO
DROP TABLE IF EXISTS Corporate;
CREATE TABLE Corporate(
  CorporateID INT IDENTITY(1,1) PRIMARY KEY,
  Business VARCHAR(50) NOT NULL,
  Website VARCHAR(50) NOT NULL,
  Customer_CustomerID INT NOT NULL,
    CONSTRAINT fk_Corporate_Customer1 FOREIGN KEY 
	(Customer_CustomerID) REFERENCES Customer (CustomerID)
);
GO
INSERT INTO Corporate(Business, Website, Customer_CustomerID)
VALUES
	('Media', 'https://www.ledmediapro.com/', 5),
	('Mimosa', 'https://www.mimosa.com/', 12),
	('Time', 'https://www.time001.com/',13),
	('Salt', 'https://www.saltCamping.com/', 15),
	('TillyMilly', 'https://www.tillymilly.com/', 17),
	('Parm', 'https://www.parm123.com/',20),
	('Kiwi', 'https://www.kiwi24.com/', 21);
GO
select * from Corporate;
GO
DROP TABLE IF EXISTS Empolyee;
CREATE TABLE Empolyee(
  EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
  EmployeeNumber INT NOT NULL,
  JobTitle VARCHAR(50),
  Customer_CustomerID INT NOT NULL,
  CONSTRAINT fk_Employee_Customer1 FOREIGN KEY 
  (Customer_CustomerID) REFERENCES Customer (CustomerID)
);
GO
INSERT INTO Empolyee(EmployeeNumber, JobTitle, Customer_CustomerID)
VALUES
	('567890', 'Director', 4),
	('124179', 'Manager', 14),
	('253315', 'Supervisor', 16),
	('435428', 'Manager', 18),	
	('865943', 'Director', 19);
GO
select * from Empolyee
GO
-- -----------------------------------------------------
-- Table RentalOrder
-- -----------------------------------------------------
DROP TABLE IF EXISTS RentalOrder;
CREATE TABLE RentalOrder (
  OrderID INT IDENTITY(1,1) PRIMARY KEY,
  OrderDate DATE NULL,
  ReturnDate DATE NULL,  
  Customer_CustomerID INT NOT NULL,
  CONSTRAINT chk_ReturnDateAfterOrderDate CHECK (ReturnDate > OrderDate),   
  CONSTRAINT fk_RentalOrder_Customer1 FOREIGN KEY (Customer_CustomerID) REFERENCES Customer (CustomerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO
INSERT INTO RentalOrder(OrderDate, ReturnDate, Customer_CustomerID)
VALUES
    ('2023-05-12', '2023-05-15', 3),
	('2023-10-01', '2023-10-02', 2),
    ('2023-04-04', '2023-04-17', 6),
    ('2023-05-01', '2023-05-22', 1),
	('2023-05-11', '2023-06-01', 7),
	('2023-05-29', '2023-06-10', 8),
	('2023-06-15', '2023-06-20', 9),
	('2023-06-17', '2023-07-05', 10),
	('2023-06-27', '2023-07-10', 11),
	('2023-07-04', '2023-07-17', 12),
	('2023-07-11', '2023-07-22', 13),
	('2023-07-26', '2023-08-01', 14),
	('2023-07-29', '2023-08-10', 15),
	('2023-08-15', '2023-08-20', 16),
	('2023-09-07', '2023-10-05', 17),
	('2023-09-10', '2023-09-17', 18),
	('2023-10-01', '2023-10-15', 19),
	('2023-10-01', '2023-10-22', 20),
	('2023-10-05', '2023-11-10', 21);
GO	
select * from RentalOrder;
GO
-- -----------------------------------------------------
-- Table Category
-- -----------------------------------------------------
DROP TABLE IF EXISTS Category;
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    ParentCategoryID INT  -- Reference to the Tool's parent Category (self-referencing foreign key)
    CONSTRAINT fk_Category_Category1 FOREIGN KEY (ParentCategoryID) REFERENCES Category(CategoryID)
);
GO
-- Sample data for Category hierarchy
INSERT INTO Category (CategoryID, CategoryName, ParentCategoryID)
VALUES
    (1, 'Tools', NULL),             -- Tools (top-level)
    (2, 'Power Tools', 1),           
    (3, 'Hand Tools', 1),     
    (4, 'Plumbing Tools', 1),         
    (5, 'Vehicles', 1), 
	(6, 'Drills', 2),
	(7, 'Saw',2), 
	(8, 'Miter Saw',7),
    (9, 'Chainsaw', 7),
    (10, 'Table Saw', 7),
    (11, 'Circlar Saw',7),
    (12, 'Jigsaw', 7),
	(13, 'Tool Kits', 3),             
    (14, 'Jack Hammer', 2),           
    (15, 'Generator', 1),     
    (16, 'Tractor', 5),         
    (17, 'Lawn Tractor', 5), 
	(18, 'Hammer Drill', 6),
	(19, 'Core Drill',6), 
	(20, 'Electric Drill',6),
    (21, 'Pipe Wrench', 4),
    (22, 'Toilet Ager', 4),
    (23, 'Lightweight generator',15),
    (24, 'Heavy-duty generator', 15);
GO
-- Query to retrieve the entire hierarchy
select * from Category;
GO
-- -----------------------------------------------------
-- Table Tool
-- -----------------------------------------------------
DROP TABLE IF EXISTS tool;
CREATE TABLE tool (
  ToolID INT IDENTITY(1,1) PRIMARY KEY,
  ToolName VARCHAR(50) NOT NULL,
  Description VARCHAR(200) NULL,
  RentalPricePerDay DECIMAL(10, 2) NULL,
  QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),   
  Category_CategoryID INT NOT NULL, 
  CONSTRAINT fk_Tool_Category1 FOREIGN KEY (Category_CategoryID) REFERENCES Category (CategoryID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);
GO
INSERT INTO tool (ToolName, Description, RentalPricePerDay, QuantityInStock,Category_CategoryID)
VALUES 
   ('Table Saw Dewalt II6', 'Table saws are a great addition to any woodworker or contractor arsenal, excellent for cutting larger boards to size, and useful for many other cutting jobs', 10.99, 5, 10),
   ('AVID Drill 100', '20V MAX Electric Battery Power Drill', 4.50, 20, 6),
   ('Tool Kits', 'There are different size of hammer, screw drivers, and plier in a tool box', 12.00, 10, 13),
   ('Mastercreft Toilet Agur', 'Tool used to unclog toilets that a regular plunger cant', 150.00, 5,22),
   ('Hendhelld Core Drill', 'Used to drill a hole in concrete. Very Heavy duty', 90.00, 7, 19),
   ('Duostar Portable Generator', '4000W and gas powered porable', 75.00, 10, 15),
   ('Maxpower pipe Wrench', 'Heavy duty pipe wrench 24inch(600mm)', 37.00, 12, 21),
   ('Mega Lawn Tractor', 'Riding lawn mowers', 170.00, 5, 17); 

 -- the following data intend to create multi tools in same category, Jason added on Oct 13
INSERT INTO tool (ToolName, Description, RentalPricePerDay, QuantityInStock,Category_CategoryID)
VALUES
   ('Table Saw Dewalt 200', 'Great Table saws', 11.99, 3, 10),
   ('Table Saw Ryobi 333', 'Good Table saws', 9.99, 13, 10),
   ('Table Saw MasterCraft Steel', 'Steel Table saws', 21.99, 1, 10),
   ('Tool Kits Ryobi', 'Ryobi tool box', 8.00, 20, 13),
   ('Tool Kits MasterCraft', 'Excellent tool box', 12.00, 10, 13); 
GO  
select * from tool; 
GO
-- -----------------------------------------------------
-- Table OrderDetails
-- -----------------------------------------------------
DROP TABLE IF EXISTS OrderDetails;
CREATE TABLE OrderDetails (
  OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
  Tool_ToolID INT NOT NULL,
  RentalOrder_OrderID INT NOT NULL,
  RentalPrice DECIMAL(10, 2) NULL CHECK (RentalPrice > 0), 
   CONSTRAINT fk_OrderDetails_Tool1 FOREIGN KEY (Tool_ToolID) REFERENCES Tool (ToolID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OrderDetails_RentalOrder1 FOREIGN KEY (RentalOrder_OrderID) REFERENCES RentalOrder (OrderID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO
INSERT INTO OrderDetails (Tool_ToolID, RentalOrder_OrderID)
VALUES
   (2, 1),
   (1, 2),
   (3, 4),
   (4, 5), 
   (5, 6),
   (6, 7),
   (7, 10),
   (8, 9),  
   (1, 12),
   (2, 19),
   (3, 14),
   (4, 13),  
   (5, 11),
   (6, 8), 
   (7, 3),
   (8, 15),
   (1, 16),  
   (2, 18),
   (3, 17);

-- the following data intend to make one order includes mutil tools,  Jason added on Oct 13
INSERT INTO OrderDetails (Tool_ToolID, RentalOrder_OrderID)
VALUES
   (1, 4),
   (2, 4), 
   (8, 4),
   (12,8),
   (4, 8),
   (2, 12),
   (3, 12),
   (8, 12), 
   (10, 12); 

GO
select * from OrderDetails; 
GO

-- find out server name
select @@ServerName
GO

--Change Database Ownership 
USE toolRental;
-- This need to change to your user name: 
EXEC sp_changedbowner 'jasonUser', 'true';


