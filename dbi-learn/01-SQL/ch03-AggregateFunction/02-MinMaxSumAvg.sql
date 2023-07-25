--02-MinMaxSumAvg
--tạo databasse
CREATE DATABASE K17F3_ch03_aggregate
USE K17F3_ch03_aggregate
---tạo table lưu điểm trung bình của sinh viên
CREATE TABLE GPA(
	Name nvarchar(10),
	Point float,
	Major char(3)
)

INSERT INTO GPA VALUES(N'An', 9, 'IS') --Nhúng
insert into GPA values(N'Bình', 7, 'IS')
insert into GPA values(N'Cường', 5, 'IS')

insert into GPA values(N'Dũng', 8, 'JS')
insert into GPA values(N'Em', 7, 'JS')
insert into GPA values(N'Giang', 4, 'JS')
insert into GPA values(N'Hương', 8, 'JS')

insert into GPA values(N'Khanh', 7, 'ES')
insert into GPA values(N'Minh', 6, 'ES')
insert into GPA values(N'Nam', 5, 'ES')
insert into GPA values(N'Oanh', 5, 'ES')

SELECT * FROM GPA
--
--IS 3
--JS 4
--ES 4
---------------------------------------
----------------------------
--Min() Max() Sum() Avg()
----------------------------
--tất cả những thằng này là aggregate
--các hàm gom nhóm, gom nhiều về 1 số duy nhất
--gom nhiều value trên 1 cột về thành 1 số
--***Lưu ý: Aggregate sẽ không lồng vào nhau được
--	Max(count(*)) => gãy
------------------------
--1.Có tất cả bao nhiêu sinh viên
SELECT count(*) FROM GPA
SELECT count(Name) FROM GPA

--2. chuyên ngành IS có nhiêu sv
SELECT count(Name) FROM GPA WHERE Major = 'IS'
--2.1 Chuyên ngành nhúng và cầu nối có tổng cộng bao nhiêu sinh
--viên('JS','IS')
SELECT count(Name) FROM GPA WHERE Major in ('JS','IS')
--2.2 Con điểm bao nhiêu là cao nhất trong danh sách sinh viên
SELECT Point FROM GPA WHERE Point >=ALL (SELECT Point FROM GPA)
SELECT max(Point) FROM GPA
--2.3 ai là người cao điểm nhất trong đám sinh viên

SELECT * FROM GPA WHERE Point >=ALL (SELECT Point FROM GPA)
--2.4 tính tổng điểm của tất cả sinh viên
SELECT sum(Point) FROM GPA
--2.5 điểm trung bình của tất cả sinh viên là bao nhiêu
SELECT avg(Point) FROM GPA


--3.Mỗi chuyên ngành có bao nhiêu sinh viên
--Khi đọc đề gặp từ 'Mỗi - each' thì phải nhớ dùng Group By
--Group By: là gom nhóm các object theo 1 tiêu chí nào đó
--Ví dụ: ta có danh sách sinh viên (name, yob, city, point)
--hãy gom nhóm sinh viên theo thành phố

--TP		Số lượng sinh viên  Point
--HCM			30				  ?	
--HN			32
--Đà Nẵng		18
--Mỗi năm sinh có bao nhiêu sinh viên
--YOB		số Lượng sinh viên
--1999			2
--2001			34
--2002			18
--***Lưu Ý: Muốn xài Group by thì phải nhớ thần chú này
--*Khi xài Group by thì mệnh đề SELECT của nó phải
--	chỉ được có những cột trong group by hoặc phải là Aggregate

SELECT Major, count(Name) as Np FROM GPA GROUP BY Major

--4.Điểm cao nhất của mỗi chuyên ngành là bao nhiêu

SELECT Major, max(Point) as MaxP FROM GPA GROUP BY Major
--4.1 điểm trung bình của mỗi chuyên ngành là bao nhiêu

SELECT Major, avg(Point) as AvP FROM GPA GROUP BY Major
--*******************************
--Thêm vào 2 data nữa để tăng độ khó
INSERT INTO GPA VALUES(N'Phượng', 8 , 'JP')
--thêm Phượng 8 điểm, ngôn ngữ nhật
--->trường bổ sung thêm ngành hotel management
INSERT INTO GPA VALUES(Null, Null , 'HT')
--***Sau khi đã thêm data xem lại kết quả câu 3,  
--câu 3 làm lại:

SELECT Major, count(Name) as Np FROM GPA GROUP BY Major

--***********************************
--SELECT...FROM...WHERE...GROUP BY...Having...Order By...
--Having: chính là Where nhưng sau khi gom nhóm
--	Dùng để lọc kết quả sau khi gom nhóm(Group By)
--***Lưu Ý: Muốn xài Group by thì phải nhớ thần chú này
--*Khi xài Group by thì mệnh đề SELECT(Having) của nó phải
--	chỉ được có những cột trong group by hoặc phải là Aggregate

