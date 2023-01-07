
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

SELECT isim as isim_sehir,maas FROM personel WHERE maas>4000
UNION
SELECT sehir,maas FROM personel WHERE maas>5000;


/* -----------------------------------------------------------------------------
  SORU2: isim'i 'Mehmet Ozturk' olan kisilerin aldigi maas'lari  ve  
--sehir'i 'Istabul' olan personelin maas'larini tekrarsız
--büyükten küçüge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.    
------------------------------------------------------------------------------*/  

SELECT maas,isim FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT maas, sehir FROM personel WHERE sehir='Istanbul'
ORDER BY maas DESC;


/* -----------------------------------------------------------------------------
SORU3: sirket'i 'Honda','Ford've'Tofas' olan personelin isim'ini tekrarsız listeleyin
------------------------------------------------------------------------------*/  

SELECT isim,sirket FROM personel WHERE sirket='Honda'
UNION
SELECT isim,sirket FROM personel WHERE sirket='Ford'
UNION
SELECT isim,sirket FROM personel WHERE sirket='Tofas';


/* -----------------------------------------------------------------------------
  SORU4: 5000’den az maas alan personelin isim, maas ve sirket bilgisi ile, 
-- 'Honda' calisani olmayan personelin isim, maas, sirket bilgisini
-- tekrarsız listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 

SELECT isim,maas,sirket FROM personel WHERE maas<5000
UNION
SELECT isim,maas,sirket FROM personel WHERE sirket!='Honda';

/* -----------------------------------------------------------------------------
  SORU5: isim'i 'Mehmet Ozturk' olanlarin isim'lerini, sehir'lerini ve
-- sehir'i 'Istanbul' olmayanların isim'lerini sehir'lerini tekrarsız listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/

SELECT isim,sehir FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT isim,sehir FROM personel WHERE sehir!='Istanbul';






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

SELECT * FROM personel_bilgi;



/* -----------------------------------------------------------------------------
  SORU6: id’si 123456789 olan personelin, personel tablosundan sehir ve maas'ini, 
--personel_bilgi tablosundan da id’si 123 olan, personelin tel ve cocuk sayisini tekrarsız listeleyin  
------------------------------------------------------------------------------*/   

SELECT sehir as sehir_tel,maas as maas_cocuksayisi,id FROM personel WHERE id='123456789'
UNION
SELECT tel,cocuk_sayisi,id FROM personel_bilgi WHERE id='123';



create table arabalar
(
id int,
marka varchar(20),
model varchar(20),
vites varchar(20),
fiyat int
);


INSERT INTO arabalar VALUES(1,'Mercedes','C180','Otomatik',900000);
INSERT INTO arabalar VALUES(2,'Toyota','Corolla','Otomatik',400000);
INSERT INTO arabalar VALUES(3,'Honda','Civic','Otomatik',500000);
INSERT INTO arabalar VALUES(4,'Citroen','C3','Manuel',450000);

SELECT * FROM arabalar;


--SORU1: arabalar tablosuna kilometre varchar(10) , yas int seklinde yeni sutunlar ekleyiniz

ALTER TABLE arabalar ADD COLUMN kilometre varchar(10), ADD COLUMN yas int ;


SELECT * FROM arabalar;
--SORU2: arabalar tablosuna airbag varchar(10) seklinde yeni sutun ekleyiniz default degeri 'var' olsun

ALTER TABLE arabalar ADD COLUMN airbag varchar(10) DEFAULT 'var';


--SORU3: arabalar tablosundan vites sutununu siliniz

ALTER TABLE arabalar DROP COLUMN vites;

SELECT * FROM arabalar;
--SORU4: arabalar tablosundaki fiyat sutununun ismini bedel olarak güncelleyiniz


ALTER TABLE arabalar RENAME COLUMN fiyat TO bedel;

--SORU5: arabalar tablosunun ismini galeri olarak güncelleyiniz

ALTER TABLE arabalar RENAME to galeri;


--SORU6: galeri tablosunun ismini arabalar olarak güncelleyiniz

ALTER TABLE galeri RENAME TO arabalar;

