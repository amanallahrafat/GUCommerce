-- (1)
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

-- (2)
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
values (@username,@company_name, @bank_acc_no);
GO

-- (3)
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

	END;
ELSE
	SET @success = '0'
	SET @type = -1

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

CREATE PROC addAddress
@username varchar(20),
@address varchar(100)
AS
INSERT INTO User_Addresses
values (@address , @username)
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

CREATE PROC AddQuestion
@serial INT,
@customer VARCHAR(20),
@question VARCHAR(50)
AS
INSERT INTO Customer_Question_Product(serial_no , customer_name , question)
VALUES (@serial , @customer , @question)
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

CREATE PROC createWishlist 
@customername varchar(20),
@name varchar(20)
AS
INSERT INTO Wishlist
values(@customername , @name)
GO

CREATE PROC AddtoWhishlist 
@customername varchar(20),
@wishlistname varchar(20),
@serial INT
AS
INSERT INTO Wishlist_Product
values (@customername , @wishlistname , @serial)
GO

CREATE PROC removefromWhishlist 
@customername varchar(20),
@wishlistname varchar(20),
@serial INT
AS
DELETE FROM Wishlist_Product
WHERE @customername Like username AND @wishlistname LIKE wish_name AND @serial = serial_no
GO

CREATE PROC showWishlistProduct
@customername varchar(20),
@name varchar(20)
AS
SELECT P.*
FROM Product P 
	INNER JOIN Wishlist_Product WP ON WP.serial_no = P.serial_no
WHERE WP.username LIKE @customername AND WP.wish_name LIKE @name
GO


CREATE PROC viewMyCart
@customer varchar(20)
AS
SELECT P.*
FROM Product P 
	INNER JOIN  CustomerAddstoCartProduct C ON P.serial_no = C.serial_no
	WHERE @customer like C.customer_name
GO

CREATE function viewMyCartF (@customer varchar(20))
RETURNS TABLE
AS
RETURN (SELECT P.*
FROM Product P 
	INNER JOIN  CustomerAddstoCartProduct C ON P.serial_no = C.serial_no
	WHERE @customer like C.customer_name)
GO

CREATE PROC calculatepriceOrder
@customername varchar(20),
@sum  DECIMAL(10,2) OUTPUT
AS 
SELECT sum(price)
FROM viewMyCartF(@customername)
GO

CREATE PROC productsinorder
@customername varchar(20),
@orderID int
AS
SELECT *
FROM viewMyCartF(@customername)

UPDATE Product 
SET customer_username = @customername , customer_order_id = @orderID  , available = '0'
WHERE serial_no IN (SELECT serial_no FROM viewMyCartF(@customername))

DELETE FROM CustomerAddstoCartProduct
WHERE (serial_no IN (SELECT serial_no FROM viewMyCartF(@customername))) AND NOT(customer_name LIKE @customername)
GO

CREATE PROC emptyCart
@customername varchar(20)
AS
DELETE FROM CustomerAddstoCartProduct
WHERE customer_name like @customername
GO

CREATE PROC makeOrder
@customername varchar(20)
AS
DECLARE @total_amount INT
DECLARE @time datetime
DECLARE @id INT 
SET @time = CURRENT_TIMESTAMP
EXEC calculatepriceOrder @customername , @total_amount output
INSERT INTO Orders(order_date , total_amount , customer_name,order_status)
VALUES (@time , @total_amount , @customername, 'not processed')

SELECT @id = order_no 
FROM Orders
WHERE @time = order_date AND @customername = customer_name

EXEC productsinorder @customername, @id
EXEC emptyCart @customername
GO

CREATE PROC cancelOrder
@orderid INT
AS
DECLARE @order_status varchar(20);
DECLARE @customer varchar(20);
SELECT @order_status = O.order_status, @customer = O.customer_name 
FROM Orders O
WHERE O.order_no = @orderid
IF @order_status LIKE 'not processed' OR @order_status LIKE 'in process'
	BEGIN
		DECLARE @date datetime
		SELECT @date = G.expiry_date
		FROM Giftcard G
		INNER JOIN Orders O ON G.code = O.Gift_Card_code_used
		IF @date <= CURRENT_TIMESTAMP
		BEGIN
			DECLARE @remaining_points INT
			SELECT @remaining_points = O.total_amount - (O.cash_amount+O.credit_amount)
			FROM Orders O
			WHERE O.order_no = @orderid
			UPDATE Admin_Customer_Giftcard 
			SET remaining_points = remaining_points+@remaining_points
			WHERE customer_name = @customer

			UPDATE Customer 
			SET points = points+@remaining_points
			WHERE username = @customer
		END;
		UPDATE Product
		SET available = '1', customer_username = NULL, customer_order_id= NULL
		WHERE customer_order_id = @orderid
		DELETE FROM Orders WHERE order_no = @orderid
	END;

