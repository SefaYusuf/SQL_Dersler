CREATE TABLE personel5 (
id int,
isim varchar(50), 
sehir varchar(50), 
maas int,
sirket varchar(20)
);

INSERT INTO personel5 VALUES(123456789, 'Johnny Walk', 'New Hampshire', 2500, 'IBM');
INSERT INTO personel5 VALUES(234567891, 'Brian Pitt', 'Florida', 1500, 'LINUX');
INSERT INTO personel5 VALUES(245678901, 'Eddie Murphy', 'Texas', 3000, 'WELLS FARGO');
INSERT INTO personel5 VALUES(456789012, 'Teddy Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO personel5 VALUES(567890124, 'Eddie Murphy', 'Massachuset', 7000, 'MICROSOFT'); 
INSERT INTO personel5 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'TD BANK');
INSERT INTO personel5 VALUES(123456719, 'Adem Stone', 'New Jersey', 2500, 'IBM');

CREATE TABLE isciler2
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO isciler2 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO isciler2 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO isciler2 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO isciler2 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO isciler2 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO isciler2 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO isciler2 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

-- Her iki tablodaki ortak id’leri ve personel tablosunda bu id’ye sahip isimleri listeleyen query yaziniz
SELECT id,isim FROM personel5
WHERE id IN(SELECT id FROM isciler2 WHERE isciler2.id=personel5.id)

-- Her iki tablodaki ortak id ve isme sahip verileri aliniz
SELECT id,isim FROM personel5
INTERSECT
SELECT id,isim FROM isciler2;

-- Personel tablosunda id'si cift sayi olan personelin bilgilerini getiriniz
SELECT * FROM personel5 WHERE MOD(id,2) = 0;

-- Isciler tablosundaki en yuksek maasi alan kisinin tum bilgilarini getiriniz
SELECT * FROM isciler2
ORDER BY maas DESC
FETCH NEXT 1 ROW ONLY;

-- Isciler tablosundaki en dusuk maasi alan kisinin tum bilgilarini getiriniz
SELECT * FROM isciler2
ORDER BY maas 
FETCH NEXT 1 ROW ONLY;

-- Isciler tablosundaki ikinci en yuksek maasi alan kisinin tum bilgilarini getiriniz
SELECT * FROM isciler2
ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;


