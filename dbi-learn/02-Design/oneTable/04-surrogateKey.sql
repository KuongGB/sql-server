---04-surrogateKey
--Key giả, key nhân tạo, key thay thế, key tự tăng
--SQL cho mình 2 cơ chế phát sinh số tự tăng
--  + phát sinh số tự tăng ko trùng lại trên toàn table
--  + phát sinh chuổi đc mã hoá hệ hexa(16)vko trùng lại trên toàn bộ database

CREATE TABLE KeyWords(
	SEQ int identity(5,5),
	--mỗi lần mình chèn 1 dòng object thì cột SEQ sẽ tự có giá trị
	--Khởi đầu là 5 mỗi lần tăng 5
	InputText nvarchar(40),
	InputDate datetime, --lưu ngày và giờ
	IP char(40),
	CONSTRAINT PK_KeyWords_SEQ Primary Key (SEQ)
)

INSERT INTO KeyWords VALUES (N'Điện Thoại 1', getdate(), '10.1.1.1')
INSERT INTO KeyWords VALUES (N'Điện Thoại 2', getdate(), '10.1.1.1')
INSERT INTO KeyWords VALUES (N'phone', getdate(), '10.1.1.1')
--Khi chèn thiếu cột(kỹ thuật chèn cột 3) nếu cột thiếu là identity thì k cần liệt kê
SELECT * FROM KeyWords

--Cơ chế 2:
CREATE TABLE KeyWordsV2(
	SEQ uniqueIdentifier default newID() not null,
	--mỗi lần mình chèn 1 dòng object thì cột SEQ sẽ tự có giá trị
	--Khởi đầu là 5 mỗi lần tăng 5
	InputText nvarchar(40),
	InputDate datetime, --lưu ngày và giờ
	IP char(40),
	CONSTRAINT PK_KeyWordsV2_SEQ Primary Key (SEQ)
)

INSERT INTO KeyWordsV2 (InputText,InputDate,IP) VALUES (N'Điện Thoại 1', getdate(), '10.1.1.1')
INSERT INTO KeyWordsV2 (InputText,InputDate,IP) VALUES (N'Điện Thoại 2', getdate(), '10.1.1.1')
INSERT INTO KeyWordsV2 (InputText,InputDate,IP) VALUES (N'phone', getdate(), '10.1.1.1')
---
SELECT * FROM KeyWordsV2
---SurrogatrKey
---Ý nghĩa:
--  1.Nếu table bạn làm ko biết chọn ai làm PK thì dùng surrogatekey
--  2.Thay thế cho composite key
--  3.Trành hiện tượng đổ domino
--------------------------
CREATE TABLE MajorV2(
	SEQ int identity(1,1) primary key,
	ID char(2) not null unique,
	Name nvarchar(30),
)

INSERT INTO MajorV2 VALUES ('SB', N'Quản trị kinh doanh')
INSERT INTO MajorV2 VALUES ('SE', N'Kỹ thuật phần mềm')
INSERT INTO MajorV2 VALUES ('GD', N'Thiết kế đồ hoạ')

--CN(1) - SV(N)
CREATE TABLE StudentV2(
	ID char(8) primary key,
	Name nvarchar(40),
	MID int,
	CONSTRAINT FK_StudentV2_MID_tblMajorV2Id Foreign key (MID) References MajorV2(SEQ)
)

INSERT INTO StudentV2 VALUES ('S1', N'An', '1')
INSERT INTO StudentV2 VALUES ('S2', N'Bình', '1')
INSERT INTO StudentV2 VALUES ('S3', N'Cường', '2')
INSERT INTO StudentV2 VALUES ('S4', N'Dũng', '2')

SELECT * FROM MajorV2
SELECT * FROM StudentV2
---Cũ=---
CREATE TABLE MajorV1(
	ID char(2) not null primary key,
	Name nvarchar(30),
)

INSERT INTO MajorV1 VALUES ('SB', N'Quản trị kinh doanh')
INSERT INTO MajorV1 VALUES ('SE', N'Kỹ thuật phần mềm')
INSERT INTO MajorV1 VALUES ('GD', N'Thiết kế đồ hoạ')

--CN(1) - SV(N)
CREATE TABLE StudentV1(
	ID char(8) primary key,
	Name nvarchar(40),
	MID char(2),
	CONSTRAINT FK_StudentV1_MID_tblMajorV1Id Foreign key (MID) References MajorV1(ID)
			ON DELETE SET NULL
			ON UPDATE CASCADE
)

INSERT INTO StudentV1 VALUES ('S1', N'An', 'GD')
INSERT INTO StudentV1 VALUES ('S2', N'Bình', 'GD')
INSERT INTO StudentV1 VALUES ('S3', N'Cường', 'SB')
INSERT INTO StudentV1 VALUES ('S4', N'Dũng', 'SB')


----BaiTap
--05-SuperMaket:siêu thị
--thiếu kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)

--06-PromotionGirl
	--(kỹ thuật đệ quy khóa ngoại)
	--tạo table lưu trữ thông tin các em promotion girl
	--trong đám promotion girl
	--sẽ có 1 vài em được chọn ra để quản lý các em khác chia thành nhiều team

--liệt kê danh sách cách leader
	--liệt kê danh sách các thành viên của leader A
		--(tính cả leader A | hoặc không)
	--B được leader bởi ai
	--lấy ra thông tin của C kèm với thông tin leader của C