--5. Chuyên ngành có từ 4sv trở lên 
SELECT Major, count(Name) as Np FROM GPA GROUP BY Major HAVING  count(Name) >= 4
--5.1 IS,JS,ES mỗi ngành đó có bao nhiêu sv

SELECT Major, count(Name) as Np FROM GPA GROUP BY Major HAVING  Major in ('JS','IS', 'ES')
--6.Chuyên ngành nào có ít sinh viên nhất

SELECT Major, count(Name) as Np FROM GPA GROUP BY Major HAVING  count(Name) <=ALL (SELECT count(Name) FROM GPA GROUP BY Major)

----
--để anh demo Min():
SELECT Major, count(Name) as Np FROM GPA Group by Major
--MultipleColumn
SELECT Min(np) FROM (SELECT Major, count(Name) as Np ---tìm ra được số min
				FROM GPA Group by Major) as ld
---
SELECT Major, count(Name) as Np FROM GPA Group by Major
Having Count(name) = (SELECT Min(np) FROM (SELECT Major, count(Name) as Np 
				FROM GPA Group by Major) as ld)
------------
--7.Điểm lớn nhất của ngành IS là mấy điểm
--Dùng Max()
SELECT MAX(Point) FROM GPA WHERE Major = 'IS'
--Dùng All()
SELECT Point FROM GPA WHERE Major = 'IS' AND Point >=ALL (SELECT Point FROM GPA WHERE Major = 'IS')
--7.1 lấy Full thông tin của sinh viên thuộc ngành is có điểm
--lớn nhất --Dùng Max()
SELECT * FROM GPA WHERE Point in (SELECT max(Point) FROM GPA WHERE Major = 'IS')
--11.Điểm lớn nhất của mỗi chuyên ngành(cẩn thận HT) --Dùng Max()
--gợi ý dùng iif
SELECT Major, iif(MAX(Point) is null,0, MAX(Point)) as MaxP FROM GPA GROUP BY Major
SELECT Major, MAX(Point) as MaxP FROM GPA GROUP BY Major HAVING MAX(Point) is not null
--12.Chuyên ngành nào có thủ khoa có điểm trên 8 --Dùng Max()
SELECT Major, MAX(Point) as Ss FROM GPA GROUP BY Major HAVING MAX(Point) > 8
--13***.Liệt kê những sinh viên đạt thủ khoa của mỗi chuyên ngành
--(chưa làm được)(đệ quy- join)
SELECT * FROM (SELECT Major, iif(MAX(Point) is null, 0, max(Point)) as Ss FROM GPA GROUP BY Major) as tc left join GPA g on g.Point = tc.Ss AND tc.Major = g.Major

