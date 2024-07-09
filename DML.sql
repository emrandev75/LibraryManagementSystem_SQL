
	/*SQL Project Name : Library Management System
							    Trainee Name :Md.Emran Hossen  
						    	  Trainee ID : 1272071       
							Batch ID : CS/PNTL-M/53/01 
----------------------------------------------------------------------------------
Table of Contents: DML
			01: INSERT DATA USING INSERT INTO KEYWORD
		    02: INSERT DATA THROUGH STORED PROCEDURE
			03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
		    04: INSERT UPDATE DELETE DATA THROUGH VIEW
			05: USING FUNCTION
		    06: TRIGGER
			07: QUERY
			 7.01 : SELECT FROM TABLE
			 7.02 : SELECT FROM VIEW
			 7.03 : SELECT INTO
			 7.04 : WHERE BY CLAUSE, ORDER BY CLAUS
			 7.05 : INNER JOIN WITH GROUP BY CLAUSE
			 7.06 : OUTER JOIN
			 7.07 : CROSS JOIN
			 7.08 : TOP CLAUSE WITH TIES
			 7.09 : DISTINCT
			 7.10 :  LOGICAL(AND OR NOT) & BETWEEN 
			 7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
			 7.12 : OFFSET FETCH
			 7.13 : UNION
			 7.14 : EXCEPT INTERSECT
			 7.15 : AGGREGATE FUNCTIONS
			 7.16 : GROUP BY & HAVING CLAUSE
			 7.17 : ROLLUP & CUBE OPERATOR
			 7.18 : GROUPING SETS
			 7.19 : SUB-QUERIES 
			 7.20 : EXISTS
			 7.21 : CTE
			 7.22 : MERGE
			 7.23 : BUILT IN FUNCTION
			 7.24 : CASE
			 7.25 : IIF
			 7.26 : COALESCE & ISNULL
		     7.27 : GROPING FUNCTION
			 7.28 : RANKING FUNCTION
			 7.29 : TRY CATCH
			 7.30 : sp_helptext
		
		
		
*/

------------------------=>	01: INSERT DATA USING INSERT INTO KEYWORD
use libraryManagement
go
INSERT INTO Books VALUES(1,'Maa','‎Somoy Prokashon','Anisul Hoque')
GO
SELECT * FROM Books
GO
INSERT INTO Bookcategories VALUES(NEWID(),'Novel')
GO
SELECT * FROM Bookcategories
GO
INSERT INTO Publisher VALUES('‎Somoy Prokashon','‎Dhaka','01234567891')
GO
SELECT * FROM Publisher
GO
INSERT INTO librarybranch VALUES(1,'Dhaka Public Libary','Dhaka')
GO
SELECT * FROM librarybranch
GO
INSERT INTO Member values(1,'Rafat','Student','Dhaka',1201,'01234567893','rafat@gmail.com','9871236457')
go
SELECT * FROM Member
GO
INSERT INTO bookissue VALUES(1,1,101,'Dhaka Public Libary',GETDATE(),'4PM')
GO
SELECT * FROM bookissue
GO
INSERT INTO libraryfee VALUES(1,300.00,1)
GO
SELECT * FROM libraryfee 
GO
INSERT INTO bookCopies VALUES(1,1,1,12)
go
SELECT * FROM bookCopies
go
INSERT INTO Authors VALUES(1,1,'Anisul Hoque')
GO
SELECT * FROM Authors
GO
INSERT INTO librarian VALUES(1,'Kamal')
GO
SELECT * FROM librarian
GO
INSERT INTO employee VALUES (1,'Rakib','male','9876234134','rakib@gmail.com','01732698522','Dhaka')
GO
SELECT * FROM employee
GO
INSERT INTO employeeInfo VALUES (1,24000.00,.15)
GO
SELECT * FROM employeeInfo
GO
INSERT INTO libraryDetails VALUES (1,1,1,1,1,1,1,1,1)
GO
SELECT * FROM libraryDetails
GO
----------INSERT DATA USING SEQUENCE VALUE
INSERT INTO employeeInfo VALUES((NEXT VALUE FOR seqNumber), NULL)
GO
SELECT * FROM employeeInfo
GO 


------------------=> 02: INSERT DATA THROUGH STORED PROCEDURE

EXEC spInsertMember 2,'Nazmul','Student','Dhaka',1202,'01736985247','nazmul@gmail.com','9873214567'
GO 
SELECT * FROM Member
GO
 -------STORED PROCEDURE WITH AN OUTPUT PARAMETER ============--
DECLARE @id INT
EXEC spInsertBooks 2,'Agnibeena','Arya Publishing House','Kazi Nazrul Islam', @id OUTPUT
GO
SELECT * FROM Books
GO
 --------------SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE

