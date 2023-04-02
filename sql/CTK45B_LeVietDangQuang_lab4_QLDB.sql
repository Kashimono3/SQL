/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lê Viết Đăng Quang	
   MSSV: 2111875
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab4_QuanLyDatBao
go
use Lab4_QuanLyDatBao
go
create table BAO_TCHI
(MaBaoTC char (5) primary key,
Ten Nvarchar (30),
DinhKy Nvarchar(20),
SoLuong int,
GiaBan int
)
go
create table PhatHanh
(MaBaoTC char(5) references BAO_TCHI(MaBaoTC),
SoBaoTC int ,
NgayPhatHanh Datetime ,
)
go
create table KHACHHANG
(MaKH char(5) primary key,
TenKH Nvarchar (20),
DiaCHi Nvarchar (10),

)
go
create table DATBAO
(MaKH char(5) references KHACHHANG(MaKH),
MaBaoTC char (5) references BAO_TCHI(MaBaoTC),
SLMua int,
NgayDM datetime
)
go

insert into BAO_TCHI values('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into BAO_TCHI values ('KT01',N'Kiến Thức ngày nay',N'Bán Nguyệt San',3000,6000)
insert into BAO_TCHI values ('TN01',N'Thanh Niên',N'Nhật báo',1000,2000)
insert into BAO_TCHI values ('PN01',N'Phụ Nữ',N'Tuần báo',2000,4000)
insert into BAO_TCHI values ('PN02',N'Phụ Nữ',N'Nhật báo',1000,2000)


set dateformat dmy 
insert into PhatHanh values ('TT01',123,'15/12/2005')
insert into PhatHanh values ('KT01',70,'15/12/2005')
insert into PhatHanh values ('TT01',124,'16/12/2005')
insert into PhatHanh values ('TN01',256,'17/12/2005')
insert into PhatHanh values ('PN01',45,'23/12/2005')
insert into PhatHanh values ('PN02',111,'18/12/2005')
insert into PhatHanh values ('PN02',112,'19/12/2005')
insert into PhatHanh values ('TT01',125,'17/12/2005')
insert into PhatHanh values ('PN01',46,'30/12/2005')


insert into KHACHHANG values ('KH01',N'LAM',N'2 NCT')
insert into KHACHHANG values ('KH02',N'NAM',N'32 THĐ')
insert into KHACHHANG values ('KH03',N'NGỌC',N'16 LHP')

insert into DATBAO values ('KH01',N'TT01',100,'12/01/2000')
insert into DATBAO values ('KH02',N'TN01',150,'01/05/2001')
insert into DATBAO values ('KH01',N'PN01',200,'25/06/2001')
insert into DATBAO values ('KH03',N'KT01',50,'17/03/2002')
insert into DATBAO values ('KH03',N'PN02',200,'26/08/2003')
insert into DATBAO values ('KH02',N'TT01',250,'15/01/2004')
insert into DATBAO values ('KH01',N'KT01',300,'14/10/2004')


select * from BAO_TCHI
select * from PhatHanh
select * from KHACHHANG
select * from DATBAO

--1) 
select MaBaoTC,GiaBan
from BAO_TCHI
where BAO_TCHI.DinhKy = N'Tuần báo'
--2)
select * from BAO_TCHI
where BAO_TCHI.MaBaoTC like '%PN%'
--3)
select DISTINCT TenKH,DiaChi
from KHACHHANG a, DATBAO b
where a.MaKH=b.MaKH and b.MaBaoTC like '%PN%'
--4)
select TenKH,DiaChi
from KHACHHANG a, DATBAO b
where a.MaKH=b.MaKH and b.MaBaoTC = 'PN01' and b.MaBaoTC = 'PN02'
--5)

select	*
From	KHACHHANG 
Where	MaKH NOT IN (Select	    A.MaKH
						From	DATBAO A,BAO_TCHI b
						Where	A.MaBaoTC = B.MaBaoTC and B.MaBaoTC =N'TN01')
--6)
select TenKH,sum(SLmua)as soluongmua
from KHACHHANG a, DATBAO b
where a.MaKH=b.MaKH
group by TenKH
--7)
select NgayDM, count(b.MaKH) as soKhachHang
from KHACHHANG a,DATBAO b
where a.MaKH=b.MaKH and year(NgayDM)=2004
group by NgayDM
--8)
select TenKh,Ten,DinhKy,SLMua,(DatBao.SLMua*BAO_TCHI.GiaBan)as SoTien
from KHACHHANG,BAO_TCHI,DATBAO
where KHACHHANG.MaKH = DATBAO.MaKH and BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC
order by TenKH
--9)
select Ten,DinhKy,Sum(SlMua)as SoluongMua
from BAO_TCHI A,DATBAO B
where A.MaBaoTC=B.MaBaoTC
group by Ten,DinhKy
--10)
select * from BAO_TCHI A
where A.MaBaoTC like '%HS'
--11)
select	*
From	BAO_TCHI 
Where	MaBaoTC NOT IN (Select	    A.MaBaoTC
						From	DATBAO A,KHACHHANG b
						Where	A.MaKH = B.MaKH)

--12)
select Ten,DinhKy
from BAO_TCHI,DATBAO
Where	BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC  and
		DATBAO.SLMua = (Select Max(F.SLMua)
						From	BAO_TCHI E, DATBAO F
						Where	BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC )
--13)
select DISTINCT TenKH, DiaChi
from KHACHHANG,DATBAO
where KHACHHANG.MaKH=DATBAO.MaKH and DATBAO.SLMua = (Select Max(F.SLMua)
						From	KHACHHANG E, DATBAO F
						Where	E.MaKH=F.MaKH )
--14)
select MaBaoTC,GiaBan
from BAO_TCHI
where BAO_TCHI.DinhKy = N'Bán Nguyệt San'
--15)
Select	 a.MaBaoTC,ten, COUNT( c.MaKH) As SanPham
From	BAO_TCHI A, DATBAO C
Where	A.MaBaoTC = C.MaBaoTC
Group by	A.MaBaoTC, Ten
Having	COUNT( DISTINCT MaKH) >= 3

--Aa
create function fn_TongTienMua(@MaKh char(5)) returns int
As
Begin
	declare @TongTienMua int
	if exists (select * from KHACHHANG where MaKH = @MaKh) 
		Begin

		select @TongTienMua = sum(SLMua * GiaBan)
		from	BAO_TCHI A, DATBAO B	
		where	A.MaBaoTC = B.MaBaoTC and B.MaKH = @MaKh
		End	
	 	
return @TongTienMua
End
--- thử nghiệm hàm-------
print dbo.fn_TongTienMua('KH01')

--Ab
create function fn_TongTienThu(@MaBaoTapChi char(5)) returns int
As
Begin
	declare @TongTienThu int
	if exists (select * from BAO_TCHI where MaBaoTC = @MaBaoTapChi) 
		Begin
		
		select @TongTienThu = sum(SLMua * GiaBan)
		from	BAO_TCHI A, DATBAO B	
		where	A.MaBaoTC = B.MaBaoTC and A.MaBaoTC = @MaBaoTapChi
		End	
	 	
return @TongTienThu
End
--- thử nghiệm hàm-------
print dbo.fn_TongTienThu('TT01')
