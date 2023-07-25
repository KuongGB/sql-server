--07-Null

--dữ liệu trong thực tế đôi khi trong thời điểm điền thông tin ta chưa biết bỏ thông tin gì vào trong
--vd: đi thi thì không viết điểm vào trong ô điểm
--undefined(bất định, vô định): biết kiểu dữ liệu, nhưng mà không rõ ràng, không biết cụ thể là con số bao nhiêu
--cột is null/not cột is null/cột is not null
--cột = null là sai

--1. Xài db convenienceStoreDB
use convenienceStoreDB
--2. Liệt kê danh sách khách hàng
select * from Customer
--3. liệt kê danh sách các khách hàng chưa có số điện thoại
select * from Customer where PhoneNumber is null
--4. liệt kê danh sách các khách hàng đã có số điện thoại
select * from Customer where PhoneNumber is not null
--5. Liệt kê danh sách các đơn hàng chưa có RequiredDate và đến từ London và California
select * from Orders 
	where RequiredDate is null 
		and ShipCity in ('London', 'California')
--6. Liệt kê danh sách các đơn hàng đã có RequiredDate, được ship bởi 2 công ty vận chuyển SHIP001
--và SHIP004
select * from Orders 
	where RequiredDate is not null 
		and ShipID in ('SHIP001', 'SHIP004')