-- DML - DATA MANUPULATION LANG.
-- INSERT
SELECT * FROM ogrenciler;

-- Bir tabloya tum field'lara veri ekleme icin
INSERT INTO ogrenciler VALUES ('1234','Yusuf Sozkeser',80.50,'2020-01-05');

-- Bir tabloya parali veri eklemek icin
INSERT INTO ogrenciler (id,isim_soyisim) VALUES ('2345','Yusuf Un');

/*
Practice1:
“tedarikciler” isminde bir tablo olusturun ve “tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres”
ve “ulasim_tarihi”	field’lari olsun.

“tedarikçi_ziyaret” isminde bir tabloyu  “tedarikciler” tablosundan olusturun.
Icinde “tedarikci_ismi”, “ulasim_tarihi” field’lari olsun.
*/
CREATE TABLE tedarikciler2
(
tedarikci_id int UNIQUE,
tedarikci_ismi varchar(20) NOT NULL,
tedarikci_adres varchar(30),
ulasim_tarihi date
);

CREATE TABLE tedarikçi_ziyaret
AS
SELECT tedarikci_ismi,ulasim_tarihi FROM tedarikciler;

SELECT * FROM tedarikciler;
SELECT * FROM tedarikçi_ziyaret;


CREATE TABLE personel
(
id char(10),
isim varchar(50) NOT NULL,
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int
);

INSERT INTO personel (id,soyisim,isim) VALUES (123456789,'isci','Erol');
SELECT * FROM personel;

-- Primary Key oluşturma 1. yol
CREATE TABLE ogrenciler4
(
id char(4) PRIMARY KEY,
isim varchar(50) NOT NULL,
not_ortalamasi real,
adres varchar(100),
kayit_tarihi date
);


-- Primary Key oluşturma 2. yol
CREATE TABLE ogrenciler5
(
id char(4),
isim varchar(50) NOT NULL,
not_ortalamasi real,
adres varchar(100),
kayit_tarihi date,
CONSTRAINT ogrenciler_pk PRIMARY KEY (id)
);

/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,  “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin

*/


CREATE TABLE tedarikciler3
(
tedarikci_id char(5) ,
tedarikci_ismi varchar(30),
iletisim_isim varchar(30),
CONSTRAINT tdrkpk PRIMARY KEY (tedarikci_id)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(10),
CONSTRAINT tdrkfk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);


/*
Practice 5:
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”  field’lari olsun. 
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun.  
“adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar
(
id varchar(9) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler
(
adres_id char(10),
sokak varchar(10),	
cadde varchar(10),	
sehir varchar(10),
CONSTRAINT adrsfk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --UNIQUE oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');  -- NOT NULL oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- NOT NULL oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --UNIQUE oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY oldugu icin kabul etmedi

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');



SELECT * FROM calisanlar;
SELECT * FROM adresler;

-- CHECK Constraint Kullanımı
CREATE TABLE sehirler2
(
alan_kodu int PRIMARY KEY,
isim varchar(20) NOT NULL,
nufus int CHECK (nufus>0)
);
INSERT INTO sehirler2 VALUES (123,'erol',-50);
SELECT * from sehirler2;


-- WHERE Kullanimi
/*
Calisanlar Tablosundan sadece maas’ı 5000 den buyuk
olanlarin isim field’indaki datalari getirir
*/
SELECT * FROM calisanlar;
SELECT * FROM calisanlar WHERE maas > 5000;
SELECT isim FROM calisanlar WHERE maas > 5000;

-- id'si 10004 olan kisinin isim ve maas field'larini sorgulayalim
SELECT id,isim,maas FROM calisanlar WHERE id='10004';


-- DML - DELETE Kullanimi
CREATE TABLE ogrenciler6
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler6;

-- id'si 124 olan ogrenciyi siliniz 
DELETE FROM ogrenciler6 WHERE id = 124;
-- ismi Kemal Yasa olan ogrenciyi siliniz 
DELETE FROM ogrenciler6 WHERE isim = 'Kemal Yasa';

-- ogrenciler5 tablosunu siliniz
DELETE FROM ogrenciler5;


-- ON DELETE CASCADE Kullanimi
CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

DELETE from notlar where talebe_id='123';-- child
-- child tablodaki veriyi sildiğimiz zaman sadece child'daki veri silinir. parent taki veri silinmez.
DELETE from talebeler where id='126';-- parent
-- parent tablodaki veriyi sildiğimiz zaman child'daki veride silinir.
DELETE FROM talebeler; -- Parent tablo ile birlikte child tablo daki verileride siler

DROP TABLE talebeler CASCADE;


--IN CONDITION
CREATE TABLE musteriler  (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

--Tablodan urun_ismi Orange,Apple,Apricot olan dataları getiriniz
Select * from musteriler WHERE urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple','Apricot');


-- Urun ismi orange olan ve musteri ismi Mark olan kaydi listeleyiniz
Select * from musteriler WHERE urun_isim='Orange' and musteri_isim = 'Mark';

-- (Not) Between Condition
-- Urun Id si 20 ile 40 arasinda olanlari birlestiriniz
SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;


-- SUBQUERIES (Alt Sorgu)
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);


-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada 
-- calisanlarin isimlerini ve maaşlarini listeleyin.

SELECT isim,maas,isyeri FROM calisanlar2 WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
SELECT marka_id, calisan_sayisi FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar2 WHERE sehir = 'Ankara'); 

-- marka_id'si 101'den buyuk olan marka calisanlarinin isim,maas ve sehirlerini listeleyiniz
SELECT isim,maas,sehir FROM calisanlar2 WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id>101);

-- Aggregate Function
SELECT sum(maas) AS maas_toplam FROM calisanlar2;
SELECT max(maas) AS en_yuksek_maas FROM calisanlar2;
SELECT min(maas) AS en_dusuk_maas FROM calisanlar2;
SELECT avg(maas) AS maas_ortalamalari FROM calisanlar2;
SELECT round(avg(maas),2) AS maas_ortalamalari FROM calisanlar2;
SELECT count(maas) AS maasli_sayisi FROM calisanlar2;


-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim, (SELECT count(sehir) FROM calisanlar2 WHERE marka_isim=isyeri) AS sehir_sayisi FROM markalar; 




