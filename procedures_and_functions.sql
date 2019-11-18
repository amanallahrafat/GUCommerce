-- Fathy's procedures
GO
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
END

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
<<<<<<< HEAD
INSERT INTO Users 
values (@username,@password, @first_name, @last_name, @email);
INSERT INTO Vendor (username,company_name,bank_acc_no)
values (@username, @company_name, @bank_acc_no);


=======
INSERT INTO Users
values(@username ,@password, @first_name,@last_name,@email)

INSERT INTO Vendor(username,company_name,bank_acc_no)
values(@username, @company_name , @bank_acc_no)
END

--end of fathy's procedures
>>>>>>> 08922fb9b40bd6d670b09e2e2caddcf0d2fc2189
