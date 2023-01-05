
/*======================== SET OPERATORLERI: UNION, UNION ALL==========================
     

    UNION: İKİ VEYA DAHA FAZLA SORGU İFADESİNİN SONUC KUMELERİNİ BİRLEŞTİREREK 

	     TEK BİR SONUC KUMESİ OLUSTURUR.
   
    	   UNION:        SADECE BENZERSİZ VERİLERİ ALIR 

         UNION ALL:     BENZERLİ VERİLERİ DE ALIR
    



    Syntax:
    ----------
    SELECT sutun_adi FROM tablo_adi;
    UNION
    SELECT sutun_adi FROM tablo_adi;
    
   



 NOT:  Birlesik olan Sorgu ifadesinin veri türü diger sorgulardaki 
    ifadelerin veri türü ile uyumlu olmalidir.

======================================================================================*/ 

CREATE TABLE personel 
(
	id int  PRIMARY KEY, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	sirket VARCHAR(20)
);
   
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'Istanbul', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
select * from personel;


/* -----------------------------------------------------------------------------
  SORU1: maas'i 4000’den cok olan personel isim'lerini ve  
--maas'i 5000’den cok olan sehir'leri gosteren tekrarsız sorguyu yaziniz
------------------------------------------------------------------------------*/

select isim as isim_sehir,maas from personel where maas>4000
union
select sehir,maas from personel where maas>5000


/* -----------------------------------------------------------------------------
  SORU2: isim'i 'Mehmet Ozturk' olan kisilerin aldigi maas'lari  ve  
--sehir'i 'Istabul' olan personelin maas'larini tekrarsız
--büyükten küçüge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.    
------------------------------------------------------------------------------*/  

select maas,isim from personel where isim='Mehmet Ozturk'
union
select maas, sehir from personel where sehir='Istanbul'
order by maas desc;


/* -----------------------------------------------------------------------------
SORU3: sirket'i 'Honda','Ford've'Tofas' olan personelin isim'ini tekrarsız listeleyin
------------------------------------------------------------------------------*/  

select isim,sirket from personel where sirket='Honda'
union
select isim,sirket from personel where sirket='Ford'
union
select isim,sirket from personel where sirket='Tofas'


/* -----------------------------------------------------------------------------
  SORU4: 5000’den az maas alan personelin isim, maas ve sirket bilgisi ile, 
-- 'Honda' calisani olmayan personelin isim, maas, sirket bilgisini
-- tekrarsız listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 

select isim,maas,sirket from personel where maas<5000
union
select isim,maas,sirket from personel where sirket!='Honda'

/* -----------------------------------------------------------------------------
  SORU5: isim'i 'Mehmet Ozturk' olanlarin isim'lerini, sehir'lerini ve
-- sehir'i 'Istanbul' olmayanların isim'lerini sehir'lerini tekrarsız listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/

select isim,sehir from personel where isim='Mehmet Ozturk'
union
select isim,sehir from personel where sehir!='Istanbul'






CREATE TABLE personel_bilgi 
(
	id int, 
	tel char(10) UNIQUE , 
	cocuk_sayisi int
); 
   
INSERT INTO personel_bilgi VALUES(123, '5302345678' , 5);
INSERT INTO personel_bilgi VALUES(234, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345, '5354561245', 3); 
INSERT INTO personel_bilgi VALUES(478, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(789, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(344, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(125, '5537488585', 1);

select * from personel_bilgi;



/* -----------------------------------------------------------------------------
  SORU6: id’si 123456789 olan personelin, personel tablosundan sehir ve maas'ini, 
--personel_bilgi tablosundan da id’si 123 olan, personelin tel ve cocuk sayisini tekrarsız listeleyin  
------------------------------------------------------------------------------*/   

select sehir as sehir_tel,maas as maas_cocuksayisi,id from personel where id='123456789'
union
select tel,cocuk_sayisi,id from personel_bilgi where id='123'



create table arabalar
(
id int,
marka varchar(20),
model varchar(20),
vites varchar(20),
fiyat int
);


insert into arabalar values(1,'Mercedes','C180','Otomatik',900000);
insert into arabalar values(2,'Toyota','Corolla','Otomatik',400000);
insert into arabalar values(3,'Honda','Civic','Otomatik',500000);
insert into arabalar values(4,'Citroen','C3','Manuel',450000);

select * from arabalar;


