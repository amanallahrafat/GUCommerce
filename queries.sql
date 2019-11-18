Create DataBase GUCommerce

CREATE TABLE Users
(
username varchar(20) PRIMARY KEY,
password varchar(20) NOT NULL,
first_name varchar(20),
last_name varchar(20),
email varchar(50)
)

CREATE TABLE User_mobile_numbers
(
mobile_number varchar(20),
username varchar(20),
PRIMARY KEY(mobile_number, username),
FOREIGN KEY(username) REFERENCES Users
)

CREATE TABLE User_Addresses
(
address varchar(100),
username varchar(20) ,
PRIMARY KEY(address, username),
FOREIGN KEY(username) REFERENCES Users
)

CREATE TABLE Customer
(
username varchar(20) PRIMARY KEY,
FOREIGN KEY(username) REFERENCES Users,
points decimal(10,2)
)

CREATE TABLE Admins
(
username varchar(20) PRIMARY KEY,
FOREIGN KEY(username) REFERENCES Users,
)

CREATE TABLE Vendor
(
username varchar(20) PRIMARY KEY,
FOREIGN KEY(username) REFERENCES Users,
activated BIT,
company_name varchar(20),
bank_acc_no varchar(20),
admin_username varchar(20),
FOREIGN KEY(admin_username) REFERENCES Admins
)

CREATE TABLE Delivery_Person
(
username varchar(20) PRIMARY KEY,
is_activated BIT,
FOREIGN KEY(username) REFERENCES Users
)

CREATE TABLE Credit_Card
(number varchar(20) PRIMARY KEY,
expiry_date datetime,
cvv_code varchar(20))

CREATE TABLE Delivery(
id INT PRIMARY KEY,
type varchar(20),
time_duration INT,
fees decimal(5,3),
username varchar(20),
FOREIGN KEY(username) REFERENCES Admins
)

--Datatypes have to be discussed in Orders Table

CREATE TABLE Orders
(order_no INT PRIMARY KEY,
order_date datetime,
total_amount INT, cash_amount decimal(10,2), credit_amount decimal(10,2), payment_type varchar(20), order_status varchar(20), remaining_days INT,
time_limit datetime,
Gift_Card_code_used varchar(10),
customer_name varchar(20),
delivery_id INT,
creditCard_number varchar(20),
FOREIGN KEY (Gift_Card_code_used) REFERENCES Giftcard, 
FOREIGN KEY(customer_name) REFERENCES Customer,
FOREIGN KEY(delivery_id) REFERENCES Delivery,
FOREIGN KEY(creditCard_number) REFERENCES Credit_Card

)


CREATE TABLE Product
(
serial_no INT PRIMARY KEY,
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
FOREIGN KEY(vendor_username) REFERENCES Vendor,
FOREIGN KEY(customer_order_id) REFERENCES Orders,
FOREIGN KEY(customer_username) REFERENCES Customer
)

CREATE TABLE CustomerAddstoCartProduct
(
serial_no INT PRIMARY KEY,
customer_name varchar(20),
FOREIGN KEY(serial_no) REFERENCES Product,
FOREIGN KEY(customer_name) REFERENCES Customer
)

CREATE TABLE Todays_Deals
(
deal_id INT PRIMARY KEY,
deal_amount INT,
expiry_date datetime,
admin_username VARCHAR(20),
FOREIGN KEY(admin_username) REFERENCES Admins
)

CREATE TABLE Todays_Deals_Product
(
deal_id INT,
serial_no INT, 
issue_date datetime,
CONSTRAINT PK_Todays_Deals_Product PRIMARY KEY (deal_id,serial_no),
FOREIGN KEY(deal_id) REFERENCES Todays_Deals,
FOREIGN KEY(serial_no) REFERENCES Product
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
FOREIGN KEY(serial_no) REFERENCES Product,
FOREIGN KEY(offer_id) REFERENCES offer
)

CREATE TABLE Customer_Question_Product
(
serial_no INT,
customer_name VARCHAR(20),
question varchar(50), 
answer text,
CONSTRAINT PK_CQP PRIMARY KEY (serial_no,customer_name),
FOREIGN KEY(serial_no) REFERENCES Product,
FOREIGN KEY(customer_name) REFERENCES Customer
)
CREATE TABLE Wishlist
(
username VARCHAR(20),
name VARCHAR(20),
CONSTRAINT PK_WL PRIMARY KEY (username,name),
FOREIGN KEY(username) REFERENCES Customer
)

CREATE TABLE Giftcard
( 
code varchar(10) PRIMARY KEY,
expiry_date datetime,
amount INT,
username varchar(20),
FOREIGN KEY(username) REFERENCES Admins
)

CREATE TABLE Wishlist_Product
(
username VARCHAR(20),
wish_name VARCHAR(20),
serial_no INT,
FOREIGN KEY(username, wish_name) REFERENCES Wishlist,
FOREIGN KEY(serial_no) REFERENCES Product
)

CREATE TABLE Admin_Customer_Giftcard
(
code INT ,
customer_name VARCHAR(20),
admin_username VARCHAR(20),
remaining_points INT,
CONSTRAINT PK_ACG PRIMARY KEY (code,customer_name,admin_username),
FOREIGN KEY(code) REFERENCES Giftcard,
FOREIGN KEY(customer_name) REFERENCES Customer,
FOREIGN KEY(admin_username) REFERENCES Admins
)

CREATE TABLE Admin_Delivery_Order
(
delivery_username VARCHAR(20),
order_no INT,
admin_username VARCHAR(20),
delivery_window VARCHAR(50),
CONSTRAINT PK_ADO PRIMARY KEY (delivery_username,order_no),
FOREIGN KEY(delivery_username) REFERENCES Delivery_person,
FOREIGN KEY(order_no) REFERENCES orders,
FOREIGN KEY(admin_username) REFERENCES Admins
)

CREATE TABLE Customer_CreditCard
(
customer_name VARCHAR(20),
cc_number varchar(20) ,
CONSTRAINT PK_CCC PRIMARY KEY (customer_name,cc_number),
FOREIGN KEY(customer_name) REFERENCES Customer,
FOREIGN KEY(cc_number) REFERENCES Credit_Card
)








