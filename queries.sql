--Create DataBase GUCommerce
CREATE TABLE Users
(
username varchar(20) PRIMARY KEY,
password varchar(20) NOT NULL,
first_name varchar(20),
last_name varchar(20),
email varchar(50)
)
GO

CREATE TRIGGER del_user
ON Users INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM User_mobile_numbers WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM User_Addresses WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Customer WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Admins WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Vendor WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Delivery_Person WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Users WHERE username IN ( SELECT username FROM deleted)
END
GO

CREATE TRIGGER del_admin 
ON Admins INSTEAD OF DELETE
AS
BEGIN 
	DELETE FROM Delivery WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Todays_Deals WHERE admin_username IN ( SELECT admin_username FROM deleted)
	DELETE FROM Giftcard WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Admin_Customer_Giftcard WHERE admin_username IN ( SELECT admin_username FROM deleted)
	DELETE FROM Admin_Delivery_Order WHERE admin_username IN ( SELECT admin_username FROM deleted)
	DELETE FROM Vendor WHERE admin_username IN ( SELECT admin_username FROM deleted)
	DELETE FROM Admins WHERE username IN ( SELECT username FROM deleted)
END
GO

CREATE TRIGGER del_customer
ON Customer INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Product WHERE customer_username IN ( SELECT customer_username FROM deleted)
	DELETE FROM Orders WHERE customer_name IN ( SELECT customer_name FROM deleted)
	DELETE FROM CustomerAddstoCartProduct WHERE customer_name IN ( SELECT customer_name FROM deleted)
	DELETE FROM Customer_Question_Product WHERE customer_name IN ( SELECT customer_name FROM deleted)
	DELETE FROM Customer_CreditCard WHERE customer_name IN ( SELECT customer_name FROM deleted)
	DELETE FROM Admin_Customer_Giftcard WHERE customer_name IN ( SELECT customer_name FROM deleted)
	DELETE FROM Wishlist WHERE username IN ( SELECT username FROM deleted)
	DELETE FROM Customer WHERE username IN ( SELECT username FROM deleted)
END
GO

CREATE TRIGGER del_product
ON Product AFTER DELETE
AS
BEGIN
	DELETE FROM CustomerAddstoCartProduct WHERE serial_no IN ( SELECT serial_no FROM deleted)
	DELETE FROM Todays_Deals_Product WHERE serial_no IN ( SELECT serial_no FROM deleted)
	DELETE FROM offersOnProduct WHERE serial_no IN ( SELECT serial_no FROM deleted)
	DELETE FROM Customer_Question_Product WHERE serial_no IN ( SELECT serial_no FROM deleted)
	DELETE FROM Wishlist_Product WHERE serial_no IN ( SELECT serial_no FROM deleted)
	DELETE FROM Product WHERE serial_no IN ( SELECT serial_no FROM deleted)
END
GO

CREATE TRIGGER del_order
ON Orders INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Product WHERE customer_order_id IN ( SELECT customer_order_id FROM deleted)
	DELETE FROM Admin_Delivery_Order WHERE order_no IN ( SELECT order_no FROM deleted)
	DELETE FROM Orders WHERE order_no IN ( SELECT order_no FROM deleted)
END
GO

CREATE TABLE User_mobile_numbers
(
mobile_number varchar(20),
username varchar(20),
PRIMARY KEY(mobile_number, username),
CONSTRAINT FK_usm FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE
)

CREATE TABLE User_Addresses
(
address varchar(100),
username varchar(20) ,
PRIMARY KEY(address, username),
CONSTRAINT FK_ua FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE
)

CREATE TABLE Customer
(
username varchar(20) PRIMARY KEY,
CONSTRAINT FK_c FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE,
points decimal(10,2)
)

CREATE TABLE Admins
(
username varchar(20) PRIMARY KEY,
CONSTRAINT FK_a FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE,
)

