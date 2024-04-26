CREATE DATABASE  `PartyPlanningCompany`;
USE `PartyPlanningCompany`;

CREATE TABLE `Mangment`(
`M_ContactNumber`   INT(10)   NOT NULL  ,
`MNGR_ID`   INT(5)    NOT NULL   ,  
`M_Country`   VARCHAR(30) ,    
`M_City`   VARCHAR(30) ,
`M_District`   VARCHAR(30) ,
`M_Street`   VARCHAR(30) ,
`M_Email`   VARCHAR(30)    UNIQUE,
`M_Name`   VARCHAR(30) ,
CONSTRAINT `Mangment` primary key (`M_ContactNumber`)
);

 CREATE INDEX MNGR_ID_Index ON Mangment (`MNGR_ID`);
 
CREATE TABLE `Mannger_Information`(
`MNGR_ID`   INT(5)    NOT NULL  ,      
`MNGR_Name`   VARCHAR(30) ,
`MNGR_Salary`   INT(10) ,
`MNGR_Gender`   CHAR(1) ,
CHECK(`MNGR_Gender` IN ('F','M')),
CONSTRAINT `Manneger Information_PK` primary key (`MNGR_ID`),
CONSTRAINT `Manneger Information_FK` FOREIGN key (`MNGR_ID`)
REFERENCES `Mangment` (`MNGR_ID`)
ON DELETE CASCADE
ON UPDATE CASCADE
);