GO

CREATE PROC returnProduct 
@serialno INT,
@orderid INT
AS
	DECLARE @price decimal(10,2)
	SELECT @price = final_price
	FROM Product WHERE serial_no = @serialno
	UPDATE Orders
	SET total_amount = total_amount - @price
	WHERE order_no = @orderid
	UPDATE Product
	SET available = '1', customer_username = NULL, customer_order_id= NULL
	WHERE customer_order_id = @orderid	
	DECLARE @date datetime
	SELECT @date = G.expiry_date
	FROM Giftcard G
	INNER JOIN Orders O ON G.code = O.Gift_Card_code_used
	IF @date <= CURRENT_TIMESTAMP
	BEGIN
		DECLARE @remaining_points INT
		SELECT @remaining_points = O.total_amount - (O.cash_amount+O.credit_amount)
		FROM Orders O
		WHERE O.order_no = @orderid
		UPDATE Admin_Customer_Giftcard 
		SET remaining_points = remaining_points+@remaining_points
		WHERE customer_name = @customer

		UPDATE Customer 
		SET points = points+@remaining_points
		WHERE username = @customer
	END;
GO

CREATE PROC ShowproductsIbought
@customername varchar(20)
AS
SELECT * FROM Product WHERE customer_username = @customername
GO

CREATE PROC rate
@serialno int, @rate int , @customername varchar(20)
AS
UPDATE Product 
SET  rate = @rate
WHERE serial_no = @serialno AND customer_username = @customername
GO

CREATE PROC SpecifyAmount
@customername varchar(20), @orderID int, @cash decimal(10,2), @credit decimal(10,2)
AS
DECLARE @points INT
SELECT @points = points FROM Customer WHERE username = @customername
IF @cash = NULL
	SET @cash = 0.0 ;
IF @credit = NULL
	SET @credit = 0.0 ;

UPDATE Orders 
SET credit_amount = @credit, cash_amount = @cash
WHERE order_no = @orderID

DECLARE @remaining_points INT
SELECT @remaining_points = O.total_amount - (O.cash_amount+O.credit_amount)
FROM Orders O
WHERE O.order_no = @orderid
UPDATE Admin_Customer_Giftcard 
SET remaining_points = remaining_points-@remaining_points
WHERE customer_name = @customer

UPDATE Customer 
SET points = points-@remaining_points
WHERE username = @customer

GO


CREATE PROC AddCreditCard
@creditcardnumber varchar(20), @expirydate date , @cvv varchar(4), @customername varchar(20)
AS
INSERT INTO Credit_Card
VALUES(@creditcardnumber, @expirydate,@cvv)
INSERT INTO Customer_CreditCard
VALUES(@customername,@creditcardnumber)
GO

CREATE PROC ChooseCreditCard
@creditcard varchar(20), @orderid int
AS
UPDATE Orders
SET creditCard_number = @creditcard
WHERE order_no = @orderid
GO

CREATE PROC vewDeliveryTypes
AS
SELECT DISTINCT(type), time_duration, fees FROM Delivery
GO

CREATE PROC specifydeliverytype
@orderID int, @deliveryID int
AS
DECLARE @o_date date, @d_time INT
SELECT @o_date = order_date FROM Orders WHERE order_no = @orderID 
SELECT @d_time = time_duration FROM Delivery WHERE id = @deliveryID 
SET @o_date = DATEADD(DAY, @d_time, @o_date)
DECLARE @days INT
SET @days = DATEDIFF(DAY,CURRENT_TIMESTAMP,@o_date)
UPDATE Orders
SET delivery_id = @deliveryID, remaining_days = @days,time_limit = @o_date
WHERE order_no = @orderID
GO

CREATE PROC trackRemainingDays
@orderid int, @customername varchar(20),
@days int OUTPUT
AS
DECLARE @t_limit DATE
SELECT @t_limit = time_limit FROM Orders WHERE order_no = @orderid
SET @days = DATEDIFF(DAY,CURRENT_TIMESTAMP,@t_limit)
UPDATE Orders
SET remaining_days = @days
WHERE order_no = @orderID
GO

CREATE PROC recommmend
@customername varchar(20)
AS

GO

-- Vendor
CREATE PROC postProduct
@vendorUsername varchar(20), @product_name varchar(20) ,@category varchar(20),
@product_description text , @price decimal(10,2), @color varchar(20)
AS
INSERT INTO Product(vendor_username, product_name,category,product_description,price,color)
VALUES(@vendorUsername, @product_name,@category,
@product_description, @price, @color)
GO

