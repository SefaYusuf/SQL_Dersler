--a)Yukarda verilen “personel” tablosunu olusturun
--b)Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
--c)Iscilerin tum bilgilerini listeleyin
--d)Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
--e)Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
--f)Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin

CREATE TABLE isciler3
(
id int,
isim VARCHAR(50),
soyisim VARCHAR(50),
email varchar(30),
ise_baslama_tarih date,
is_unvani varchar(15),
maas int    
);

insert into isciler3 values (123456789, 'Ali', 'Can', 'alican@gmail.com', '10-APR-10', 'isci', 5000);
insert into isciler3 values (123456788, 'Veli', 'Cem', 'velicem@gmail.com', '10-JAN-12','isci', 5500);
insert into isciler3 values (123456787, 'Ayse', 'Gul', 'aysegul@gmail.com', '01-MAY-14', 'muhasebeci', 4500);
insert into isciler3 values (123456789, 'Fatma', 'Yasa', 'fatmayasa@gmail.com', '10-APR-09', 'muhendis', 7500);

--b)Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
SELECT isim,is_unvani,maas FROM isciler3
WHERE maas<5000 OR is_unvani = 'isci';

--c)Iscilerin tum bilgilerini listeleyin
SELECT * FROM isciler3;

--d)Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
SELECT soyisim,is_unvani,maas FROM isciler3
WHERE soyisim IN ('Can','Cem','Gul')

--e)Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
SELECT isim,email,ise_baslama_tarih FROM isciler3
WHERE maas>5000;

--f)Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
SELECT * FROM isciler3
WHERE maas BETWEEN 5000 AND 7000;