CREATE TABLE Vendor
(
username varchar(20) PRIMARY KEY,
CONSTRAINT FK_vname FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE,
activated BIT,
company_name varchar(20),
bank_acc_no varchar(20),
admin_username varchar(20),
CONSTRAINT FK_vadmin FOREIGN KEY(admin_username) REFERENCES Admins ON UPDATE NO ACTION
)

CREATE TABLE Delivery_Person
(
username varchar(20) PRIMARY KEY,
is_activated BIT,
CONSTRAINT FK_dp FOREIGN KEY(username) REFERENCES Users ON UPDATE CASCADE
)

CREATE TABLE Credit_Card
(number varchar(20) PRIMARY KEY,
expiry_date datetime,
cvv_code varchar(20))


----------
CREATE TABLE Delivery(
id INT PRIMARY KEY IDENTITY (1,1),
type varchar(20),
time_duration INT,
fees decimal(5,3),
username varchar(20),
CONSTRAINT FK_cc FOREIGN KEY(username) REFERENCES Admins ON UPDATE CASCADE
)

--Datatypes have to be discussed in Orders Table

CREATE TABLE Orders
(order_no INT PRIMARY KEY IDENTITY(1,1),
order_date datetime,
total_amount INT, cash_amount decimal(10,2), credit_amount decimal(10,2), payment_type varchar(20), order_status varchar(20), remaining_days INT,
time_limit datetime,
Gift_Card_code_used varchar(10),
customer_name varchar(20),
delivery_id INT,
creditCard_number varchar(20),
CONSTRAINT O1 FOREIGN KEY (Gift_Card_code_used) REFERENCES Giftcard ON DELETE SET NULL ON UPDATE NO ACTION, 
CONSTRAINT O2 FOREIGN KEY(customer_name) REFERENCES Customer,
CONSTRAINT O3 FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT O4 FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE SET NULL ON UPDATE CASCADE
)
--drop table Admin_Customer_Giftcard
--drop table Product
--drop table Admin_Delivery_Order
--drop table Admins
--drop table Credit_Card
--drop table	Customer
--drop table	Customer_CreditCard
--drop table	Customer_Question_Product
--drop table	CustomerAddstoCartProduct
--drop table	Delivery
--drop table	Delivery_Person
--drop table	Giftcard
--drop table	offer
--drop table	offersOnProduct
--drop table	Orders
--drop table	Todays_Deals
--drop table Todays_Deals_Product
--drop table	User_Addresses
--drop table	User_mobile_numbers
--drop table	Users
--drop table	Vendor
--drop table	Wishlist
--drop table Wishlist_Product

CREATE TABLE Product
(
serial_no INT PRIMARY KEY IDENTITY(1,1),
product_name varchar(20),
category varchar(20),
product_description text,
price decimal(10,2),
final_price decimal(10,2),
color varchar(20),
available BIT,
rate INT,
vendor_username varchar(20),
customer_username varchar(20),
customer_order_id INT,
CONSTRAINT FK_p1 FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE,
CONSTRAINT FK_p2 FOREIGN KEY(customer_order_id) REFERENCES Orders ON UPDATE CASCADE,
CONSTRAINT FK_p3 FOREIGN KEY(customer_username) REFERENCES Customer ON UPDATE NO ACTION
)

CREATE TABLE CustomerAddstoCartProduct
(
serial_no INT PRIMARY KEY,
customer_name varchar(20),
CONSTRAINT FK_customerAddCP1 FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE NO ACTION,
CONSTRAINT FK_customerAddCP2 FOREIGN KEY(customer_name) REFERENCES Customer ON UPDATE NO ACTION
)

CREATE TABLE Todays_Deals
(
deal_id INT PRIMARY KEY IDENTITY(1,1),
deal_amount INT,
expiry_date datetime,
admin_username VARCHAR(20),
CONSTRAINT FK_todays_deals FOREIGN KEY(admin_username) REFERENCES Admins ON UPDATE CASCADE
)