EXEC spUpdatetMember 3,'Nahid'
GO 
SELECT * FROM Member
go
-- STORED PROCEDURE for Delete 
EXEC spDeletelibrarybranch 1
GO
SELECT * FROM librarybranch
GO
----------STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR
EXEC spRaisError
GO
------------ALTER STORED PROCEDUR
EXEC spUpdatetMember 3,'rahim'
GO
SELECT * FROM Member
GO
		---------------04: INSERT UPDATE DELETE DATA THROUGH VIEW
SELECT * FROM VW_bookissueinfo
GO
INSERT INTO VW_bookissueinfo(issueid,issue_by,issued_at,return_time) VALUES(2,102,'Dhaka Public Libary','5AM')
GO
SELECT * FROM VW_bookissueinfo
GO

-------------------=>05: USING FUNCTION

SELECT * FROM dbo.fnlibraryfee(1, 2500.00)
GO
----------=>06: TRIGGER
SELECT * FROM bookissue
SELECT * FROM bookCopies

INSERT INTO bookCopies(CopiesID, NoOfCopies) VALUES (4, 12)
GO

SELECT * FROM bookissue
SELECT * FROM bookCopies
GO
	------------------07: QUERY

-------7.01 : SELECT FROM TABLE
SELECT * FROM Books
GO
 ----------7.02 : SELECT FROM VIEW
 SELECT * FROM VW_bookissueinfo
GO
--------7.03 : SELECT INTO 
SELECT * INTO #tmpMember
FROM Member
GO
SELECT * FROM #tmpMember
GO
-----------7.04 : WHERE BY CLAUSE, ORDER BY CLAUS 

SELECT BookId,BookTitle,PublisherName,AthorName FROM Books
where BookId=2
go

SELECT BookId,BookTitle,PublisherName,AthorName FROM Books
order by BookTitle asc
go
---------- 7.05 : INNER JOIN WITH GROUP BY CLAUSE
SELECT em.name,sum(emf.salary) as 'totalSalary' FROM employee em
inner join employeeInfo emf on emf.employeeId=em.employeeId
group by em.name
go

 --------------=>7.06 : OUTER JOIN
-------left JOIN
SELECT * FROM Member me
left join bookissue bks on bks.MemberId=me.MemberId
go
-----right join
SELECT * FROM Member me
right join bookissue bks on bks.MemberId=me.MemberId
go
------full join
SELECT * FROM Member me
full join bookissue bks on bks.MemberId=me.MemberId
go
----------------7.07 : CROSS JOIN
SELECT * FROM Member 
cross join bookissue 
go
--------- 7.08 : TOP CLAUSE WITH TIES
SELECT TOP 5 WITH TIES *  FROM Member
INNER JOIN bookissue ON bookissue.MemberId = Member.MemberId
ORDER BY MemberName
GO
---------- 	 7.09 : DISTINCT
SELECT DISTINCT *  FROM Member
INNER JOIN bookissue ON bookissue.MemberId = Member.MemberId
ORDER BY MemberName
GO
 --------------7.10 :  LOGICAL(AND OR NOT) & BETWEEN 

SELECT * FROM Books
WHERE BookTitle='Ma' and AthorName='Anisul Hoque' 
GO
SELECT * FROM Books
WHERE BookTitle='Ma' or AthorName='Anisul Hoque' 
GO
SELECT * FROM Books
WHERE not BookId=1 
GO
SELECT * FROM employeeInfo 
WHERE salary BETWEEN 22000.00 AND 25000.00
GO

---------------7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
--------- LIKE OPERATOR
SELECT MemberId,MemberName FROM Member
WHERE MemberName like 'N%'
go
-------- IN OPERATOR
SELECT MemberId,MemberName FROM Member
WHERE MemberName IN('Nazmul') 
go
-------- NOT IN OPERATOR
SELECT MemberId,MemberName FROM Member
WHERE MemberName NOT IN('Nazmul') 
go
---------IS NULL OPERATOR
SELECT MemberId,MemberName,MemberAddress FROM Member
WHERE  MemberAddress IS NULL
go

 ------------------7.12 : OFFSET FETCH
-- OFFSET 3 ROWS
SELECT * FROM employee
ORDER BY employeeId
OFFSET 3 ROWS
GO

-- OFFSET 3 ROWS AND GET NEXT 2 ROWS

SELECT * FROM employee
ORDER BY employeeId
OFFSET 3 ROWS
FETCH NEXT 2 ROWS ONLY
GO
  ---------------- 7.13 : UNION

SELECT * FROM Member
WHERE MemberId IN ('1')

UNION

SELECT * FROM Member
WHERE MemberId IN ('2')
GO

------------------ 7.14 : EXCEPT INTERSECT
-- EXCEPT
SELECT * FROM employee

EXCEPT

SELECT * FROM employee
WHERE employeeId = 1
GO
-------INTERSECT

SELECT * FROM Member
WHERE MemberId > 10

INTERSECT

