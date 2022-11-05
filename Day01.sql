--CREATE-- tablo olusturma
CREATE TABLE ogrenciler
(
id char(4),
isim_soyisim varchar(50),
not_ort real,
kayit_tarih date	
);

--Varolan bir tablodan yeni bit tablo olusturma
CREATE TABLE ogrenci_ortalama
AS
SELECT isim_soyisim,not_ort
FROM ogrenciler;

--Select - DQL -
SELECT * FROM ogrenciler; -- Bir tablodaki butun verileri cagirmak istersek * karakterini kullaniriz 
SELECT * FROM ogrenci_ortalama;
SELECT isim_soyisim,kayit_tarih FROM ogrenciler; -- Bir tablodan bir veya birden fazla field'i cagirmak icin bu sekilde kullaniriz 

