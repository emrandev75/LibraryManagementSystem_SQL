
/*
					SQL Project Name : Library Management System
							    Trainee Name : Md.Emran Hossen  
						    	  Trainee ID : 1272071       
							Batch ID : CS/PNTL-M/53/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database 
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION & ALTER FUNCTION
			=> SECTION 09: CREATE TRIGGER & ALTER TRIGGER	
*/


						--------SECTION 01:  Created a Database 

create database libraryManagement
on
(
	name = 'libraryManagement_data_1',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\libraryManagement_data_1.mdf',
	size = 5MB,
	maxsize = 50MB,
	filegrowth = 5%
)
log on
(
	name = 'libraryManagement_log_1',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\libraryManagement_log_1.ldf',
	size = 5MB,
	maxsize = 50MB,
	filegrowth = 5%
)
go

use libraryManagement
go

		-----------SECTION 02: Created Appropriate Tables with column definition related to the project


CREATE TABLE Books 
(
BookId INT PRIMARY KEY NOT NULL,
BookTitle VARCHAR(100) NOT NULL,
PublisherName VARCHAR(100) NOT NULL,
AthorName varchar(80) not null
)
go
CREATE TABLE Bookcategories 
(
  Categoryid UNIQUEIDENTIFIER NOT NULL,
  Category varchar(255) NOT NULL
) 
go

CREATE TABLE Publisher 
(
Publisherid int IDENTITY primary key,
PublisherName VARCHAR(50) NOT NULL,
PublisherAddress VARCHAR(100) NOT NULL,
PublisherPhone VARCHAR(20) NOT NULL,
)
go

