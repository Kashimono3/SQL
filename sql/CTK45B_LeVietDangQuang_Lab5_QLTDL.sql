/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lê Viết Đăng Quang	
   MSSV: 2111875
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab5_QuanLyTourDuLich
go
use Lab5_QuanLyTourDuLich
go
create table Tour
(MaTour char (5) primary key,
 TongSoNgay int
)
go
create table ThanhPho
(MaTP char(3) primary key ,
TenTP Nvarchar(20) 
)
go
create table Tour_TP
(MaTour char(5) references Tour(MaTour),
MaTP char(3) references ThanhPho(MaTP) ,
SoNgay int

)
go
create table Lich_TourDL
(MaTour char(5) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(10),
SoNguoi int,
TenKH nvarchar(30)
)
go

insert into Tour values('T001',3)
insert into Tour values('T002',4)
insert into Tour values('T003',5)
insert into Tour values('T004',7)




insert into ThanhPho values ('01',N'Đà Lạt')
insert into ThanhPho values ('02',N'Nha Trang')
insert into ThanhPho values ('03',N'Phan Thiết')
insert into ThanhPho values ('04',N'Huế')
insert into ThanhPho values ('05',N'Đà Nắng')


insert into Tour_TP values ('T001','01',2 )
insert into Tour_TP values ('T001','03',1 )
insert into Tour_TP values ('T002','01',2 )
insert into Tour_TP values ('T002','02',2 )
insert into Tour_TP values ('T003','02',2 )
insert into Tour_TP values ('T003','01',1 )
insert into Tour_TP values ('T003','04',2 )
insert into Tour_TP values ('T004','02',2 )
insert into Tour_TP values ('T004','05',2 )
insert into Tour_TP values ('T004','04',3 )

set dateformat dmy 
insert into Lich_TourDL values ('T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng')
insert into Lich_TourDL values ('T002','14/02/2017',N'Nam',30,N'Lê Ngọc')
insert into Lich_TourDL values ('T002','06/03/2017',N'Hùng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T003','18/02/2017',N'Dũng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T004','18/02/2017',N'Hùng',20,N'Dũng Nam')
insert into Lich_TourDL values ('T003','10/03/2017',N'Nam',45,N'Nguyễn An')
insert into Lich_TourDL values ('T002','28/04/2017',N'Vân',25,N'Ngọc Dung')
insert into Lich_TourDL values ('T004','29/04/2017',N'Dũng',35,N'Lê Ngọc')
insert into Lich_TourDL values ('T001','30/04/2017',N'Nam',25,N'Trần Nam')
insert into Lich_TourDL values ('T003','15/06/2017',N'Vân',20,N'Trịnh Bá')


select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL



--a) 
select DISTINCT* from Lich_TourDL A , Tour B
where a.MaTour=b.MaTour and TongSoNgay between 3 and 5

--b)
select DISTINCT* from Lich_TourDL A 
where MONTH(A.NgayKH) = 2 and YEAR(A.NgayKH)=2017
--c)
select DISTINCT	*
From	Lich_TourDL A 
Where	MaTour NOT IN (Select	    A.MaTour
						From	Lich_TourDL A,Tour_TP b,ThanhPho C
						Where	A.MaTour = B.MaTour and B.MaTP = c.MaTP and c.TenTP = N'Nha Trang')
--d)
select  Lich_TourDL.MaTour, NgayKH,TenHDV,Count(DISTINCT  MaTP) as TongSoThanhPho
from Lich_TourDL,Tour_TP
where Lich_TourDL.MaTour =Tour_TP.MaTour
group by Lich_TourDL.MaTour,NgayKH,TenHDV

--e)
select TenHDV ,  Count(DISTINCT MaTour) as   SoLuongTour
from  Lich_TourDL
group by TenHDV

--f)





--g)

--h)
select DISTINCT Lich_TourDL.MaTour, SoNgay
from Lich_TourDL,Tour_TP
where Lich_TourDL.MaTour =Tour_TP.MaTour
		and Tour_TP.MaTP= '01'

--i)
select MaTour,NgayKH,TenHDV,MAX(count(SoNguoi))as TongSoNguoi,TenKH
from Lich_TourDL
group by MaTour,NgayKH,TenHDV,TenKH,SoNguoi

						
--j)