-- LEFT JOIN

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id 

/*
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id */


-- RIGHT JOIN

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id 


-- FULL JOIN

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id 


-- SELF JOIN
CREATE TABLE personel4 (
id int,
isim varchar(20),
title varchar(60), 
yonetici_id int
);

INSERT INTO personel4 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel4 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel4 VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel4 VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel4;

-- Her personelin yanina yonetici ismini yazdiran bit tablo olusturun
SELECT p1.isim AS personel_isim, p2.isim AS yonetici_isim 
FROM personel4 p1 INNER JOIN personel4 p2
ON p1.yonetici_id = p2.id;


-- LIKE Condition
CREATE TABLE musteriler2 (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);

INSERT INTO musteriler2 (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1002, 'Ayse', 57500); 
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1004, 'Fatma', 42000); 
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1006, 'Alper', 45000);

---- % Sembolu ----

--SORU	: Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE 'A%';

SELECT * FROM musteriler2  -- Buyuk Kucuk harf farki gozetmek istemezsek -ILIKE-
WHERE isim ILIKE 'a%';

-- LIKE kullanimi ikinci yol
SELECT * FROM musteriler2
WHERE isim ~~ 'A%';

SELECT * FROM musteriler2   -- Buyuk Kucuk harf farki gozetmek istemezsek -~~*-
WHERE isim ~~* 'a%';

-- Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim, gelir FROM musteriler2
WHERE isim LIKE '%e';

-- Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim, gelir FROM musteriler2
WHERE isim LIKE '%er%';


---- _  Sembolu ----

--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE '_atma';

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE '_a%';

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE '__s%';

-- Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE '__s_';

-- Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE 'F___%';

-- Ikinci harfi a,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2
WHERE isim LIKE '_a_m%';


---- ~ Sembolu ---- REGEXP_LIKE

CREATE TABLE kelimeler (
id int UNIQUE,
kelime varchar(50) NOT NULL, 
Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

-- Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime ~ 'h[ai]t';

-- Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin  tum bilgilerini  yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime ~ 'h[a-k]t';

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime ~ '[mi]';

-- a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime ~ '^[as]';  -- Baslangic belirtmek icin ^ sembolu kullanilir

-- m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime ~ '[mf]$';  -- Bitis belirtmek icin $ sembolu kullanilir


-- NOT LIKE Condition

-- ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime NOT LIKE 'h%';

-- a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime !~~ '%a%';   -- !~~ (NOT LIKE) yerine kullanilabilir  

-- ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime NOT LIKE '_de%';

-- 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler
WHERE kelime !~ '[_eio]';


-- UPPER-LOWER-INITCAP

SELECT UPPER(kelime) FROM kelimeler;  -- Belirtilen field'taki verileri buyuk harfe cevirir
SELECT LOWER(kelime) FROM kelimeler;  -- Belirtilen field'taki verileri kucuk harfe cevirir
SELECT INITCAP(kelime) FROM kelimeler; -- Belirtilen field'taki verilerin ilk harfini buyuk harfe cevirir


-- DISTINCT Kullanimi

CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun;
SELECT DISTINCT urun_isim FROM musteri_urun;  -- Urun isimlerini teke indirerek yazdirir
SELECT DISTINCT musteri_isim FROM musteri_urun;  -- Musteri isimlerini teke indirerek yazdirir
SELECT COUNT(DISTINCT musteri_isim) AS musteri_sayisi FROM musteri_urun;  -- Kac farkli musteri vardir
SELECT COUNT(DISTINCT urun_isim) AS meyve_sayisi FROM musteri_urun;  -- Kac farkli meyve vardir

