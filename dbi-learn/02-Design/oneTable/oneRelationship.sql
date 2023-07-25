--oneRelationship
--1-1
CREATE DATABASE DBK17F2_OneOneRelationship
USE DBK17F2_OneOneRelationship

CREATE TABLE Citizen(
	ID char(9) not null,
	LastName nvarchar(15) not null,
	FirstName nvarchar(30) not null,
)

ALTER TABLE Citizen ADD CONSTRAINT PK_Citizen_ID PRIMARY KEY(ID)

INSERT INTO Citizen VALUES ('C1',N'Nguyễn',N'An')
INSERT INTO Citizen VALUES ('C2',N'Lê',N'Bình')
INSERT INTO Citizen VALUES ('C3',N'Võ',N'Cường')
INSERT INTO Citizen VALUES ('C4',N'Phạm',N'Dũng')

SELECT * FROM Citizen
--cần 1 passport
--mỗi cmnd thì chỉ lm đc 1 passport thôi
--mỗi passport đc lm từ cmnd
--2 tk này là mối quan hệ 1-1

CREATE TABLE Passport(
	PNO char(8) not null,
	IssuedDate date, --ngày thực thi
	ExpiredDate date, --ngày hết hạn
	CMND char(9) not null,
)

ALTER TABLE Passport ADD CONSTRAINT PK_Passport_PNO primary key (PNO)
ALTER TABLE Passport ADD CONSTRAINT FK_Passport_CMND_CitizenID foreign key (CMND) references Citizen(ID)
ALTER TABLE Passport ADD CONSTRAINT UQ_Passport_CMND Unique(CMND)


INSERT INTO Passport VALUES ('B1','2022-6-21','2032-6-21','C1')
INSERT INTO Passport VALUES ('B2','2022-6-21','2032-6-21','C1')
--mối quan hệ 1-1 đc tạo dựa trên 2 ràng buộc (khoá ngoại FK và Unique(Cấm trùng)