--1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir.
--2) LEFT JOIN:  ilk tabloda olan tum sonuclari gosterir
--3) RIGHT JOIN:  ikinci tabloda olan tum sonuclari gosterir
--4) FULL JOIN: (left join + union  + right join) Tablodaki tum sonuclari gosterir



CREATE TABLE filmler
(film_id int,
film_name varchar(30),
category varchar(30)
);

INSERT INTO filmler VALUES (1, 'Eyvah Eyvah', 'Komedi');
INSERT INTO filmler VALUES (2, 'Kurtlar Vadisi', 'Aksiyon');
INSERT INTO filmler VALUES (3, 'Eltilerin Savasi', 'Komedi');
INSERT INTO filmler VALUES (4, 'Aile Arasinda', 'Komedi');
INSERT INTO filmler VALUES (5, 'GORA', 'Bilim Kurgu');
INSERT INTO filmler VALUES (6, 'Organize Isler', 'Komedi');
INSERT INTO filmler VALUES (7, 'Babam ve Oglum', 'Dram');


create table aktorler
(id int,
actor_name varchar(30),
film_id int
);

INSERT INTO aktorler VALUES (101, 'Ata Demirer', 1);
INSERT INTO aktorler VALUES (201, 'Necati Sasmaz', 2);
INSERT INTO aktorler VALUES (301, 'Gupse Ozay', 3);
INSERT INTO aktorler VALUES (401, 'Engin Gunaydin', 4);
INSERT INTO aktorler VALUES (501, 'Cem Yilmaz', 5);

SELECT * FROM filmler;
SELECT * FROM aktorler;


-- SORU1: Tüm film_name'leri, category'lerini ve filmlerde oynayan actor_name'leri listeleyiniz.

SELECT film_name,category, actor_name FROM filmler as A 
LEFT JOIN aktorler as B 
ON A.film_id=B.film_id;

SELECT film_name,category, actor_name FROM aktorler as B 
RIGHT JOIN filmler as A 
ON A.film_id=B.film_id;

SELECT * FROM filmler;


-- SORU2: Tüm actor_name'leri ve film_name'lerini listeleyiniz.

SELECT actor_name, film_name FROM aktorler as A
LEFT JOIN filmler as B
ON A.film_id=B.film_id;


SELECT actor_name, film_name FROM filmler as B
RIGHT JOIN aktorler as A
ON A.film_id=B.film_id;


create table qa_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

INSERT INTO qa_dersler VALUES (101, 'Core Java', 40);
INSERT INTO qa_dersler VALUES (102, 'Selenium', 30);
INSERT INTO qa_dersler VALUES (103, 'API', 15);
INSERT INTO qa_dersler VALUES (104, 'SQL', 10);
INSERT INTO qa_dersler VALUES (105, 'SDLC', 10);
INSERT INTO qa_dersler VALUES (106, 'LAMDA', 12);




create table developer_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

INSERT INTO developer_dersler VALUES (101, 'Core Java', 40);
INSERT INTO developer_dersler VALUES (103, 'API', 15);
INSERT INTO developer_dersler VALUES (104, 'SQL', 10);
INSERT INTO developer_dersler VALUES (105, 'SDLC', 10);
INSERT INTO developer_dersler VALUES (106, 'LAMDA', 12);
INSERT INTO developer_dersler VALUES (107, 'Spring Framework', 20);
INSERT INTO developer_dersler VALUES (108, 'Micro Services', 12);

SELECT * FROM qa_dersler;
SELECT * FROM developer_dersler;

--SORU1: join kullanarak ortak dersleri sorgulayınız 

SELECT A.ders_id,A.ders_ismi,A.ders_saati FROM qa_dersler as A
INNER JOIN developer_dersler as B
ON A.ders_id=B.ders_id;


SELECT * FROM qa_dersler;


--SORU2: join kullanarak qa_dersler'ini sorgula

SELECT A.ders_id,A.ders_ismi,A.ders_saati FROM developer_dersler as B
RIGHT JOIN qa_dersler as A
ON A.ders_id=B.ders_id;



SELECT A.ders_id,A.ders_ismi,A.ders_saati FROM qa_dersler as A
LEFT JOIN developer_dersler as B
ON A.ders_id=B.ders_id;




