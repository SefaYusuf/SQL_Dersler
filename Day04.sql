CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

SELECT * FROM insanlar;

-- insanlar tablosundaki datalari adrese gore siralayiniz
SELECT * FROM insanlar
ORDER BY adres;

-- Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT * FROM insanlar 
WHERE isim = 'Mine'
ORDER BY ssn;

-- Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
SELECT * FROM insanlar 
WHERE soyisim = 'Bulut'
ORDER BY isim;

/*
NOT:Ascending (ASC) doğal sıralam küçükten büyüğe, yazılmasada defauld olarak natural sıralama yapar
    Descending (DESC) Büyükten küçüğe
*/

-- Insanlar tablosundaki tum kayitlari ssn nolu buyukten kucuge sirali olarak listeleyin
SELECT * FROM insanlar
ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar
ORDER BY isim ASC,soyisim DESC;

-- İsim ve soyisim değerlerini isim kelime uzunluklarına göre sıralayınız
SELECT isim,soyisim FROM insanlar
ORDER BY LENGTH (isim);

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT CONCAT (isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH(isim)+LENGTH(soyisim)

-- GROUP BY Condition
CREATE TABLE manav
(
isim varchar(50), 
Urun_adi varchar(50), 
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav;

-- Isme gore alinan toplam urunleri bulun
SELECT isim, SUM(Urun_miktar) FROM manav
GROUP BY isim
ORDER BY isim;

-- Urun ismine gore urunu alan toplam kisi sayisi
SELECT Urun_adi, COUNT(isim) FROM manav
GROUP BY Urun_adi;

-- Alinan kilo miktarina gore musteri sayisi
SELECT Urun_miktar, COUNT(isim) FROM manav
GROUP BY Urun_miktar;


CREATE TABLE personel2
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO personel2 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel2 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel2 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel2 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel2 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel2 VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel2 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel2;

-- Isme gore toplam maaslari bulun
SELECT isim, SUM(maas) AS toplam_maas FROM personel2 
GROUP BY isim;

-- Sehre gore toplam personel sayisini bulun
SELECT sehir,COUNT(isim) AS calisan_sayisi FROM personel2
GROUP BY sehir;

-- Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulunuz
SELECT sirket,COUNT(*) AS calisan_sayisi FROM personel2
WHERE maas>5000
GROUP BY sirket;

-- Her sirket icin Min ve Max maasi bulun
SELECT sirket,MIN(maas) AS en_az,MAX(maas) AS en_fazla FROM personel2
GROUP BY sirket;




-- HAVING CLAUSE
-- Having, AGGREGATE Function'larla birlikte kullanilan FILTRELEME komutudur

-- Her sirketin MIN maaslarini eger 3500’den buyukse goster
SELECT sirket,MIN(maas) AS en_az FROM personel2
GROUP BY sirket
HAVING MIN(maas)>3500;

-- )Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz
SELECT isim, SUM(maas) AS toplam_maas FROM personel2
GROUP BY isim
HAVING SUM(maas)>10000;


SELECT sehir, COUNT(isim) AS personel_sayisi FROM personel2
GROUP BY sehir
HAVING COUNT(isim)>1;
