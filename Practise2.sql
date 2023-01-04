--ON DELETE CASCADE SAYESİNDE PARENT TABLOYU SİLMEK İCİN VEYA PARENT TABLODAKİ VERİYİ SİLMEK İCİN 
--HER DEFASINDA CHİLD TABLOYU VEYA CHİLD TABLODAKİ VERİYİ SİLMEMİZE GEREK KALMIYOR
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutu yazmamız yeterli

CREATE TABLE parent2 
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
    
INSERT INTO parent2 VALUES (101, 'Sony', 'Kim Lee');
INSERT INTO parent2 VALUES (102, 'Asus', 'George Clooney');
INSERT INTO parent2 VALUES (103, 'Monster', 'Johnny Deep');
INSERT INTO parent2 VALUES (104, 'Apple', 'Mick Jackson');

CREATE TABLE child2
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY(ted_vergino) REFERENCES parent2(vergi_no)
ON DELETE CASCADE
);    
    
INSERT INTO child2 VALUES(101, 1001,'PC', 'Habip Sanli');
INSERT INTO child2 VALUES(102, 1002,'Kamera', 'Zehra Oz');
INSERT INTO child2 VALUES(102, 1003,'Saat', 'Mesut Kaya');
INSERT INTO child2 VALUES(102, 1004,'PC', 'Vehbi Koc');
INSERT INTO child2 VALUES(103, 1005,'Kamera', 'Cemal Sala');
INSERT INTO child2 VALUES(104, 1006,'Saat', 'Behlül Dana');
INSERT INTO child2 VALUES(104, 1007,'Kamera', 'Eymen Ozden');
    
select * from parent2;	
select * from child2;

--SORU1: parent2 tablosundaki tum verileri siliniz 
delete from parent2;

--ON DELETE CASCADE varligindan dolayi
--child tablodaki veri silinmeden Prent tablodaki veri silinmeye calisildiginda pgAdmin eror vermez.
--parent tablodaki verileri siler.
--Fakat bu durumda child tablodaki verilerde silinir.

--SORU2: parent2 tablosunu siliniz..
DROP TABLE parent2 cascade;
--ON DELETE CASCADE sayesinde child tablo silinmeden parent tablo silinebilir

--SORU3: child2 tablosunu siliniz
DROP TABLE child2;

/*

CHİLD TABLODA ON DELETE CASCADE KOMUTU YAZILMAZSA
1-) Child tablo silinmeden Parent tablo silinmeye çalışıldıgında PgAdmin Eror verir.
yani Child tablo silinmeden Parent tablo silinemez
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye çalışıldıgında Pg Admin Eror verir.
yani Child tablodaki veri silinmeden Parent tablodaki veri silinemez

CHİLD TABLODA ON DELETE CASCADE KOMUTU YAZILIRSA
1-) Child tablo silinmeden Parent tablo silinebilir.
PgAdmin Eror vermez
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye çalışıldıgında PgAdmin Eror vermez
Parent tablodaki veriyi siler.
Fakat bu durumda Child tablodaki veride silinir.

*/


CREATE TABLE toptancilar     --> parent
(
vergi_no int PRIMARY KEY,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);
    
INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen');
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203, 'Erikson', 'Mehmet Gör');
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');


CREATE TABLE malzemeler     --> child
(
ted_vergino int, 
malzeme_id int, 
malzeme_isim VARCHAR(20), 
musteri_isim VARCHAR(25),
CONSTRAINT fk FOREIGN KEY(ted_vergino) REFERENCES toptancilar(vergi_no)
on delete cascade
);    
    
