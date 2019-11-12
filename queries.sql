Create DataBase GUCommerce

CREATE TABLE Users
(
username varchar(20) PRIMARY KEY,
password varchar(20),
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
time_duration INT,
fees decimal(5,3),
username varchar(20),
FOREIGN KEY(username) REFERENCES Admins
)

--Datatypes have to be discussed in Orders Table
CREATE TABLE Orders
(order_no INT PRIMARY KEY,
order_date datetime,
total_amount INT, cash_amount decimal(10,2), credit_amount decimal(10,2), payment_type varchar(20), order_status varchar(20), remaining_days INT, time_limit datetime,
customer_name varchar(20),
delivery_id INT,
creditCard_number varchar(20),
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
final_price decimal(10,2),
color varchar(20), available BIT, rate INT,
vendor_username varchar(20), customer_username varchar(20)
FOREIGN KEY(customer_name) REFERENCES Customer,
FOREIGN KEY(vendor_username) REFERENCES Vendor
)