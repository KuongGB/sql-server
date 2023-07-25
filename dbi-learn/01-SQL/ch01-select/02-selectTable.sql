--02-selectTable.sql
--Trên thế giới có rất nhiều dạng database
--RDBMS - relationship database management system
--		(hệ thống quản trị cơ sỡ dữ liệu quan hệ)
		--(Oracle, MySQL, MS server, PostgreSQL)
--CSDL dạng khóa - giá trị (treeset) (Redis, Memcached)
--Document store (MongoDB, Couchbase)

--ACID: đại diện cho sự vững bền của database
--RDBMS đáp ứng các nguyên tố ACID

--ACID: 4 nguyên tố
--*Atomicity: tính nguyên tố: trong một chu trình xử lý có nhiều tác vụ
			--nếu tất cả các tác vụ hoàn thành thì chu trình hoàn thành
			--nếu 1 tác vụ false cả chu trình false
--*Consistency: Tính nhất quán:
			-- 1 tác vụ nào đó sẽ tạo ra trạng thái mới hợp lệ cho data
			-- hoặc nếu thất bại sẽ không bị ngặt giữa chừng mà sẽ
			-- trả về trạng thái trước gia dịch

--*Isolation: Tính độc lập:
			--một tác vụ đang thực thi và chưa được xác nhận
			--phải đảm bảo tách biệt khỏi các tác vụ khác
--*Durability: tính bền vững: Dữ liệu khi được xác nhận hợp lệ (Consistency) 
			-- thì nó phải được lưu trữ sao cho, nếu mà hệ thống lỗi, hỏng hóc
			-- dữ liệu vẫn đảm bảo trong trạng thái chuẩn xác
--vd: muốn chyển tiền từ tk A sang tk B
----đó gọi là 1 chu trình
--có nhiều tác vụ:
---kiểm tra tkA | kiểm tra xem tiền hợp lệ không |
--- xác nhận giao dịch| kiểm tra tài khoản B | chuyển
-- Truy xuất thông qua SQL rất đa dụng, rất dể phát triễn và mở rộng
-- cung cấp phân quyền (admin, guest, user, ... )
--Nhược điểm
--	xử lý các dữ liệu phi cấu trúc yếu(đánh đổi của việc ACID)
--	tốc độ xử lý khá chậm
--Nên dùng khi nào:
	--Giữ vững tính toàn vẹn dữ liệu
	--không thể bị chỉnh sửa dễ dàng
	--vd: ứng dụng tài chính, ứng dụng trong quốc phòng
	--		 an ninh và trong lĩnh vực thông tin, sức khỏe cá nhân
	--các ứng dụng tự động hóa, thông tin nội bộ
	---------------------------------------------
	--trong database có rất nhiều table
--trong table là gì ? (một danh sách các đối tượng đồng khuôn)
--Cột/ column/ field/ attribute/ property
--hàng/dòng/row full thông tin được coi là 1 object(đối tượng)
		--1 dòng là 1 object
--1 table luôn có ít nhất 1 cột đặc biệt
--cột này có data không trung với bất cứ hàng nào trong cột
--cột này có tên là PK(primary key - khóa chính)
--ý nghĩa: giúp cho không có một hàng nào trong table trùng nhau 100%
---> giúp truy xuất chính xác một đối tượng cụ thể
--table student
--ID  name   yob
--01  Diep   1999
--02  Hung   2000
--03  Lam    2003	
------------------------------------------------------
--2.database là gì?
--là 1 tập hợp nhiều table có cùng chủ đề để giả quyết 1 bài toàn quản lý
--quản lý cửa hàng thuốc(Nhân viên, Thuốc, Suplier, Order, custumer)
--những table này sẽ liên kết với nhau bằng các mối quan hệ relationship
--(1 1 , 1 n , n n)
--3.để xem, thêm ,xóa, và sửa dữ liệu 
--ta cần dùng SQL
--DML: data manipulation language: ngôn ngữ thao tác dữ liệu
--Select		insert		update		delete
use convenienceStoreDB --- truy câp database
select * from Customer

--1. Liệt kê ds nhân viên có đầy đủ thông tin
--xác định -> table Employee chứa danh sách nhân viên
--cần cột nào : đầy đủ thông tin -> tất cả các cột (*)
USE convenienceStoreDB
SELECT * FROM Employee
--2. List nhân viên, chỉ lấy vài cột
--output: mã nhân viên, lastname, firstName, ngày tháng năm sinh
SELECT EmpID, FirstName, LastName, Birthday FROM Employee
--3. List nhân viên, nhung có output sau:
--Empid, fullName, birthday
--hint: dùng '+'
SELECT EmpID, FirstName + ' ' + LastName as fullName, Birthday FROM Employee
--alias: tên giả
--4. list nhân viên theo output sau
--empid, fullName, năm sinh
SELECT EmpID, FirstName + ' ' + LastName as fullName, year(Birthday) as YOB FROM Employee
--5. tuoi cua các nhân viên
SELECT EmpID, FirstName + ' ' + LastName as fullName, year(getdate())-year(Birthday) as Age FROM Employee
--6. In ra các nhà cung câp sản phẩm
SELECT * from Supplier
--7. In ra thông tin các nhà vân chuyển
SELECT * from Shipper
--8. công ty bán nhưang chủng loại sản phẩm nào
SELECT * from Category
--9. bán nhưng sản phẩm nào
SELECT * from Product
--10. kho có nhưng gì
SELECT * from Barn
--11.In ra thông tin các đơn hàng đã bán
SELECT * from Orders
--12.in ra thông tin của các đơn hàng
--orderId, CustomerId, employeeid, Freight
SELECT OrdID, CustomerID, EmpID, Freight from Orders
--13. in ra thông tin chi tiết đơn hàng
SELECT * from OrdersDetail