SELECT * FROM Member
WHERE MemberId > 15
GO
--------- 7.15 : AGGREGATE FUNCTIONS
SELECT	COUNT(*) 'Total Count',
		SUM(netSalary) 'Total Salary',
		AVG(netSalary) 'Average salary',
		MIN(netSalary) 'MIN salary',
	    MAX(salary) 'MAX'
FROM employeeInfo
GO
-------7.16 : GROUP BY & HAVING CLAUSE
SELECT em.name,sum(emf.salary) as 'totalSalary' FROM employee em
inner join employeeInfo emf on emf.employeeId=em.employeeId
group by em.name
having sum(emf.salary)>22000.00
go

---------7.17 : ROLLUP & CUBE OPERATOR
SELECT employeeId,SUM(salary) 'Total' FROM employeeInfo
GROUP BY ROLLUP (employeeId)
GO
SELECT employeeId,vat,SUM(salary) 'Total' FROM employeeInfo
GROUP BY CUBE (employeeId,vat)
GO
----------- 7.18 : GROUPING SETS
SELECT employeeId,vat,SUM(salary) 'Total' FROM employeeInfo
GROUP BY  GROUPING SETS (employeeId,vat)
GO
----------------- 7.19 : SUB-QUERIES 

SELECT MemberName, Membertype, MemberAddress, Email, phone, NID FROM Member
WHERE MemberId NOT IN (SELECT MemberId FROM libraryfee)
ORDER BY MemberName
GO

--------- 7.20 : EXISTS
SELECT MemberId, MemberName, MemberAddress FROM Member M
WHERE EXISTS 
(SELECT * FROM libraryfee L
WHERE L.MemberId=M.MemberId)
GO

--------------7.21 : CTE
with myCTE
as
(
	select em.employeeId,em.name,emf.salary from employee em
	inner join employeeInfo emf on emf.employeeId=em.employeeId
)
select * from myCTE
go

----------
SELECT * FROM employee
SELECT * FROM employeeInfo
GO

------------------	 7.22 : MERGE
MERGE employee AS TARGET
 USING employeeInfo AS SOURCE
ON SOURCE.employeeId = TARGET.employeeId
WHEN MATCHED THEN
				UPDATE SET
				employeeId = SOURCE.employeeId,
				[name] = SOURCE.salary;
GO

--------------	 7.23 : BUILT IN FUNCTION
SELECT GETDATE()--current date and time
GO
----------- GET STRING LENGTH
SELECT employeeId, LEN([name]) 'Name Length' FROM employee
GO
----------CAST 
SELECT CAST('01-june-2019 10:00AM' as date) AS Date
GO
---------CONVERT
DECLARE @currTime DATETIME = GETDATE()
SELECT CONVERT(VARCHAR, @currTime, 108) AS ConvertToTime
GO
-----------------TRY_CONVERT
SELECT TRY_CONVERT(FLOAT, 'HELLO', 1) AS ReturnNull
GO
---------- DIFFERENCE OF DATES
SELECT DATEDIFF(DAY, '2021-01-01', '2022-01-01') AS dayInYear
GO
--------- MONTH NAME
SELECT DATENAME(MONTH, GETDATE()) AS 'Month'
GO


--------- 7.24 : CASE
SELECT em.employeeId,em.name,emf.salary,
CASE
	when emf.salary>22000.00 then 'good'
	else 'poor'
END 'comment'
FROM employee em
	inner join employeeInfo emf on emf.employeeId=em.employeeId
go

------------ 7.25 : IIF
SELECT em.employeeId,em.name,emf.salary,
iif((emf.salary>22000.00),'Great Salary','Lower Salary') as 'Status'
FROM employee em
inner join employeeInfo emf on emf.employeeId=em.employeeId
go
--------- 7.26 : COALESCE & ISNULL
select employeeId,salary,
isnull(salary,1100.00) as 'isnull',
coalesce(salary,1100.00) as 'coalesce'
from employeeInfo
go 
------------  7.27 : GROPING FUNCTION
SELECT emf.salary,
CASE
	when grouping(emf.salary)=1 then 'good'
	else 'poor'
END 'comment'
FROM employee em
	inner join employeeInfo emf on emf.employeeId=em.employeeId
	group by emf.salary
go

-----------------	 7.28 : RANKING FUNCTION

SELECT 
RANK() OVER(ORDER BY BookId) AS 'Rank',
DENSE_RANK() OVER(ORDER BY BookTitle) AS 'Dense_Rank',
NTILE(3) OVER(ORDER BY PublisherName) AS 'NTILE',
BookId,
BookTitle, 
PublisherName
FROM Books
GO
----------- 7.29 : TRY CATCH

BEGIN TRY
	DELETE FROM Books
	PRINT 'SUCCESSFULLY DELETED'
END TRY

BEGIN CATCH
		DECLARE @Error VARCHAR(200) = 'Error' + CONVERT(varchar, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
		PRINT (@Error)
END CATCH
GO
----------- 7.30 : sp_helptext 

EXEC sp_helptext spInsertMember
GO