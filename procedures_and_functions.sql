CREATE PROC customerRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
INSERT INTO Users
values(@username ,@password, @first_name,@last_name,@email)
INSERT INTO Customer
values(@username ,0)
GO;


CREATE PROC vendorRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50),
@company_name varchar(20), 
@bank_acc_no varchar(20)
AS
INSERT INTO Users 
values (@username,@password, @first_name, @last_name, @email);
INSERT INTO Vendor (username,company_name,bank_acc_no)
values (@username, @company_name, @bank_acc_no);
GO;


CREATE PROC userlogin
@username varchar(20),
@password varchar(20),
@success bit OUTPUT,
@type INT OUTPUT
AS
IF EXISTS (SELECT * FROM Users WHERE username LIKE @username AND password LIKE @password)
	BEGIN
	SET @success = '1'
	IF(EXISTS (SELECT * FROM Customer WHERE username LIKE @username))
		SET @type = 0
	ELSE IF(EXISTS (SELECT * FROM Vendor WHERE username LIKE @username))
		SET @type = 1
	ELSE IF(EXISTS (SELECT * FROM Vendor WHERE username LIKE @username))
		SET @type = 2
	ELSE 
		SET @type = 3
	END;
ELSE
	SET @success = '0'
GO;