CREATE TABLE librarybranch
(
	BranchId INT PRIMARY KEY NOT NULL, 
	BranchName VARCHAR(100) NOT null,
	BranchAddress VARCHAR(200) NOT NULL
)
go
CREATE TABLE Member 
(
MemberId INT PRIMARY KEY NOT NULL,
MemberName VARCHAR(100) NOT NULL,
Membertype varchar(50) not null,
MemberAddress VARCHAR(200) NOT NULL,
postalCode NCHAR(12) DEFAULT 'N/A',
Phone CHAR(20) UNIQUE CHECK(Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Email VARCHAR(40) UNIQUE CONSTRAINT ck_emailCheck CHECK (Email LIKE '%@%' ),
NID CHAR(10) UNIQUE CHECK(NID LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
go
CREATE TABLE bookissue 
(
  issueid int primary key NOT NULL,
  MemberId int references Member(MemberId) NOT NULL,
  issue_by int NOT NULL,
  issued_at varchar(50) NOT NULL,
  issue_date DATETIME DEFAULT GETDATE(),
  return_time varchar(50) NOT NULL
)
go
CREATE TABLE libraryfee
(
	feeid int primary key,
	feeAmount money not null ,
	MemberId int references Member(MemberId) NOT NULL
)
go
CREATE TABLE bookCopies 
(
	 CopiesID INT PRIMARY KEY NOT NULL ,
	 BookId INT references Books(BookId) NOT NULL, 
	 BranchId INT references librarybranch(BranchId) NOT NULL,  
	 NoOfCopies INT NOT NULL
)
go
CREATE TABLE Authors  
(
 AuthorID INT PRIMARY KEY NOT NULL, 
 BookID INT REFERENCES Books(BookID), 
 AuthorName VARCHAR(50) NOT NULL
)
go
CREATE TABLE  librarian
(
	libariaIid int primary key,
	librarianName varchar(20) NOT NULL
) 
go
CREATE TABLE employee
(
	employeeId INT PRIMARY KEY,
	[name] VARCHAR(50) NOT NULL,
	gender varchar(40) not null,
	nid CHAR(10) UNIQUE CHECK(nid LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email VARCHAR(40) UNIQUE CONSTRAINT ck_email CHECK (email LIKE '%@%' ),
	phone CHAR(20) UNIQUE CHECK(phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[address] VARCHAR(70) NOT NULL
	)
	GO
CREATE TABLE employeeInfo
(
	employeeId INT REFERENCES employee(employeeId),
	salary MONEY DEFAULT 0.00,
	vat FLOAT DEFAULT .15,
	netSalary AS (salary * (1 - vat))
)
GO

-------Table with composite PRIMARY KEY
CREATE TABLE libraryDetails
(
	BookId INT REFERENCES Books(BookId),
	Publisherid INT REFERENCES Publisher(Publisherid),
	BranchId INT REFERENCES librarybranch(BranchId),
	MemberId INT REFERENCES Member(MemberId),
	issueid INT REFERENCES bookissue(issueid),
	AuthorID INT REFERENCES Authors(AuthorID),
	libariaIid INT REFERENCES librarian(libariaIid),
	feeid INT REFERENCES libraryfee(feeid),
	employeeId INT REFERENCES employee(employeeId),
	PRIMARY KEY(BookId,Publisherid,BranchId,MemberId,issueid,AuthorID,libariaIid,feeid,employeeId)
)
GO
---ceate SCHEMA and use SCHEMA
CREATE SCHEMA lib
GO
CREATE TABLE lib.librarian
(
	libariaIid int IDENTITY primary key,
	librarianName varchar(20) NOT NULL,
	age int not null
)
GO
							------- SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS



-----ALTER TABLE SCHEMA AND TRANSFER TO [DBO]
ALTER SCHEMA dbo TRANSFER lib.librarian
GO
---Update column definition
ALTER TABLE Bookcategories
ALTER COLUMN Category varchar(200) NOT NULL
GO
---ADD column within a table
ALTER TABLE Publisher
ADD email varchar(50) 
GO
---- DROP COLUMN
ALTER TABLE librarian
DROP COLUMN librarianName
GO
-----DROP TABLE
DROP TABLE librarian
GO
--------DROP SCHEMA
DROP SCHEMA lib
GO

				 ----SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX


----Clustered Index
CREATE INDEX  IX_booklist
ON bookCopies
(
	NoOfCopies
)
GO

-----Nonclustered Index
CREATE NONCLUSTERED INDEX IX_Authorname
ON Authors
(
	AuthorName
)
GO
						------SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE  



CREATE SEQUENCE seqNumber
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 200
	CYCLE
	CACHE 10
GO

------ALTER SEQUENCE

ALTER SEQUENCE seqNumber
	MAXVALUE 200
	CYCLE
	CACHE 9
GO

				---------SECTION 06: CREATE A VIEW & ALTER VIEW


----------CREATE A VIEW 
CREATE VIEW VW_bookissueinfo
AS
SELECT issueid,issue_by,issued_at,issue_date  FROM bookissue
GO		
---- VIEW WITH ENCRYPTION, SCHEMABINDING & WITH CHECK OPTION
CREATE VIEW VW_Todaybookissue
WITH SCHEMABINDING , ENCRYPTION
AS
SELECT issueid, issue_by, issued_at,return_time FROM dbo.bookissue
WHERE CONVERT(DATE, issue_date) = CONVERT(DATE, GETDATE())
WITH CHECK OPTION
GO
-------ALTER VIEW 
ALTER VIEW VW_bookissueinfo
AS
SELECT issueid, issue_by, issued_at, return_time FROM bookissue
GO


				---------- SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE



---------STORED PROCEDURE for insert data using parameter
CREATE PROCEDURE spInsertMember @MemberId int,
								@MemberName varchar(100),
								@Membertype varchar(50),
								@MemberAddress varchar(200),
								@postalCode NCHAR(12),
								@Phone char(20),
								@Email varchar(40),
								@NID CHAR(10)
AS
BEGIN
    INSERT INTO Member(MemberId,MemberName,Membertype,MemberAddress,postalCode,Phone,Email,NID)
	VALUES(@MemberId,@MemberName,@Membertype,@MemberAddress,@postalCode,@Phone,@Email,@NID)
END
GO
---STORED PROCEDURE for insert data with OUTPUT parameter
CREATE PROCEDURE spInsertBooks  @BookId int,
								@BookTitle varchar(100),
								@PublisherName varchar(100),
								@AthorName varchar(80),
								@id int output
AS
BEGIN
	INSERT INTO Books(BookId,BookTitle,PublisherName,AthorName) 
	VALUES(@BookId,@BookTitle,@PublisherName,@AthorName)
		SELECT @Id = IDENT_CURRENT('Books')
END
GO
--------STORED PROCEDURE for UPDATE data 
CREATE PROCEDURE spUpdatetMembers	@MemberId INT,
									@MemberName varchar(100)
AS
BEGIN
	UPDATE Member
	SET
	MemberName = @MemberName
	WHERE MemberId = @MemberId
END
GO
----------- STORED PROCEDURE for DELETE Table data

CREATE PROCEDURE spDeletelibrarybranch	@BranchId INT
AS
BEGIN
	DELETE FROM librarybranch
	WHERE BranchId = @BranchId
END
GO
----- TRY CATCH IN A STORED PROCEDURE & RAISERROR WITH ERROR NUMBER AND ERROR MESSAGE
CREATE PROCEDURE spRaisError
AS
BEGIN
	BEGIN TRY
		DELETE FROM Member
	END TRY
	BEGIN CATCH
		DECLARE @Error VARCHAR(200) = 'Error' + CONVERT(varchar, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
		RAISERROR(@Error, 1, 1)
	END CATCH
END
GO
----- ALTER STORED PROCEDURE
ALTER PROCEDURE spUpdatetMember	@MemberId INT,
									@MemberName varchar(50)
AS
BEGIN
	UPDATE Member
	SET
	MemberName = @MemberName
	WHERE MemberId = @MemberId
END
GO

							----------SECTION 08: CREATE FUNCTION & ALTER FUNCTION



----------- FUNCTION
CREATE FUNCTION fnlibraryfee(@feeid INT, @feeAmount money)
RETURNS TABLE
AS
RETURN
(
	SELECT 
			SUM(feeAmount) AS 'Total fee'
			FROM libraryfee
	WHERE (libraryfee.feeid) = @feeid AND (libraryfee.feeAmount) = @feeAmount
)
GO
---------ALTER FUNCTION
ALTER FUNCTION fnlibraryfee(@feeid INT, @feeAmount money)
RETURNS TABLE
AS
RETURN
(
	SELECT 
			feeid as 'id',
			SUM(feeAmount) AS 'Total fee'
		   FROM libraryfee
	WHERE (libraryfee.feeid) = @feeid AND (libraryfee.feeAmount) = @feeAmount
	group by feeid
)
GO

									 --------SECTION 09: CREATE TRIGGER 


CREATE TRIGGER trbookissue
ON bookCopies
FOR INSERT
AS
BEGIN
	DECLARE @i INT 
	DECLARE @q INT 

	SELECT @i=CopiesID,@q=NoOfCopies FROM inserted

	UPDATE bookissue SET issue_date=issue_date+@q
	WHERE issueid=@i

END
GO
------ ALTER TRIGGER  
ALTER TRIGGER trbookissue
ON bookCopies
FOR INSERT
AS
BEGIN
	DECLARE @i INT 
	DECLARE @q INT 

	SELECT @i=CopiesID,@q=NoOfCopies FROM inserted

	UPDATE bookissue SET issue_date=issue_date-@q
	WHERE issueid=@i

END
GO


