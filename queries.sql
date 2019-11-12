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
FOREIGN KEY(username) REFERENCES Users,
)