CREATE PROC vendorviewProducts
@vendorname varchar(20)
AS
SELECT *
FROM Product WHERE vendor_username = @vendorname
Go

CREATE PROC EditProduct
@vendorname varchar(20), @serialnumber int, @product_name varchar(20) ,@category varchar(20),
@product_description text , @price decimal(10,2), @color varchar(20)
AS
UPDATE Product
SET product_name = @product_name, category = @category, product_description= @product_description
	, price = @price, color = @color
WHERE serial_no = @serialnumber AND @vendorname = vendor_username
GO

CREATE PROC deleteProduct
@vendorname varchar(20),
@serialnumber INT
AS
DELETE FROM Product WHERE vendor_username = @vendorname AND serial_no = @serialnumber
GO

CREATE PROC viewQuestions
@vendorname varchar(20)
AS
SELECT Q.*
FROM Product P
	INNER JOIN Customer_Question_Product Q ON P.serial_no = Q.serial_no
	WHERE P.vendor_username = @vendorname
Go

CREATE PROC answerQuestions
@vendorname varchar(20), @serialno int,@customername varchar(20), @answer text
AS
UPDATE Customer_Question_Product
SET answer  = @answer
WHERE serial_no = @serialno AND customer_name =  @customername
GO

CREATE PROC addOffer
@offeramount int, @expiry_date datetime
AS
INSERT INTO offer 
VALUES(@offeramount, @expiry_date)
GO
-- here I think we should check if there is (ACTIVE OFFERS) not just offers
CREATE PROC checkOfferonProduct -- NEED TO BE DISSCUSSED
@serial int,
@activeoffer bit Output
AS
IF EXISTS (SELECT * FROM offersOnProduct O1 INNER JOIN offer O2 ON O1.offer_id = O2.offer_id WHERE serial_no = @serial AND O2.expiry_date >= CURRENT_TIMESTAMP)   
	SET @activeoffer = '1'
ELSE
	SET @activeoffer = '0'
GO

CREATE PROC checkandremoveExpiredoffer
@offerid int
AS
DEClARE @ex_date datetime
SELECT @ex_date = expiry_date FROM offer WHERE offer_id = @offerid
DECLARE @amount INT
SELECT @amount = offer_amount FROM offer WHERE offer_id = @offerid
DECLARE @serial INT
SELECT @serial = serial_no
FROM offersOnProduct
WHERE @offerid = offer_id 

IF @ex_date >= CURRENT_TIMESTAMP
BEGIN
	
	UPDATE Product
	SET final_price = price - @amount
	WHERE serial_no = @serial
END;
ELSE
BEGIN
	UPDATE Product
	SET final_price = final_price + @amount
	WHERE serial_no = @serial
	DELETE FROM offer WHERE offer_id = @offerid
END;
GO

CREATE PROC applyOffer -- NEED TO BE DISSCUSSED
@vendorname varchar(20), @offerid int, @serial int
AS
DECLARE @active BIT
EXEC checkOfferonProduct @serial , @active OUTPUT
EXEC removeExpiredoffers
IF @active = '0'
	BEGIN
		DECLARE @amount INT
		SELECT @amount = offer_amount FROM offer WHERE offer_id = @offerid
		
		UPDATE Product
		SET final_price = price - @amount
		WHERE serial_no = @serial

		EXEC checkandremoveExpiredoffer @offerid
	END;
ELSE
BEGIN
	PRINT 'The product has an active offer'
END;
GO

-- extra procedure to remove all the expired offers
CREATE PROC removeExpiredoffers
AS
	DELETE FROM offer WHERE expiry_date >= CURRENT_TIMESTAMP
GO

-- The Admin procedures

CREATE PROC activateVendors
@admin_username varchar(20),@vendor_username varchar(20)
AS
UPDATE Vendor
SET activated = '1' , admin_username = @admin_username
WHERE @vendor_username LIKE username
GO

CREATE PROC inviteDeliveryPerson
@delivery_username varchar(20), @delivery_email varchar(50)
AS
	INSERT INTO Users(username , email)
	VALUES(@delivery_username , @delivery_email)

	INSERT INTO Delivery_Person(is_activated , username)
	VALUES('0' , @delivery_username)
GO

CREATE PROC reviewOrders
AS
SELECT *
FROM Orders
GO

-- note that the values of the order status in the test cases is diffrent to the values in the test cases tables 
CREATE PROC updateOrderStatusInProcess
@order_no int
AS
UPDATE Orders
SET order_status = 'in process'
WHERE order_no = @order_no
GO

















