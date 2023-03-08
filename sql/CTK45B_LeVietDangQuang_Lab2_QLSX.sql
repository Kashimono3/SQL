/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lê Viết Đăng Quang	
   MSSV: 2111875
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab2_QuanLySanXuat
go
use Lab2_QuanLySanXuat
go
create table ToSanXuat
(MaTSX char (5) primary key,
TenTSX Nvarchar (10)
)
go
create table CongNhan
(MACN char(6) primary key,
Ho Nvarchar (20) ,
Ten Nvarchar (10),
Phai Nvarchar (5),
NgaySinh Datetime,
MaTSX char(5) references ToSanXuat(MaTSX)

)
go
create table SanPham
(MASP char(6) primary key,
TenSP Nvarchar (20),
DVT Nvarchar (10),
TienCong int
)
go
create table ThanhPham
(MACN char(6) references CongNhan(MACN),
MASP char (6) references SanPham(MASP),
Ngay datetime,
SoLuong int
)
go

insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values ('TS02',N'Tổ 2')

insert into SanPham values ('SP001',N'Nồi đất',N'cái',10000)
insert into SanPham values ('SP002',N'Chén',N'cái',2000)
insert into SanPham values ('SP003',N'Bình gốm nhỏ',N'cái',20000)
insert into SanPham values ('SP004',N'Bình gốm lớn',N'cái',25000)

set dateformat dmy 
insert into CongNhan values ('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981',N'TS01')
insert into CongNhan values ('CN002',N'Lê Thị Hồng ',N'Gấm',N'Nữ','04/06/1980',N'TS01')
insert into CongNhan values ('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981',N'TS02')
insert into CongNhan values ('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980',N'TS02')
insert into CongNhan values ('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981',N'TS01')

insert into ThanhPham values ('CN001',N'SP001','01/02/2007',10)
insert into ThanhPham values ('CN002',N'SP001','01/02/2007',5)
insert into ThanhPham values ('CN003',N'SP002','10/01/2007',50)
insert into ThanhPham values ('CN004',N'SP003','12/01/2007',10)
insert into ThanhPham values ('CN005',N'SP002','12/01/2007',100)
insert into ThanhPham values ('CN002',N'SP004','13/02/2007',10)
insert into ThanhPham values ('CN001',N'SP003','14/02/2007',15)
insert into ThanhPham values ('CN003',N'SP001','15/01/2007',20)
insert into ThanhPham values ('CN003',N'SP004','14/02/2007',15)
insert into ThanhPham values ('CN004',N'SP002','30/01/2007',100)
insert into ThanhPham values ('CN005',N'SP003','01/02/2007',50)
insert into ThanhPham values ('CN001',N'SP001','20/02/2007',30)

select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham

--1)
select TenTSX,Ho+' ' +Ten as HoTen,NgaySinh,Phai
from CongNhan,ToSanXuat
where CongNhan.MaTSX = ToSanXuat.MaTSX
order by TenTSX,Ten
--2)
select TenSP,Ngay, SoLuong,TienCong as ThanhTien
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN= ThanhPham.MACN and SanPham.MASP =ThanhPham.MASP and CongNhan.Ho + ' ' + CongNhan.Ten =N'Nguyễn Trường An'
order by Ngay
--3)
Select	*
From	CongNhan 
Where	MACN NOT IN (	Select	A.MACN
						From	ThanhPham A, SanPham B
						Where	A.MASP = B.MASP and B.TenSP =N'Bình gốm lớn')
--4)
Select	B.MACN, Ho +' '+Ten as HoTen,NgaySinh,Phai
From	 CongNhan B, SanPham C, ThanhPham D
Where	B.MACN = D.MACN and C.MASP = D.MASP 
		and C.TenSP = N'Nồi đất' and B.MACN IN (Select	E.MACN
											From	ThanhPham E, SanPham F
											Where	E.MASP = F.MASP and F.TenSP =N'Bình gốm nhỏ')
--5)
select TenTSX,COUNT(MACN)as SoLuong
from CongNhan,ToSanXuat
where CongNhan.MaTSX= ToSanXuat.MaTSX
group By TenTSX
--6)
select Ho,Ten,TenSP,sum(SoLuong) as TongSLSanPham,SoLuong*TienCong as TongThanhTien
From CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and SanPham.MASP=ThanhPham.MASP
group by Ho,Ten,TenSp,SoLuong,TienCong
--7)
select Ho+' '+ten as Hoten, Ngay, sum(SoLuong) as TongSLSanPham,SoLuong*TienCong as TongThanhTien
From CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and SanPham.MASP=ThanhPham.MASP and MONTH(Ngay)=1 and YEAR(Ngay)=2007
group by Ho,Ten,Ngay,SoLuong,TienCong
--8)
select  SanPham.MASP,TenSp,Ngay
from SanPham,ThanhPham

Where	SanPham.MASP = ThanhPham.MASP and MONTH(Ngay)=2 and YEAR(Ngay)=2007 and
		ThanhPham.Ngay = (Select Max(E.Ngay)
											From	ThanhPham E, SanPham F
											Where	SanPham.MASP = ThanhPham.MASP and MONTH(Ngay)=2 and YEAR(Ngay)=2007)
--9)
select Ho+' '+ten,SoLuong,TenSP
from CongNhan,ThanhPham,SanPham

Where	SanPham.MASP = ThanhPham.MASP and CongNhan.MACN=ThanhPham.MACN and
		ThanhPham.SoLuong = (Select Max(E.SoLuong)
											From	ThanhPham E, SanPham F
											Where	SanPham.MASP = ThanhPham.MASP and TenSP=N'Chén')
--10)
select Ho+' '+ten as hoten,TienCong ,Ngay
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and CongNhan.MACN = 'CN002' and SanPham.MASP=ThanhPham.MASP and MONTH(Ngay)=2 and YEAR(Ngay)=2006
--11)
Select	 a.MACN,ho+' '+ten as Hoten, COUNT( MASP) As SanPham
From	CongNhan A, ThanhPham C
Where	A.MACN = C.MACN
Group by	A.MACN, Ho,Ten
Having	COUNT( DISTINCT MaSP) >= 3
--12)
UPDATE SanPham
SET TienCong = 21000
WHERE MASP = 'SP003' ;
UPDATE SanPham
SET TienCong = 26000
WHERE MASP = 'SP004' ;
select * from SanPham
--13)

INSERT INTO CongNhan(MACN,Ho,Ten,Phai,NgaySinh,MaTSX) VALUES ( 'CN006',N'Lê Thị',N'Lan',N'Nữ',Null,N'TS02')



