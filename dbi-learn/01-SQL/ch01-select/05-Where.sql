--05-where
------------------------
--I-Lý Thuyết
------------------------
--một câu select đầy đủ sẽ là
--select .. from... where...group by ..having...order by 

--vế select sẽ giúp ta filter các cột mà mình muốn
--1.select * from table_x 
--			sẽ lấy ra hết tất cả các cột
--			và các dòng của table x
--2. select id, name from table_X 
--			lấy ra cột id và cột name được
--			liệt kê và tất cả các dòng của tableX

--From giúp ta biết phải lấy từ table nào
--Where giúp ta filter data theo dòng dựa vào điều kiện cột

--4.select * from tableX where <condition clause>:lấy hết
-- tất cả các cột ,nhưng chỉ lấy các dòng thỏa điều kiện
--5. toán tử: <= >= = != <>
--logic: and or not
--nên dùng () để bọc mệnh để cho dễ phân biệt

--------------------------
--Thực Hành
--------------------------

 use convenienceStoreDB
 --1. Liệt kê các nhân viên
	select * from Employee
 --2. Liệt kê các nhân viên đang ở thành phố California
	select * from Employee where city = 'California'
 --3. Liệt kê các nhân viên ở London.
 --output: ID, Name (ghép fullname), Title, Address
	select LastName + ' ' + FirstName from Employee where city = 'London'

 --4. Liệt kê tất cả các nhân viên ở thành phố London và California 
   select * from Employee where city = 'London' or city = 'California'
 --5. Liệt kê tất cả các nhân viên ở thành phố London hoặc NY 
	select * from Employee where city = 'London' or city = 'NY'
 --6. liệt kê các đơn hàng
	select * from orders
 --7. liệt kê các đơn hàng không giao tới 'Hàng Mã'
	select * from orders where ShipCity != N'Hàng Mã'
 
--8. liệt kê các đơn hàng không giao tới 'Hàng Mã' và London
	select * from orders where ShipCity != N'Hàng Mã' and ShipCity != 'London'
--9. liệt kê các đơn hàng không giao tới 'Hàng Mã' hoặc London
	select * from orders where ShipCity != N'Hàng Mã' and ShipCity != 'London'

--10. Liệt kê các nhân viên có chức danh là Promotion
	select * from Employee where Title = 'Promotion'
--11. Liệt kê các nhân viên có chức danh không là Promotion
--làm bằng 3 cách	!= 
	select * from Employee where Title != 'Promotion'
--					<>
	select * from Employee where Title <> 'Promotion'
--					not
	select * from Employee where not Title = 'Promotion'
--12. Liệt kê các nhân viên có chức danh là Promotion hoặc TeleSale
	select * from Employee where Title = 'Promotion' or Title = 'TeleSale'
--13. Liệt kê các nhân viên có chức danh là Promotion và Mentor
	select * from Employee where Title = 'Promotion' or Title = 'Mentor'
--14. Liệt kê các nhân viên có chức danh không là Promotion và Telesale
	select * from Employee where Title != 'Promotion' AND Title != 'TeleSale'
--16. Những nhân viên nào có năm sinh trước 1972
    SELECT * FROM Employee where year(Birthday) < 1972
--17. Những nhân viên nào tuổi lớn hơn 40, in ra thêm cột tuổi, và sắp xếp 
    SELECT *, YEAR(GETDATE())-year(Birthday) as Age FROM Employee where YEAR(GETDATE())-year(Birthday) > 40 order by Age ASC
--18. Đơn hàng nào nặng hơn 100 và được gữi đến thành phố london
	SELECT * FROM Orders Where Freight > 100 and ShipCity = 'London'
--19.khác hàng nào có tuổi trong khoản 29 - 21 và đang ở london không ? hãy in ra
	SELECT * FROM Customer Where (29 > YEAR(GETDATE())-year(Birthday) and YEAR(GETDATE())-year(Birthday) > 21) and City = 'London'
--20. Liệt kê các khách hàng đến từ Anh Quốc hoặc Vietnam
	--custom
	SELECT * FROM Customer where Country = 'UK' or Country = 'Vietnam'
--21. Liệt kê các các đơn hàng đc gửi tới Vietnam hoặc Nhật bản
	SELECT * FROM Orders where ShipCountry = 'Vietnam' or ShipCountry = 'Japan'
--22. Liệt kê các đơn hàng nặng từ 500.0 đến 100.0 pound (nằm trong đoạn, khoảng)
	SELECT * FROM Orders Where Freight > 100 and Freight < 500
--23. ktra lại cho chắc, sắp giảm dần kết quả theo cân nặng đơn hàng 
	SELECT * FROM Orders Where Freight > 99 and Freight < 501 ORDER BY Freight DESC
--24. Liệt các đơn hàng gửi tới Anh, 
--Mĩ, Việt sắp xếp tăng dần theo trọng lượng
	SELECT * FROM Orders where ShipCountry = 'Vietnam' or ShipCountry = 'UK' or ShipCountry = 'USA' ORDER BY Freight ASC

--25. Liệt các đơn hàng KHÔNG gửi tới Anh, Pháp Mĩ, và có cân nặng trong khoản 50-100
-- sắp xếp tăng dần theo trọng lượng 
	SELECT * FROM Orders where (ShipCountry != 'UK' or ShipCountry != 'USA' or ShipCountry != 'FRANCE') and (Freight > 50 and Freight < 100) ORDER BY Freight ASC
	
--26. Liệt kê các nhân viên sinh ra trong khoảng năm 1970-1999
	SELECT * FROM Employee where year(Birthday) > 1970 AND year(Birthday) < 1999
