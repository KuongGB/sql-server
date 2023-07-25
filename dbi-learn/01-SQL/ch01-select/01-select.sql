--01-Select
--Trong database sql, thì sẽ ko phân biệt hoa thường
--nhưng các dev sec viết hoa hết (quy ước)
--select là gì
--1. select dúng printf | sout | lệnh in ra màn hình
SELECT 'hello' 
--2. select này còn giúp mình đặt câu hỏi vs sever (cụ thể là table)
-- query(truy xuất dữ liệu dạng bảng)

-- Datatype : kiểu dữ liệu
--> số: integer, decimal, float, double, money(đơn vị tiền tệ)
--> chuỗi : char(?), nchar(?), varchar(?), nvarchar(?)
   -- char(?)| nchar(?): lưu trữ ko co giãn, truy xuất nhanh vì lưu ở ram
        -->xin nhiều sài ít, bù bằng dấu space(32)
		--> hợp với kiểu dữ liệu có kích thước cụ thể
        --char(10) -> 'xinchao\0'

   -- varchar(?)| nvarchar(?): lưu trữ co giãn, truy xuất chậm vì lưu hdd, ssd(ổ cứng)
        --xin nhiêu xài ít, tự rút gọn
		-- tiết kiệm tối đa vùng nhớ, nhưng truy xuất chậm

   -- ?: độ dài của chuỗi
     -- hello -> hello'\0' -> 6
     -- điệp -> điệp'\0' -> 5
   -- n: cho phép unicode(viết dấu)
     -- char(10) -> xin chào -> xin ch?o
	 -- nchar(10) -> xin chào -> xin chào

----khi em muốn in ra màn hình 1 chuỗi em dùng ' '
-- ví dụ: 'Ahihi'
--'xin chào các' --> 'xin ch?o c?c'
--N'xin chào các' --> 'xin chào các'
--SELECT 'xin chào các'

---> ngày tháng năm: date, datetime, ..., YYYY-MM-DD
--ngày tháng năm được dùng như chuỗi
--'2022-5-3' |'2022-05-03'

--Built in function: hàm có sẵn
--round(number, radix): làm tròn radix đơn vị sau dấu)
SELECT round(5.76,1) --5.8
SELECT round(5.76,0) --6

--getdate(): ngày và thời gian hiện hành
SELECT GETDATE()
--month(): trích được tháng của 1 ngày nào đó
SELECT MONTH('1999-4-22')
--year(); day();

------------------------------
--1. in ra màn hình 1 câu sau:
--'Anh Điệp đẹp trai quá, em khen thật lòng'
SELECT N'Anh Điệp đẹp trai quá, em khen thật lòng'
--2. in ra màn hình
--'Em yêu anh điệp lắm'
SELECT N'Em yêu anh điệp lắm'
--3. in ra đầu đủ họ tên của bạn 'kết hợp' <3
--và hết hợp tên của Crush
--hint: dúng + để kết hợp
SELECT N'Trịnh Quốc Cường' + ' <3 ' +N'Cường Quốc Trịnh'
--4. in ra kết quả cảu 10 + 5
SELECT 10+5 -- 5
SELECT '10' - '5' --error

--5. in ra cho anh bây h là ngày tháng năm nào
SELECT GETDATE()
SELECT MONTH(GETDATE())

--6. tính tuổi của chính mình
SELECT YEAR(GETDATE())-2002