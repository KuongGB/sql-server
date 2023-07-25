--01-Count.sql
--Aggregate: gom tụ:Gom nhiều hàng về 1 ô kết quả
--count(*): Đếm hàng | cứ có hàng là đếm
--count(cột): ô nào trong cột có value là đếm
--  'Null thì ko đếm'
----------------------------------------------------
USE convenienceStoreDB
--1.Liệt kê ds các nhân viên
SELECT * FROM Employee
--2.Có bao nhiêu nhân viên, đếm số nhân viên đi
SELECT count(*) FROM Employee
SELECT count(EmpID) FROM Employee
---Tránh đếm trên cột có null

--4.đếm xem có bao nhiêu đơn hàng có ngày yêu cầu RequiredDate
select count(RequiredDate) from Orders 
--5.đếm xem có bao nhiêu khác hàng có số điện thoại (5)
SELECT count(PhoneNumber) FROM Customer
--6.đếm xem có bao nhiêu thành phố đã được xuất hiện trong table khách hàng, cứ có là đếm
SELECT count(City) FROM Customer
--6.1 Đếm xem có bao nhiêu thành phố, mỗi thành phố đếm 1 lần (customer) 
SELECT count(DISTINCT(City)) FROM Customer
--7. Đếm xem có bao nhiêu tp trong table NV, mỗi tp đếm 1 lần
SELECT count(DISTINCT(City)) FROM Employee
--8. Có bao nhiêu khách hàng chưa xd đc số điện thoại (5)
SELECT count(CusID) FROM Customer WHERE PhoneNumber is null 
SELECT count(CusID) - count(PhoneNumber) FROM Customer