--SORU1: arabalar tablosuna kilometre varchar(10) , yas int seklinde yeni sutunlar ekleyiniz

Alter table arabalar add column kilometre varchar(10), add column yas int ;


select * from arabalar;
--SORU2: arabalar tablosuna airbag varchar(10) seklinde yeni sutun ekleyiniz default degeri 'var' olsun

Alter table arabalar add column airbag varchar(10) default 'var';


--SORU3: arabalar tablosundan vites sutununu siliniz

Alter table arabalar drop column vites;

select * from arabalar
--SORU4: arabalar tablosundaki fiyat sutununun ismini bedel olarak güncelleyiniz


Alter table arabalar rename column fiyat to bedel;

--SORU5: arabalar tablosunun ismini galeri olarak güncelleyiniz

Alter table arabalar rename to galeri;


--SORU6: galeri tablosunun ismini arabalar olarak güncelleyiniz

Alter table galeri rename to arabalar;

--1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir.
  --2) LEFT JOIN:  ilk tabloda olan tum sonuclari gosterir
  --3) RIGHT JOIN:  ikinci tabloda olan tum sonuclari gosterir
  --4) FULL JOIN: (left join + union  + right join) Tablodaki tum sonuclari gosterir



create table filmler
(film_id int,
film_name varchar(30),
category varchar(30)
);

insert into filmler values (1, 'Eyvah Eyvah', 'Komedi');
insert into filmler values (2, 'Kurtlar Vadisi', 'Aksiyon');
insert into filmler values (3, 'Eltilerin Savasi', 'Komedi');
insert into filmler values (4, 'Aile Arasinda', 'Komedi');
insert into filmler values (5, 'GORA', 'Bilim Kurgu');
insert into filmler values (6, 'Organize Isler', 'Komedi');
insert into filmler values (7, 'Babam ve Oglum', 'Dram');


create table aktorler
(id int,
actor_name varchar(30),
film_id int
);

insert into aktorler values (101, 'Ata Demirer', 1);
insert into aktorler values (201, 'Necati Sasmaz', 2);
insert into aktorler values (301, 'Gupse Ozay', 3);
insert into aktorler values (401, 'Engin Gunaydin', 4);
insert into aktorler values (501, 'Cem Yilmaz', 5);

select * from filmler;

-- SORU1: Tüm film_name'leri, category'lerini ve filmlerde oynayan actor_name'leri listeleyiniz.


select film_name,category, actor_name from filmler as A 
left join aktorler as B 
on A.film_id=B.film_id;



select film_name,category, actor_name from aktorler as B 
right join filmler as A 
on A.film_id=B.film_id;

select * from filmler;
-- SORU2: Tüm actor_name'leri ve film_name'lerini listeleyiniz.


select actor_name, film_name from aktorler as A
left join filmler as B
on A.film_id=B.film_id;


select actor_name, film_name from filmler as B
right join aktorler as A
on A.film_id=B.film_id;


create table qa_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

insert into qa_dersler values (101, 'Core Java', 40);
insert into qa_dersler values (102, 'Selenium', 30);
insert into qa_dersler values (103, 'API', 15);
insert into qa_dersler values (104, 'SQL', 10);
insert into qa_dersler values (105, 'SDLC', 10);
insert into qa_dersler values (106, 'LAMDA', 12);




create table developer_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

insert into developer_dersler values (101, 'Core Java', 40);
insert into developer_dersler values (103, 'API', 15);
insert into developer_dersler values (104, 'SQL', 10);
insert into developer_dersler values (105, 'SDLC', 10);
insert into developer_dersler values (106, 'LAMDA', 12);
insert into developer_dersler values (107, 'Spring Framework', 20);
insert into developer_dersler values (108, 'Micro Services', 12);

select * from qa_dersler;


--SORU1: join kullanarak ortak dersleri sorgulayınız 

select A.ders_id,A.ders_ismi,A.ders_saati from qa_dersler as A
inner join developer_dersler as B
on A.ders_id=B.ders_id;


select * from qa_dersler;


--SORU2: join kullanarak qa_dersler'ini sorgula

select A.ders_id,A.ders_ismi,A.ders_saati from developer_dersler as B
right join qa_dersler as A
on A.ders_id=B.ders_id;



select A.ders_id,A.ders_ismi,A.ders_saati from qa_dersler as A
left join developer_dersler as B
on A.ders_id=B.ders_id;