--=======================
USE convenienceStoreDB
--************Đề******************
--14.1. Trọng lượng nào là con số lớn nhất, tức là trong các đơn "hàng đã vận chuyển",
-- trọng lượng nào là lớn nhất, trọng lượng lớn nhất 
--là bao nhiêu???
--> lấy giá trị lớn nhất trong 1 tập hợp
---Dùng All:
SELECT * FROM Orders WHERE Freight >=ALL(SELECT Freight FROM Orders)
---Dùng MAX Thử:
SELECT * FROM Orders WHERE Freight in (SELECT MAX(Freight) FROM Orders)x`
--14. Đơn hàng nào có trọng lượng lớn nhất
--Output: mã đơn, mã kh, trọng lượng
--dùng All thử:
SELECT OrdID, CustomerID, Freight FROM Orders WHERE Freight >=ALL(SELECT Freight FROM Orders)

--dùng MAX thử: 
SELECT OrdID, CustomerID, Freight FROM Orders WHERE Freight in (SELECT MAX(Freight) FROM Orders)

--15.Đếm số đơn hàng của mỗi quốc gia 
--Output: quốc gia, số đơn hàng
--nghe chữ mỗi: chia nhóm theo .... => dùng Group By ngay 
SELECT ShipCountry, count(OrdID) as NumOrd FROM Orders GROUP BY ShipCountry
--15.1-Hỏi rằng quốc gia nào có từ 8 đơn hàng trở lên
--việc đầu tiên là phải đếm số đơn hàng của mỗi quốc gia
--đếm xong, lọc lại coi thằng nào >= 8 đơn thì in 
--lọc lại sau khi group by, chính là HAVING
SELECT ShipCountry, count(OrdID) as NumOrd FROM Orders GROUP BY ShipCountry HAVING count(OrdID) > 8
--16.Quốc gia nào có nhiều đơn hàng nhất??
--Output: quốc gia, số đơn hàng
--đếm xem mỗi quốc gia có bao nhiêu đơn hàng
--sau đó lọc lại
--Dùng ALL Thử: 

SELECT ShipCountry, count(OrdID) as NumOrd FROM Orders GROUP BY ShipCountry HAVING count(OrdID) >=ALL(SELECT count(OrdID) FROM Orders GROUP BY ShipCountry)
--Dùng Max thử: 
SELECT ShipCountry, count(OrdID) as NumOrd FROM Orders GROUP BY ShipCountry HAVING count(OrdID) = (SELECT max(NumOrd) FROM (SELECT ShipCountry, count(OrdID) as NumOrd FROM Orders GROUP BY ShipCountry) as ld)
--Nếu ko đc dùng >= ALL
--tim max sau khi đếm, mà ko đc dùng max(count) do SQL ko cho phép
--ta sẽ count, coi kết quả count là 1 table, tìm max của table này để
--ra đc 12
--Thử dùng Max() xem sao
--16
--Thử dùng Max() xem sao
SELECT ShipCountry, count(OrdId) as Np 
FROM Orders Group By ShipCountry
--MultipleColumn
SELECT Max(Np) FROM (SELECT ShipCountry, count(OrdId) as Np 
				FROM Orders Group By ShipCountry) as ld
--
SELECT ShipCountry, count(OrdId) as Np 
FROM Orders Group By ShipCountry
Having count(OrdId) = (SELECT Max(Np) FROM (SELECT ShipCountry, count(OrdId) as Np 
				FROM Orders Group By ShipCountry) as ld)
--17.Mỗi cty đã vận chuyển bao nhiêu đơn hàng
--Output1: Mã cty, số lượng đơn hàng - hint: group by ShipId(ShipVia)
SELECT ShipID, count(OrdID) as NumOrd FROM Orders GROUP BY ShipID 
--*khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)

--18.Cty nào vận chuyển ít đơn hàng nhất
--Output1: Mã cty, số lượng đơn
---Dùng All Thử: 
SELECT ShipID, count(OrdID) as NumOrd FROM Orders GROUP BY ShipID HAVING count(OrdID) <=ALL(SELECT count(OrdID) FROM Orders GROUP BY ShipID) 
---dùng Min() thử xem: 
SELECT ShipID, count(OrdID) as NumOrd FROM Orders GROUP BY ShipID HAVING count(OrdID) = (SELECT min(NumOrd) FROM (SELECT ShipID, count(OrdID) as NumOrd FROM Orders GROUP BY ShipID) as LD)
--*Khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)

--19.in ra danh sách id các khánh hàng kèm tổng
-- cân nặng của tất cả đơn hàng họ đã mua
---->câu này hỏi khác đi: số lượng cân nặng mà khách hàng đã mua
--hint: Sum + Group by:
SELECT CustomerID, sum(Freight) FROM Orders GROUP BY CustomerID

--20.khách hàng nào có tổng cân nặng của 
--tất cả đơn hàng họ đã mua là lớn nhất
--dùng ALL():
SELECT CustomerID, sum(Freight) FROM Orders GROUP BY CustomerID HAVING sum(Freight) >=ALL( SELECT sum(Freight) FROM Orders GROUP BY CustomerID)
--Dùng Max thử: 
SELECT CustomerID, sum(Freight) as SumF FROM Orders GROUP BY CustomerID HAVING sum(Freight) = (SELECT Max(SumF) FROM (SELECT CustomerID, sum(Freight) as SumF FROM Orders GROUP BY CustomerID) as LD)
--21.NY, London có tổng bao nhiêu đơn hàng
-- dùng count bth xem sao
SELECT count(OrdID) FROM Orders WHERE ShipCity in ('NY', 'London') 
SELECT ShipCity, count(OrdID) as numF FROM Orders GROUP BY ShipCity HAVING ShipCity in ('NY', 'London')

--group by having, sum cho nghệ thuật: 
SELECT sum(numF) FROM (SELECT ShipCity, count(OrdID) as numF FROM Orders GROUP BY ShipCity HAVING ShipCity in ('NY', 'London')) as ld

--22.công ty vận chuyển nào vận chuyển nhiều đơn hàng nhất
--dùng thử All(): 
SELECT ShipID, count(OrdID) as numOrd FROM Orders GROUP BY ShipID HAVING count(OrdID) >=ALL (SELECT count(OrdID) FROM Orders GROUP BY ShipID)
--Dùng MAX() thử xem:
SELECT ShipID, count(OrdID) as numOrd FROM Orders GROUP BY ShipID HAVING count(OrdID) = (SELECT max(numOrd) FROM (SELECT ShipID, count(OrdID) as numOrd FROM Orders GROUP BY ShipID) as ld)