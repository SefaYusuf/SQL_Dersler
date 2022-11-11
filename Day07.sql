-- FETCH NEXT (sayi) ROW ONLY - OFFSET Kullanimi

-- Sirali tablodan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;

-- Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
SELECT * FROM musteri_urun
ORDER BY urun_id
OFFSET 3 ROW        -- Ilk 3 satiri atla
FETCH NEXT 4 ROW ONLY;


-- ALTER TABLE STATEMENT
-- Tablodaki yapisal degisikliklerdir,Sutun ekleme,tablo ismi degistirme,veri tipini degistirme
CREATE TABLE personel5 (
id int,
isim varchar(50), 
sehir varchar(50), 
maas int,
sirket varchar(20),
CONSTRAINT personel5_pk PRIMARY KEY (id)
);

INSERT INTO personel5 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel5 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel5 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel5 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel5 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel5 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel5 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

DROP TABLE IF EXISTS personel5;  -- Tablo varsa eger siler
SELECT * FROM personel5;

-- ADD ile Default deger ile tabloya bir field ekleme
ALTER TABLE personel5
ADD ulke_ismi Varchar(20) DEFAULT 'Turkiye'

-- Tabloya birden fazla field ekleme
ALTER TABLE personel5
ADD gender char(1),ADD okul Varchar(10);

-- DROP tablodan sutun silme
ALTER TABLE personel5
DROP COLUMN okul;

-- RENAME COLUMN sutun adi degistirme
ALTER TABLE personel5
RENAME COLUMN ulke_ismi TO ulke_adi;

-- RENAME tablonun ismini degistirme
ALTER TABLE personel5
RENAME TO isciler;

SELECT * FROM isciler;

-- TYPE/SET sutunlarin ozellilerini degistirme
ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE Varchar(30);

ALTER TABLE isciler
ALTER COLUMN sirket SET NOT NULL;

-- String bir data tipini int yapma 
ALTER TABLE isciler
ALTER COLUMN field_name
TYPE int USING(field_name::int);

ALTER TABLE isciler
ALTER COLUMN gender   -- String deger varsa hata verir
TYPE int USING(gender::int);


-- TRANSACTION (Begin - Savepoint _ Rollback _ Commit)

CREATE TABLE ogrenciler2
(
id serial,  -- AUTO_INCREMENT
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to y;
COMMIT;

-- SERIAL DATA TURU Kullanimi
INSERT INTO ogrenciler2 (isim,veli_isim,yazili_notu) VALUES('Yusuf', 'Can',96.5);
INSERT INTO ogrenciler2 (isim,veli_isim,yazili_notu) VALUES('Sefa', 'Ali', 85.6);

SELECT * FROM ogrenciler2;
DELETE FROM ogrenciler2;
DROP TABLE ogrenciler2;

