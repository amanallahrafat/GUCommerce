
CREATE PROC vendorRegister
@username varchar(20),@first_name varchar(20), @last_name varchar(20),@password varchar(20),
@email varchar(50), @company_name varchar(20), @bank_acc_no varchar(20)
AS
INSERT INTO Users 
values (@username,@password, @first_name, @last_name, @email);
INSERT INTO Vendor (username,company_name,bank_acc_no)
values (@username, @company_name, @bank_acc_no);
GO;
