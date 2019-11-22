-- USERS INSERTION
INSERT INTO Users
VALUES('hana.aly' ,'hana' ,'aly' ,'pass1' ,'hana.aly@guc.edu.eg')

INSERT INTO Users
VALUES('ammar.yasser' ,'ammar' ,'yasser' ,'pass4' ,'ammar.yasser@guc.edu.eg')

INSERT INTO Users
VALUES('nada.sharaf' ,'nada' ,'sharaf' ,'pass7' ,'nada.sharaf@guc.edu.eg')

INSERT INTO Users
VALUES('hadeel.adel' ,'hadeel' ,'adel' ,'pass13' ,'hadeel.adel@guc.edu.eg')

INSERT INTO Users
VALUES('mohamed.tamer' ,'mohamed' ,'tamer' ,'pass16' ,'mohamed.tamer@guc.edu.eg')
-- ADMINS INSERTIONS
INSERT INTO Admins
VALUES('hana.aly')

INSERT INTO Admins
VALUES('nada.sharaf')

-- CUSTOMERS INSERTION
INSERT INTO Customer(username, points)
VALUES('ammar.yasser',15)


-- customeraddstocartproduct insertion
INSERT INTO customeraddstocartproduct
VALUES(1, 'ammar.yasser')

-- VENDOR INSERTION
INSERT INTO Vendor
VALUES('hadeel.adel' , 1, 'Dello' , '47449349234' , 'hana.aly')

-- DELIVERY PERSONS
INSERT INTO Delivery_Person
VALUES('mohamed.tamer' , 1)

-- USER ADDRESSES INSERTION
INSERT INTO User_Addresses
VALUES('New Cairo' , 'hana.aly')

INSERT INTO User_Addresses
VALUES('Heliopolis' , 'hana.aly')

-- USER MOBILE INSERTION
INSERT INTO User_mobile_numbers
VALUES('01111111111','hana.aly')

INSERT INTO User_mobile_numbers
VALUES('1211555411','hana.aly')

-- CREDIT CARD INSERTION
INSERT INTO Credit_Card
VALUES('4444-5555-6666-8888' , '2028-10-19' , '232')

-- DELIVERY INAERTION
INSERT INTO Delivery(type , time_duration , fees)
VALUES('pick-up' , 7 ,10 )

INSERT INTO Delivery(type , time_duration , fees)
VALUES('regular' ,14 ,30)

INSERT INTO Delivery(type , time_duration , fees)
VALUES('speedy' ,1 , 50)

-- PRODUCT INSERTION
SET IDENTITY_INSERT Product ON;

INSERT INTO Product(serial_no , product_name , category , product_description , price , final_price , color , available , rate , vendor_username)
VALUES(1,'Bag' ,'Fashion' ,'backbag' , 100 , 100 , 'yellow' , 1,0 , 'hadeel.adel')

INSERT INTO Product(serial_no , product_name , category , product_description , price , final_price , color , available , rate , vendor_username)
VALUES(3,'Blue pen' ,'stationary' ,'useful pen' , 10 , 10 , 'Blue' , 1,0 , 'hadeel.adel')

INSERT INTO Product(serial_no , product_name , category , product_description , price , final_price , color , available , rate , vendor_username)
VALUES(4,'Blue pen' ,'stationary' ,'useful pen' , 10 , 10 , 'Blue' , 0,0 , 'hadeel.adel')
SET IDENTITY_INSERT Product off;
UPDATE Product
SET category = 'fashion'
where serial_no = 4
-- DEALS INSERTION
SET IDENTITY_INSERT Todays_Deals ON;

INSERT INTO Todays_Deals (deal_id , deal_amount , expiry_date , admin_username)
VALUES(1, 30 , '2019-11-30' , 'hana.aly')

INSERT INTO Todays_Deals (deal_id , deal_amount , expiry_date , admin_username)
VALUES(2, 40 , '2019-11-18' , 'hana.aly')

INSERT INTO Todays_Deals (deal_id , deal_amount , expiry_date , admin_username)
VALUES(3, 50 , '2019-12-12' , 'hana.aly')

INSERT INTO Todays_Deals (deal_id , deal_amount , expiry_date , admin_username)
VALUES(4, 10 ,'2019-11-12', 'hana.aly')

SET IDENTITY_INSERT Todays_Deals OFF;

-- OFFERS INSERTION
SET IDENTITY_INSERT offer ON;
INSERT INTO offer (offer_id , offer_amount , expiry_date)
VALUES(1 , 50 ,'2019-11-30')
SET IDENTITY_INSERT offer OFF;


-- WISHLIST INSERTION
INSERT INTO Wishlist
VALUES('ammar.yasser' , 'fashion')


-- WHISHLIST PRODUCT
-- there is a problem : no serial_no in column product with value 2 
INSERT INTO Wishlist_Product
VALUES('ammar.yasser' , 'fashion' , 4)

-- WILL BE INSERTED AFTER EXEC THE PROCEDURE ADD TO WISHLIST IN THE TEST CASES
--INSERT INTO Wishlist_Product
--VALUES('ammar.yasser' , 'fashion' , 2)


-- GIFT CARD INSERTION
INSERT INTO Giftcard(code , expiry_date , amount)
VALUES('G101' ,'2019-11-18', 100)

INSERT INTO Customer_CreditCard
VALUES('ammar.yasser' , '4444-5555-6666-8888')