INSERT INTO malzemeler VALUES(201, 1001,'Laptop', 'Aslı Can');
INSERT INTO malzemeler VALUES(202, 1002,'Telefon', 'Fatih Ak');
INSERT INTO malzemeler VALUES(202, 1003,'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES(202, 1004,'Laptop', 'Veli Tan');
INSERT INTO malzemeler VALUES(203, 1005,'Telefon', 'Cemile Al');
INSERT INTO malzemeler VALUES(204, 1006,'TV', 'Ali Can');
INSERT INTO malzemeler VALUES(204, 1007,'Telefon', 'Ahmet Yaman');
 
SELECT * FROM toptancilar; 
SELECT * FROM malzemeler;


--SORU1: vergi_no’su 202 olan toptancinin sirket_ismi'ni 'VivoBook' olarak güncelleyeniz.
UPDATE toptancilar SET sirket_ismi = 'VivoBook' WHERE vergi_no = 202;
SELECT * FROM toptancilar;

--SORU2: toptancilar tablosundaki tüm sirket_ismi'ni 'NOKIA' olarak güncelleyeniz.
UPDATE toptancilar SET sirket_ismi = 'NOKIA';
SELECT * FROM toptancilar;

--SORU3: vergi_no’su 201 olan toptancinin sirket_ismi'ni 'nokia' , 
--irtibat_ismi’ni 'Canan Can' olarak güncelleyiniz.
UPDATE toptancilar SET sirket_ismi = 'nokia', irtibat_ismi = 'Canan Can' WHERE vergi_no = 201; 
SELECT * FROM toptancilar;

--SORU4: sirket_ismi nokia olan toptancinin
--irtibat_ismi'ni 'Bilal Han' olarak güncelleyiniz.
UPDATE toptancilar SET irtibat_ismi = 'Bilal Han' WHERE sirket_ismi = 'nokia';
SELECT * FROM toptancilar;

--SORU5: malzemeler tablosundaki 'Telefon' değerlerini,
--'Phone' olarak güncelleyiniz.
UPDATE malzemeler SET malzeme_isim = 'Phone' WHERE malzeme_isim = 'Telefon';
SELECT * FROM malzemeler;

--SORU6: malzemeler tablosundaki malzeme_id değeri 1004'ten büyük olanların,
--malzeme_id'lerini 1 artırarak güncelleyiniz.
UPDATE malzemeler SET malzeme_id = malzeme_id+1 WHERE malzeme_id > 1004; 
SELECT * FROM malzemeler;

--SORU7: malzemeler tablosundaki tüm malzemelerin malzeme_id değerini 
--ted_vergino ile toplayarak güncelleyiniz.
UPDATE malzemeler SET malzeme_id = malzeme_id + ted_vergino;
SELECT * FROM malzemeler;

-- not: tabloları eski  haline donustur-----

--SORU8: Malzemeler tablosundaki musteri_isim'i 'Ali Can' olanın malzeme_isim'ini,
--toptancilar  tablosunda irtibat_ismi 'Adem Coş' olanın sirket_ismi ile güncelleyiniz.
UPDATE malzemeler SET malzeme_isim = (SELECT sirket_ismi FROM toptancilar WHERE irtibat_ismi = 'Adem Coş') 
WHERE musteri_isim = 'Ali Can';
SELECT * FROM malzemeler;

--SORU9: Malzemeler tablosundaki malzeme_isim'i 'Laptop' olanların musteri_isim'ini,
--toptancilar  tablosunda sirket_ismi 'Apple' in irtibat_ismi ile güncelleyiniz.
UPDATE malzemeler SET musteri_isim = (SELECT irtibat_ismi FROM toptancilar WHERE sirket_ismi = 'Apple') 
WHERE malzeme_isim = 'Laptop';
SELECT * FROM malzemeler;


/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
	ORDER BY sutun_adı        İNT==>KÜÇÜKTEN BÜYÜGE  STRİNG==>A-Z
	ORDER BY sutun_adı DESC   İNT==>BÜYÜKTEN KÜÇÜGE  STRİNG==>Z-A
==============================================================================*/   

CREATE TABLE meslekler
(
id int PRIMARY KEY,
isim VARCHAR(50), 
soyisim VARCHAR(50),
meslek CHAR(9),
maas int
);

INSERT INTO meslekler VALUES(1, 'Ali', 'Can', 'Doktor', '20000' );
INSERT INTO meslekler VALUES(2, 'Veli', 'Cem', 'Mühendis', '18000');
INSERT INTO meslekler VALUES(3, 'Mine', 'Bulut', 'Avukat', '17000');
INSERT INTO meslekler VALUES(4, 'Mahmut', 'Bulut', 'Ögretmen', '15000');
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13000');
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000');
INSERT INTO meslekler VALUES(7, 'Ali', 'Can', 'Marangoz', '10000' );
INSERT INTO meslekler VALUES(8, 'Veli', 'Cem', 'Tekniker', '14000');

SELECT * FROM meslekler;

--SORU1: meslekler tablosunu isim'e göre sıralayarak listeleyiniz.
SELECT * FROM meslekler ORDER BY isim;

--SORU2: meslekler tablosunda maas'i buyukten kucuge sıralayarak listeleyiniz
SELECT * FROM meslekler ORDER BY maas DESC;

--SORU3: meslekler tablosunda isim'i 'Ali' olanları,
--maas'a göre büyükten küçüge sıralayarak listeleyiniz
SELECT * FROM meslekler WHERE isim = 'Ali' ORDER BY maas DESC;

--SORU4: meslekler tablosunda soyisim 'i 'Bulut' olanları,
--maas'a gore sıralayarak listeleyiniz.
SELECT * FROM meslekler WHERE soyisim = 'Bulut' ORDER BY maas;

--SORU5: meslekler tablosunda id degeri 5 den büyük olan,
--ilk 2 veriyi listeleyiniz
SELECT * FROM meslekler WHERE id > 5 LIMIT 2;

--SORU6: meslekler tablosunda maası en yüksek 3 kişinin bilgilerini listeleyiniz
SELECT * FROM meslekler ORDER BY maas DESC LIMIT 3;

--SORU7: meslekler tablosunda ilk 2 veriden sonra 5 veriyi listeleyiniz
SELECT * FROM meslekler OFFSET 2 LIMIT 5;

--SORU8: meslekler tablosunda en yüksek maaşı alan 4. 5. 6. kişilerin bilgilerini listeleyiniz
SELECT * FROM meslekler ORDER BY maas DESC OFFSET 3 LIMIT 3;

/*============================= GROUP BY =====================================

    GROUP BY cümleciği bir SELECT ifadesinde satırları, sutunların değerlerine 
    göre özet olarak GRUPLAMAK için kullanılır. 
   
    GROUP BY cümleceği her grup başına bir satır döndürür. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonları ile birlikte kullanılır.
==============================================================================*/ 

create table sahislar
(id int primary key,
ad varchar(20),
soyad varchar(20),
yas int,
cinsiyet char,
sehir varchar(20),
ulke varchar(20),
maas int
);

insert into sahislar values(100, 'Eymen',  'Bal', '25', 'E', 'Istanbul', 'Turkiye', '20000');
insert into sahislar values(101, 'Derya', 'Soylu', '35', 'K', 'Istanbul', 'Turkiye', '25000');
insert into sahislar values(102, 'Enes', 'Boz', '55', 'E', 'Istanbul', 'Turkiye', '22000');
insert into sahislar values(103, 'Nil', 'Naz', '45', 'K', 'Trabzon', 'Turkiye', '20000');
insert into sahislar values(104, 'Ali', 'Can', '28', 'E', 'Ankara', 'Turkiye', '15000');
insert into sahislar values(105, 'Yusuf', 'Cengiz', '46', 'E', 'Bolu', 'Turkiye', '30000');
insert into sahislar values(106, 'Ahmet', 'Aslan', '38', 'E', 'Adana', 'Turkiye', '28000');
insert into sahislar values(107, 'Mehmet', 'Aslan', '29', 'E', 'Gaziantep', 'Turkiye', '21000');
insert into sahislar values(108, 'Sena', 'Yavuz', '49', 'K', 'New York', 'USA', '40000');
insert into sahislar values(109, 'Zehra', 'Amber', '52', 'K', 'New York', 'USA', '45000');
insert into sahislar values(110, 'Fatma', 'Nur', '33', 'K', 'Berlin', 'Almanya', '35000');
insert into sahislar values(111, 'Mustafa', 'Bay', '44', 'E', 'Paris', 'Fransa', '34000');
insert into sahislar values(112, 'Murat', 'Kerem', '28', 'E', 'Istanbul', 'Turkiye', '29000');
insert into sahislar values(113, 'Sinan', 'Ay', '45', 'E', 'Izmir', 'Turkiye', '19000');
insert into sahislar values(114, 'Figen', 'Bal', '55', 'K', 'Istanbul', 'Turkiye', '25000');
insert into sahislar values(115, 'Serkan', 'Bayram', '36', 'E', 'Londra', 'Ingiltere', '50000');
insert into sahislar values(116, 'Hakan', 'Bacak', '29', 'E', 'Londra', 'Ingiltere', '55000');
insert into sahislar values(117, 'Zafer', 'Yanak', '47', 'E', 'Berlin', 'Almanya', '42000');
insert into sahislar values(118, 'Birol', 'Kara', '37', 'E', 'Paris', 'Fransa', '41000');
insert into sahislar values(119, 'Ayten', 'Tan', '32', 'K', 'Roma', 'Italya', '39000');

SELECT * FROM sahislar;

--SORU01: sahislar tablosunda ulke'lere göre ortalama maas'ları listeleyiniz
SELECT ulke, round(avg(maas)) as ortalama_maas FROM sahislar GROUP BY ulke;

--SORU02: sahislar tablosunda ulke'lere göre kaç çalışan olduğunu listeleyiniz.
SELECT ulke, COUNT(ad) as calisan_sayisi from sahislar group by ulke;

--SORU03: sahislar tablosundaki cinsiyet'e göre maas ortalamasını  listeleyiniz
select cinsiyet, round(avg(maas),2) as maas_ort from sahislar group by cinsiyet;

--SORU04: sahislar tablosunda ulke'lere göre ve sehir'ler göre çalışan sayısını listeleyiniz.
select ulke,sehir,count(ad) as calisan_sayisi from sahislar group by ulke,sehir;
