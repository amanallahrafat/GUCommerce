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
GO


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
GO


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
	ELSE IF(EXISTS (SELECT * FROM Admins WHERE username LIKE @username))
		SET @type = 2
	ELSE IF(EXISTS (SELECT * FROM Delivery_Person WHERE username LIKE @username))
		SET @type = 3
	ELSE
		SET @type = -1
	END;
ELSE
	SET @success = '0'
GO


/*EXEC customerRegister 'ahmed.ashraf', 'ahmed','ashraf','pass123','ahmed@yahoo.com'

EXEC vendorRegister 'eslam.mahmod','eslam' ,'mahmod','pass1234','hopa@gmail.com' ,'Market','132132513'
DECLARE @success BIT 
DECLARE @type INT
EXEC userlogin 'ahmed.ashraf' , 'pass',@success OUTPUT,@type OUTPUT
PRINT @success
PRINT @type*/

CREATE PROC addMobile
@username varchar(20),
@mobile_number varchar(20)
AS
INSERT INTO User_mobile_numbers
values (@mobile_number, @username)
GO

CREATE PROC showProducts
AS
SELECT * FROM Product
GO

CREATE PROC ShowProductsbyPrice
AS
SELECT * FROM Product
ORDER BY price
GO

CREATE PROC searchbyname
@text varchar(20)
AS
SELECT * FROM Product
WHERE product_name LIKE @text
GO

CREATE PROC addToCart 
@customername varchar(20),
@serial INT
AS
INSERT INTO CustomerAddstoCartProduct
values(@serial, @customername)
GO

CREATE PROC removefromCart 
@customername varchar(20),
@serial INT
AS
DELETE FROM CustomerAddstoCartProduct
WHERE serial_no = @serial AND customer_name LIKE @customername
GO