create table `Mannger_PhoneNumber`(
`M_ContactNumber`  Int (10) NOT NULL , 
`Mngr_PhoneNumber` Int(10)  NOT NULL UNIQUE,
CONSTRAINT `Mannger PhoneNumber_PK` primary key (`M_ContactNumber`,`Mngr_PhoneNumber`),
CONSTRAINT `Mannger PhoneNumber_FK` FOREIGN key (`M_ContactNumber`)
REFERENCES `Mangment` (`M_ContactNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE `Client`(
`M_ContactNumber`   INT(20)    NOT NULL  ,
`C_ID`   INT(5)    NOT NULL ,  
`FName`   VARCHAR(100) ,    
`LName`   VARCHAR(100) ,
`C_Country`   VARCHAR(30) ,
`C_City`   VARCHAR(30)   ,
`C_District`   VARCHAR(30) ,
`C_Street`   VARCHAR(30),

CONSTRAINT `Client_PK` primary key (`C_ID`),
CONSTRAINT `Client_FK` FOREIGN key (`M_ContactNumber`)
REFERENCES `Mangment` (`M_ContactNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE
);


create table `Client_PhoneNumber`(
`C_ID` Int(5)  NOT NULL ,
`C_PhoneNumber` Int(10)  NOT NULL UNIQUE,
CONSTRAINT `Client_Phone_PK` primary key (`C_ID`,`C_PhoneNumber`),
CONSTRAINT `Client_Phone_FK` FOREIGN key (`C_ID`)
REFERENCES `Client` (`C_ID`)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE `Guset` (
`C_ID`   INT(5)    NOT NULL  ,
`FName`   VARCHAR(20)  NOT NULL,  
`LName`   VARCHAR(20)  NOT NULL,  
`M_ContactNumber` INT(10)  NOT NULL  ,
`G_Country`   VARCHAR(30) ,    
`G_City`   VARCHAR(30) ,
`G_District`   VARCHAR(30) ,
`G_Street`   VARCHAR(30) ,
CONSTRAINT `Guset_PK` PRIMARY KEY (`C_ID` , `FName` , `LName`),
CONSTRAINT `Guset_FK1` FOREIGN KEY (`C_ID`) 
REFERENCES `Client` (`C_ID`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `Guset_FK2` FOREIGN key (`M_ContactNumber`)
REFERENCES `Mangment` (`M_ContactNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE `Guset_PhoneNumber`(
`C_ID` INT(5)    NOT NULL   ,      
`FName` VARCHAR(30)  NOT NULL ,
`LName` VARCHAR(30)    NOT NULL  ,  
`G_PhoneNumber`  INT(10)  NOT NULL  UNIQUE,
CONSTRAINT `Guset_Phone_FK` FOREIGN KEY (`C_ID` )
 REFERENCES `Guset` (`C_ID`)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE `Event_Hall`(
`EventHall_Number`   INT(5)    NOT NULL ,      
`B_Day`   INT(10) ,
`B_Month`   INT(10) ,
`B_Year`   INT(10),
`E_Country`   VARCHAR(30) ,
`E_City`   VARCHAR(30)   ,
`E_District`   VARCHAR(30) ,
`E_Street`   VARCHAR(30) ,
`NumberOfCheers` INT(20) ,
`M_ContactNumber`   INT(20)    NOT NULL , 

CONSTRAINT `Event Hall_PK` primary key (`EventHall_Number`),
CONSTRAINT `Event Hall_FK` FOREIGN key (`M_ContactNumber`)
REFERENCES `Mangment` (`M_ContactNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE `Party` (
    `PartyNumber` INT(10) NOT NULL ,
    `PartyType` CHAR(20) NOT NULL,
    `M_ContactNumber` INT(10) NOT NULL ,
    `P_Day` INT(2),
    `P_Month` INT(2),
    `P_Year` INT(4),
    CONSTRAINT `Party_PK` PRIMARY KEY (`PartyNumber` , `PartyType`),
    CONSTRAINT `Party_FK` FOREIGN KEY (`M_ContactNumber`)
REFERENCES `Mangment`(`M_ContactNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE
);
 
 CREATE INDEX Party_Type_Index ON Party (`PartyType`);
 
CREATE TABLE `Party_Details` ( 
`PartyNumber` INT(10) NOT NULL ,
`C_ID`  INT(10) NOT NULL ,
`EventHall_Number`  INT(10) NOT NULL ,
`Theme` VARCHAR(40) ,
`Flavor` VARCHAR(30) ,
`NoOfDrink`  INT(200), 
`NoOfCandel` INT(200),
`NoOfLevels` INT(200),
`NoOfDishes` INT(200),
`NoOfBalloon` INT(200),
`WithHelium` CHAR(3)
CHECK(`WithHelium` IN ('Yes','No')),

CONSTRAINT `PARTY_DETAILS_PK` PRIMARY KEY (`PartyNumber`,`C_ID`,`EventHall_Number`),

CONSTRAINT `PARTY_DETAILS_FK1` FOREIGN KEY (`PartyNumber`)
REFERENCES `Party`(`PartyNumber`)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT `PARTY_DETAILS_FK2` FOREIGN KEY (`C_ID`)
REFERENCES `Client`(`C_ID`)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT `PARTY_DETAILS_FK3` FOREIGN KEY (`EventHall_Number`)
REFERENCES `Event_Hall`(`EventHall_Number`)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE `Balloon` (
    `PartyNumber` INT(5) NOT NULL ,
    `PartyType` CHAR(20) NOT NULL,
    `Color` CHAR(10) NOT NULL,
    CONSTRAINT `Balloon_PK` PRIMARY KEY (`PartyNumber` , `PartyType` , `Color`),
    CONSTRAINT `Balloon_FK1` FOREIGN KEY (`PartyNumber`)
        REFERENCES `Party` (`PartyNumber`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `Balloon_FK2` FOREIGN KEY (`PartyType`)
        REFERENCES `Party` (`PartyType`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `PARTY_TDISH`(
`PartyNumber` INT(5) NOT NULL ,
`PartyType` CHAR(20) NOT NULL,
`TybeOfDish` CHAR(10) NOT NULL,
   CONSTRAINT `PARTY_TDISH_PK` PRIMARY KEY (`PartyNumber` , `PartyType` , `TybeOfDish`),
     CONSTRAINT `PARTY_TDISH_FK` FOREIGN KEY (`PartyNumber`)
        REFERENCES `Party` (`PartyNumber`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `PARTY_TDISH_FK2` FOREIGN KEY (`PartyType`)
        REFERENCES `Party` (`PartyType`)
        ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `PARTY_DRINK`(
`PartyNumber` INT(5) NOT NULL  ,
`PartyType` CHAR(20) NOT NULL,
`TybeOfDrink` CHAR(10) NOT NULL,
CONSTRAINT `PARTY_TDISH_PK` PRIMARY KEY (`PartyNumber` , `PartyType` , `TybeOfDrink`),
CONSTRAINT `PARTY_TDrink_FK` FOREIGN KEY (`PartyNumber`)
 REFERENCES `Party` (`PartyNumber`)
 ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `PARTY_TDrink_FK2` FOREIGN KEY (`PartyType`)
 REFERENCES `Party` (`PartyType`) 
 ON DELETE CASCADE ON UPDATE CASCADE);


Insert into `Mangment`
values(0534564221,54595,'Saudi arabia','Makkah','Aljaumum','Alsfa Street','PartyPCM@html.com','Party Planning Company1'),
(0504564222,54591,'Saudi arabia','Riyadh','Alsahafa','Alia Street','PartyPCR@html.com','Party Planning Company2'),
(0524564223,54532,'Saudi arabia','Jeddah','Alsfa','Street 56','PartyPCJ@html.com','Party Planning Company3'),
(0564564224,54512,'Saudi arabia','Taif','Alshafa','Street 25','PartyPCT@html.com','Party Planning Company4'),
(0574564225,54533,'Saudi arabia','Asir','Abha','The Art Street','PartyPCA@html.com','Party Planning Company5');

SELECT * FROM Mangment;

Insert into `Mannger_Information`
values(54595,'Sara Rakan',15000,'F'),
(54591,'Yousef Khalid',23000,'M'),
(54532,'Hattan Salim','13400','M'),
(54512,'Asma Waled','12000','F'),
(54533,'Manal Talal','15500','F');

SELECT * FROM Mannger_Information;

Insert into `Mannger_Phonenumber`
values(0534564221,0501254276),
(0504564222,0502312665),
(0524564223,0501232445),
(0564564224,0502332145),
(0574564225,0502312445);

SELECT * FROM Mannger_Phonenumber;

Insert into `Client`
values(0534564221,1,'Walaa','Alluqmani','Saudi arabia','Makkah','Aljaumum','Alsfa'),
      (0504564222,2,'Lena','Alymani','Saudi arabia','Riyadh','Alsahafa','Street 56'),
      (0524564223,3,'Reham','Almatrfi','Saudi arabia','Jeddah','Alsfa','Alzahab '),
      (0564564224,4,'Amira','Alharthi','Saudi arabia','Taif','Alshafa','Street 34'),
      (0574564225,5,'Khadija','Alajme','Saudi arabia','Asir','Abha','Street 23');

SELECT * FROM Client;

Insert into`Client_PhoneNumber`
values(1,057323496),
      (2,0563663809),
      (3,0502218263),
      (4,0568231855),
      (5,0552611569);
      
SELECT * FROM Client_PhoneNumber;
      
Insert into `Guset`
values(1,'Nora','Alluqmani',0534564221,'Saudi arabia','Makkah','Aljaumum','Alsfa'),
      (1,'Sara','Alluqmani',0534564221,'Saudi arabia','Makkah','Aljaumum','Street 87'),
	  (1,'Amira','Alharbi',0534564221,'Saudi arabia','Makkah','Aljaumum','Alsfa'),
      (2,'Dalia','Alharbi',0504564222,'Saudi arabia','Riyadh','Yarmouk','Street 33'),
      (2,'Sana','Almalki',0504564222,'Saudi arabia','Riyadh','Alsahafa','Street 32'),
      (3,'Rana','Almatrfi',0524564223,'Saudi arabia','Jeddah','Alsfa','street 12'),
      (3,'zbuida','Alhla',0524564223,'Saudi arabia','Jeddah','Alnasim','street 22'),
      (3,'Manar','Alsalm',0524564223,'Saudi arabia','Jeddah','Alnaaym','street 2'),
      (4,'Dania','Alharthi',0564564224,'Saudi arabia','Taif','Alshafa','street 4'),
      (4,'Smayah','Alharthi',0564564224,'Saudi arabia','Taif','Alshafa','street 5'),
      (5,'Sama','Alajme',0574564225,'Saudi arabia','Asir','Abha','The Art Street'),
      (5,'Samira','Alajme',0574564225,'Saudi arabia','Asir','Najran','street 45');
      
SELECT * FROM Guset;
  
	
Insert into `Guset_Phonenumber`
values(1,'Nora','Alluqmani',0522334455),
      (1,'Sara','Alluqmani',0534123456),
	  (1,'Amira','Alluqmani',0599886543),
      (2,'Dalia','Alharbi',0525437654),
      (2,'Sana','Almalki',0532185730),
      (3,'Rana','Almatrfi',0522548172),
      (3,'Zbuida','Alhla',0500532776),
      (3,'Manar','Alsalm',0555441187),
      (4,'Dania','Alharthi',0505053456),
      (4,'Smayah','Alharthi',0563854217),
      (5,'Sama','Alajme',0578675479),
      (5,'Samira','Alajme',0537281266);
 
 SELECT * FROM Guset_Phonenumber;
 
Insert into `Event_Hall`
values(35321,16,5,2024,'Saudi arabia','Makkah','Aljaumum','Alsfa',59,0534564221),
      (65431,27,7,2023,'Saudi arabia','Riyadh','Alsahafa','Street 56',90,0504564222),
	  (75432,12,3,2024,'Saudi arabia','Jeddah','Aziziyah','Alsfa',85,0524564223),
      (12987,18,8,2023,'Saudi arabia','Jeddah','Alsfa','Street 22',46,0524564223),
      (88765,25,10,2023,'Saudi arabia','Taif','Alshafa','Street 34',45,0564564224),
      (42887,18,7,2023,'Saudi arabia','Asir','Abha','The Art Street',87,0574564225);
	
SELECT * FROM Event_Hall;
     
Insert into `Party`
values(3005,'Birthday ',0534564221,16,5,2024),
      (2987,'Wedding ',0504564222,27,7,2023),
	  (1007,'GenderRevell ',0524564223,12,3,2024),
      (1324,'Birthday ',0524564223,18,8,2023),
      (2134,'Graduation ',0564564224,25,10,2023),
	  (1554,'Graduation ',0574564225,18,7,2023);
      
  SELECT * FROM Party;
     
Insert into `Party_Details`
values(3005,1,35321,'Birthday Theme','Vanilla',59,4,4,59,45,'Yes'),
      (2987,2,65431,'Wedding Theme','Chocolate with Vanilla Filling ',90,0,6,90,0,'No'),
	  (1007,3,75432 ,'GenderRevell Theme','Red Velvet',85,0,4,85,40,'Yes'),
      (1324,3,12987,'Birthday Theme','Vanilla',46,0,3,46,34,'Yes'),
      (2134,4,88765,'Graduation Theme','Vanilla with Raspberry Filling',45,4,4,45,30,'Yes'),
      (1554,5,42887,'Graduation Theme','Lemon with RaspBerry',87,6,5,87,45,'Yes');
      
      SELECT * FROM Party_Details;
      
Insert into `Balloon`
values(3005,'Birthday ','Pink'),
      (3005,'Birthday ','White'),
      (2987,'Wedding ', ' '),
	  (1007,'GenderRevell ','Pink'),
	  (1007,'GenderRevell ','Blue'),
	  (2134,'Graduation ','Black'),
      (2134,'Graduation ','Gold'),
      (1554,'Graduation','Gold'),
      (1554,'Graduation','White');
      
SELECT * FROM Balloon; 
     
Insert into `PARTY_TDISH`
values(3005,'Birthday ','Salad'),
      (3005,'Birthday ','Rice'),
	  (3005,'Birthday ','Meet'),
      (2987,'Wedding ','Pizza'),
	  (2987,'Wedding ','Steak'),
	  (2987,'Wedding ','Pasta'),
	  (2987,'Wedding ','Salad'),
	  (1007,'GenderRevell ','Rice'),
	  (1007,'GenderRevell ','Beaf'),
	  (2134,'Graduation ','Pizza'),
	  (2134,'Graduation ','Burgar'),
	  (2134,'Graduation ','Appetaziar'),
      (1554,'Graduation ','Rice'),
	  (1554,'Graduation ','Steak');
     
SELECT * FROM PARTY_TDISH;
     
insert into PARTY_DRINK
values(3005,'Birthday ','Tea'),
           (3005,'Birthday ','Coffee'),
        	(3005,'Birthday ','Water'),
            (2987,'Wedding ','Tea'),
	        (2987,'Wedding ','Coffee'),
	        (2987,'Wedding ','Mojito'),
	        (2987,'Wedding ','Soda'),
            (1007,'GenderRevell ','Coffee'),
			(1007,'GenderRevell ','Tea'),
			(2134,'Graduation ','Soda'),
			(2134,'Graduation ','Tea'),
			(2134,'Graduation ','Mojito'),
			(1554,'Graduation ','Coffee'),
	        (1554,'Graduation ','Water');
      
      SELECT * FROM PARTY_DRINK;



#1 GROUP BY & ORDER BY 
-- This query retrieves the count of parties for each theme where helium was not used
-- and presents the results in descending order by theme.
Select  Theme ,count(Theme) as count
From Party_Details
Where WithHelium="NO"
Group by Theme
Order BY Theme DESC;

#2 ORDER BY
-- This query retrieves all columns from the Manneger_Information table
-- and sorts the result set in ascending order based on MNGR_Salary column.
SELECT *
FROM  Mannger_Information
ORDER BY MNGR_Salary;

#3 GROUP BY
-- This query groups event halls by E_City,
-- and counts the number of event halls in each group.
SELECT  E_City, Count(E_City) as count 
FROM Event_Hall
Group By  E_City;

#4 ORDER BY
-- This query retrieves all columns from the Event_Hall table
-- and sorts the result set in ascending order based on the values in the B_Year column.
SELECT *
FROM Event_Hall
Order By B_Year;

#5 WHERE 
-- This query retrieves all columns from the guset table
-- where the G_City column contains the value "Riyadh".
SELECT *
FROM guset
WHERE G_City="Asir";

#6 HAVING 
-- This query groups balloons by PartyType, and counts the number of balloons in each group.
-- It returns only those groups that have exactly one such balloon, or more than one such balloon.
SELECT PartyType, count(Color) As BalloonColor
FROM Balloon
Group By  PartyType
Having count(Color)= 1 or count(Color)>1 ;

#7 WHERE
-- This query retrieves all columns from the mangment table
-- where the M_City column contains the value "Makkah".
SELECT *
FROM mangment
Where M_City="Makkah";

#8 JOIN
-- Selects all columns from the Party table and the Details of Party table.
SELECT *
From Party P , Party_Details D
Where P.PartyNumber = D. PartyNumber;

#9 SUBQUERIES
-- This query uses a subquery to retrieve the manager ID and name associated with each party from the Mannger_Information table.
-- The WHERE clause is used to filter the results based on the M_ContactNumber that links the Party and Mannger_Information tables
SELECT
  (SELECT MNGR_ID FROM Mannger_Information WHERE MNGR_ID = M.MNGR_ID) AS MNGR_ID,
  (SELECT MNGR_Name FROM Mannger_Information WHERE MNGR_ID = M.MNGR_ID) AS MNGR_Name,
  p.PartyNumber,
  p.PartyType
FROM Party p ,Mangment M
Where p.M_contactNumber=M.M_contactNumber
LIMIT 10;

 #10 SUBQUERIES
 -- Selects the event hall numbers and cities located in Jeddah.
 SELECT EventHall_Number,E_City
 FROM Event_Hall
WHERE  M_ContactNumber in ( SELECT M_ContactNumber
                            FROM Mangment
                            Where M_City='Jeddah');

      
