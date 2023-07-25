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
CREATE DATABASE DBK17_PromotionGirl
USE DBK17_PromotionGirl

CREATE TABLE PromotionGirl(
	ID char(8) primary key not null,
	Name nvarchar(40) not null,
	Phone char(10),
	LID char(8) not null,
	constraint FK_PromotionGirl_LID_ID Foreign key (ID) references PromotionGirl(ID)
)


INSERT INTO PromotionGirl VALUES ('001',N'Thuỷ', '0343525324','003')
INSERT INTO PromotionGirl VALUES ('002',N'Linh', '0384737283','002')
INSERT INTO PromotionGirl VALUES ('003',N'Hồng', '0355004123','003')
INSERT INTO PromotionGirl VALUES ('004',N'Châu', '0384474743','002')
INSERT INTO PromotionGirl VALUES ('005',N'Tiên', '0398484342','005')
INSERT INTO PromotionGirl VALUES ('006',N'Anh',  '0974737488','005')
INSERT INTO PromotionGirl VALUES ('007',N'Quỳnh','0399485943','002')
INSERT INTO PromotionGirl VALUES ('008',N'Vân',  '0938472833','005')

SELECT * FROM PromotionGirl