CREATE TABLE Todays_Deals_Product
(
deal_id INT ,
serial_no INT, 
issue_date datetime,
CONSTRAINT PK_Todays_Deals_Product PRIMARY KEY (deal_id,serial_no),
CONSTRAINT FK1_Todays_Deals_Product FOREIGN KEY(deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK2_Todays_Deals_Product FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE NO ACTION
)

CREATE TABLE offer
(
offer_id INT IDENTITY(1,1) PRIMARY KEY,
offer_amount INT,
expiry_date DATETIME
)


CREATE TABLE offersOnProduct
(
offer_id INT,
serial_no INT,
CONSTRAINT PK PRIMARY KEY (offer_id,serial_no),
CONSTRAINT FK_offers_on_Product FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE NO ACTION,
CONSTRAINT FK2_offers_on_Product FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Customer_Question_Product
(
serial_no INT,
customer_name VARCHAR(20),
question varchar(50), 
answer text,
CONSTRAINT PK_CQP PRIMARY KEY (serial_no,customer_name),
CONSTRAINT FK1_Customer_Question_Product FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE NO ACTION,
CONSTRAINT FK2_Customer_Question_Product FOREIGN KEY(customer_name) REFERENCES Customer ON UPDATE NO ACTION
)

CREATE TABLE Wishlist
(
username VARCHAR(20),
name VARCHAR(20),
CONSTRAINT PK_WL PRIMARY KEY (username,name),
CONSTRAINT FK_WL FOREIGN KEY(username) REFERENCES Customer ON UPDATE NO ACTION
)

CREATE TABLE Giftcard
( 
code varchar(10) PRIMARY KEY,
expiry_date datetime,
amount INT,
username varchar(20),
CONSTRAINT FK_GC FOREIGN KEY(username) REFERENCES Admins on UPDATE CASCADE
)

CREATE TABLE Wishlist_Product
(
username VARCHAR(20),
wish_name VARCHAR(20),
serial_no INT,
CONSTRAINT FK_WLP FOREIGN KEY(username, wish_name) REFERENCES Wishlist ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK2_WLP FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE NO ACTION
)

CREATE TABLE Admin_Customer_Giftcard
(
code varchar(10) ,
customer_name VARCHAR(20),
admin_username VARCHAR(20),
remaining_points INT,
CONSTRAINT PK_ACG PRIMARY KEY (code,customer_name,admin_username),
CONSTRAINT FK_ACG FOREIGN KEY(code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK1_ACG FOREIGN KEY(customer_name) REFERENCES Customer ON UPDATE NO ACTION,
CONSTRAINT FK2_ACG FOREIGN KEY(admin_username) REFERENCES Admins ON UPDATE NO ACTION
)

CREATE TABLE Admin_Delivery_Order
(
delivery_username VARCHAR(20),
order_no INT,
admin_username VARCHAR(20),
delivery_window VARCHAR(50),
CONSTRAINT PK_ADO PRIMARY KEY (delivery_username,order_no),
CONSTRAINT FK1_ADO FOREIGN KEY(delivery_username) REFERENCES Delivery_person ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_ADO FOREIGN KEY(order_no) REFERENCES orders ON UPDATE NO ACTION,
CONSTRAINT FK3_ADO FOREIGN KEY(admin_username) REFERENCES Admins ON UPDATE NO ACTION
)

CREATE TABLE Customer_CreditCard
(
customer_name VARCHAR(20),
cc_number varchar(20) ,
CONSTRAINT PK_CCC PRIMARY KEY (customer_name,cc_number),
CONSTRAINT FK1_CCC FOREIGN KEY(customer_name) REFERENCES Customer ON UPDATE CASCADE,
CONSTRAINT FK2_CCC FOREIGN KEY(cc_number) REFERENCES Credit_Card ON UPDATE CASCADE ON DELETE CASCADE
)








