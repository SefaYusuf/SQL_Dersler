-- SUBQUERIES
SELECT * FROM calisanlar2;
SELECT * FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT marka_isim,calisan_sayisi,(SELECT SUM(maas) FROM calisanlar2 WHERE marka_isim=isyeri) AS calisanlar_maas_ort
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
-- maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,(SELECT MAX(maas) FROM calisanlar2 WHERE marka_isim=isyeri) AS en_yuksek_maas,
(SELECT MIN(maas) FROM calisanlar2 WHERE marka_isim=isyeri) AS en_dusuk_maas
FROM markalar;


-- EXISTS Condition
CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');


CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart;
SELECT * FROM nisan;

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
--URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.

SELECT urun_id,musteri_isim FROM mart 
WHERE EXISTS(SELECT urun_id FROM nisan WHERE nisan.urun_id=mart.urun_id);


--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız
SELECT urun_isim,musteri_isim FROM nisan
WHERE EXISTS(SELECT urun_isim FROM mart WHERE nisan.urun_isim=mart.urun_isim);


--Her iki ayda birden satılmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız
SELECT urun_isim,musteri_isim FROM nisan
WHERE NOT EXISTS(SELECT urun_isim FROM mart WHERE nisan.urun_isim=mart.urun_isim);


-- UPDATE
CREATE TABLE tedarikciler4 -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler4 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler4 VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler4 VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler4 VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler2 -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler4(vergi_no)
on delete cascade
);

INSERT INTO urunler2 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler2 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler2 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler2 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler2 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler2 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler2 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');


SELECT * FROM tedarikciler4;
SELECT * FROM urunler2;


-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler4
SET firma_ismi='Vestel' WHERE vergi_no=102;


-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler4
SET firma_ismi='Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101;


-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler2
SET urun_isim='Telefon' WHERE urun_id=1002 or urun_id=1004 or urun_id=1007;
UPDATE urunler2
SET urun_isim='Telefon' WHERE urun_isim='Phone';


-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler2
SET urun_id = urun_id + 1 WHERE urun_id > 1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler2
SET urun_id = urun_id + ted_vergino;

-- urunler tablosundaki tum urun isimlerini, musteri isimleri ile birlestirerek update edelim
UPDATE urunler4
SET urun_isim = CONCAT(urun_isim,'-',musteri_isim);
-- Tabloda iki string field'i bir biri ile birleştirmek için bu yolu kullanabiliriz
UPDATE urunler4
SET urun_isim = urun_isim || '-' || musteri_isim;

DELETE FROM tedarikciler4;
DELETE FROM urunler2;

SELECT * FROM tedarikciler4;
SELECT * FROM urunler2;

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
UPDATE urunler2
SET urun_isim = (SELECT firma_ismi FROM tedarikciler4 WHERE irtibat_ismi = 'Adam Eve') --> Apple
WHERE musteri_isim = 'Ali Bak';


--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
UPDATE urunler2
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler4 WHERE firma_ismi = 'Apple')
WHERE urun_isim = 'Laptop';


-- Allies
SELECT urun_id AS id, urun_isim AS isim FROM urunler2;
SELECT urun_id AS id,urun_isim ||' '|| musteri_isim AS urun_isim_musteri FROM urunler2;

-- IS NULL Condition
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50), 
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar WHERE name IS NULL;
SELECT * FROM insanlar WHERE name IS NOT NULL;



