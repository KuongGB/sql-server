--05-SuperMaket:siêu thị
--thiếu kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)
CREATE DATABASE DBK17_Maket
USE DBK17_Maket

CREATE TABLE Customer(
	ID char(5) not null,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Dob date null,
	Sex char(1) null,
	numberOfInhabitants char(9) null,
	phone char(10) null,
	email varchar(40) not null,
	typeOfCustomer char(10) not null,
)
--DROP TABLE Customer

ALTER TABLE Customer ADD CONSTRAINT PK_Customer_ID primary key (ID)

INSERT INTO Customer VALUES ('001',N'Hương Ly','01/14/2000','F','000000001','0937448233',null,'gold')
INSERT INTO Customer VALUES ('002',N'Gia Bảo','05/26/1995','M','000000002','0982377323',null,'silver')
INSERT INTO Customer VALUES ('003',N'Đan Trường','03/09/1999','M','000000003','0911239483',null,'diamond')
INSERT INTO Customer VALUES ('004',N'Nam Em','09/02/2002','F','000000004','0373462334',null,'silver')
INSERT INTO Customer VALUES ('005',N'Quốc Anh','01/07/1998','M','000000005','0931228233',null,'bronze')

SELECT * FROM Customer



