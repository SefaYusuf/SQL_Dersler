-- HAVING 
SELECT * FROM personel2;

--Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir,COUNT(isim) AS toplam_kisi FROM personel2
GROUP BY sehir
HAVING COUNT(isim)>1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir,MAX(maas) AS max_maas FROM personel2
GROUP BY sehir
HAVING MAX(maas)<5000;



-- UNION Operator

--Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
SELECT isim AS isim_sehir FROM personel2
WHERE maas>4000
UNION
SELECT sehir FROM personel2
WHERE maas<5000;

--Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
--bir tabloda gosteren sorgu yaziniz
SELECT sehir AS isim_sehir,maas FROM personel2
WHERE sehir='Istanbul'
UNION
SELECT isim,maas FROM personel2
WHERE isim='Mehmet Ozturk'
ORDER BY maas DESC;

--Sehirlerden odenen ucret 4500’den fazla olanlari ve personelden ucreti 5000’den az olanlari bir tabloda
--maas miktarina gore sirali olarak gosteren sorguyu yaziniz
SELECT sehir,maas FROM personel2
WHERE maas>4500
UNION
SELECT isim,maas FROM personel2
WHERE maas<5000
ORDER BY maas;


CREATE TABLE personel3
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel3 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel3 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel3 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel3 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel3 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel3 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel3 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


CREATE TABLE personel_bilgi (
id int,
tel char(10) UNIQUE ,
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel3(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

SELECT * FROM personel3;
SELECT * FROM personel_bilgi;

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi  
--tablosundan da tel ve cocuk sayisini yazdirin
SELECT id,sehir AS sehir_tel,maas AS maas_cocuk_sa FROM personel3
WHERE id=123456789
UNION
SELECT id,tel,cocuk_sayisi FROM personel_bilgi
WHERE id=123456789;

-- Personel tablosundada maasi 5000’den az olan tum sehirleri ve maaslari bulunuz
SELECT sehir,maas FROM personel3
WHERE maas < 5000
UNION ALL
SELECT sehir,maas FROM personel3
WHERE maas < 5000;

--1)Tabloda personel maasi 4000’den cok olan tum sehirleri ve maaslari yazdirin
--2)Tabloda personel maasi 5000’den az olan tum isimleri ve maaslari yazdirin
SELECT sehir,maas FROM personel3
WHERE maas > 4000
UNION ALL
SELECT isim,maas FROM personel3
WHERE maas <5000;



-- INTERSECT Operator
--1)Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--2)Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel3 WHERE sehir IN('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN(2,3);

--1)Maasi 4800’den az olanlar veya 5500’den cok olanlarin id’lerini listeleyin
--2)Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel3 WHERE maas NOT BETWEEN 4800 and 5500
INTERSECT 
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN(2,3);

--3)Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel3 WHERE sirket = 'Honda'
INTERSECT
SELECT isim FROM personel3 WHERE sirket = 'Tofas'
INTERSECT
SELECT isim FROM personel3 WHERE sirket = 'Ford';



-- EXCEPT Operator
--5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket FROM personel3 WHERE maas < 5000
EXCEPT
SELECT isim,sirket FROM personel3 WHERE sirket = 'Honda';

--Ismi Mehmet Ozturk olup Ankara’da calismayanlarin isimlerini ve sehirlerini listeleyin
SELECT isim, sehir FROM personel3 WHERE isim = 'Mehmet Ozturk'
EXCEPT
SELECT isim, sehir FROM personel3 WHERE sehir = 'Ankara';


-- JOINS 
-- 2 Tablodaki datalari birlestirmek icin kullanilir
-- 5 Cesit Join vardir 1- Inner 2-Left 3-Right 4-Full 5-Self

-- INNER Joins
CREATE TABLE sirketler (
sirket_id int,
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

SELECT * FROM sirketler;
SELECT * FROM siparisler;

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler INNER JOIN siparisler 
ON sirketler.sirket_id = siparisler.sirket_id;

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM siparisler INNER JOIN sirketler 
ON sirketler.sirket_id = siparisler.sirket_id;

