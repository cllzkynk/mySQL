use sys;

/* ============================= SUBQUERIES ====================================
    SORGU içinde çalişan SORGUYA SUBQUERY (ALT SORGU) denilir.
==============================================================================*/

CREATE TABLE calisanlar (
    id INT,
    isim VARCHAR(50),
    sehir VARCHAR(50),
    maas INT,
    isyeri VARCHAR(20)
);
    INSERT INTO calisanlar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
    INSERT INTO calisanlar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
    INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
    INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
    INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
    INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
    INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
  
CREATE TABLE markalar (
    marka_id INT,
    marka_isim VARCHAR(20),
    calisan_sayisi INT
) ;
   
    INSERT INTO markalar VALUES(100, 'Vakko', 12000);
    INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
    INSERT INTO markalar VALUES(102, 'Adidas', 10000);
    INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

select * from  calisanlar ;
select * from  markalar ;

/* -----------------------------------------------------------------------------
  ORNEK1: Personel sayısı 15.000’den cok olan sirketlerin isimlerini ve bu 
  sirkette calisan personelin isimlerini ve maaşlarını listeleyin
 -----------------------------------------------------------------------------*/ 
 
    SELECT isim,maas,isyeri FROM calisanlar
    WHERE isyeri IN(SELECT marka_isim FROM markalar  
                    WHERE calisan_sayisi > 15000);
         
  
 /* ----------------------------------------------------------------------------
  ORNEK2: sirket_id’si 101’den büyük olan şirket çalışanlarının isim, maaş ve 
  şehirlerini listeleyiniz. 
  
  -----------------------------------------------------------------------------*/
SELECT 
    isim, maas, sehir
FROM
    calisanlar
WHERE
    isyeri IN (SELECT 
            marka_isim
        FROM
            markalar
        WHERE
            marka_id > 101);
            /*----------------------------------------------------------------
  ORNEK3: Ankara’da personeli olan şirketlerin şirket id'lerini ve personel 
  sayılarını listeleyiniz.
  
  -----------------------------------------------------------------------------*/ 
SELECT marka_id , calisan_sayisi FROM markalar
   
   WHERE marka_isim IN (SELECT isyeri FROM calisanlar
                        WHERE sehir = 'Ankara');
   
   -- 2 . yol 
   select marka_id, calisan_sayisi from markalar where marka_isim in (select isyeri from calisanlar where sehir = 'ankara');
   
   select * from  calisanlar ;
select * from  markalar ;
  /* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlari(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullanilabilir.
    Ancak, Sorgu tek bir değer döndürüyor olmalidir.
==============================================================================*/   
      
  /* -----------------------------------------------------------------------------
  ORNEK4: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  toplam maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
 
 select marka_isim,calisan_sayisi,(select SUM(maas)from calisanlar  
                                where markalar.marka_isim=calisanlar.isyeri )as toplam_maas from markalar ;
 
 

/* -----------------------------------------------------------------------------
  ORNEK5: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  ortalama maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
select marka_isim, calisan_sayisi, (select  ROUND(AVG(maas)) from calisanlar where marka_isim=isyeri )
AS  toplam_maas  from markalar;
   
 
 /* ----------------------------------------------------------------------------
  ORNEK6: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/  
  
    SELECT 
    marka_isim,
    calisan_sayisi,
    (SELECT 
            MAX(maas)
        FROM
            calisanlar
        WHERE
            marka_isim = isyeri) max_maas,
    (SELECT 
            MIN(maas)
        FROM
            calisanlar
        WHERE
            marka_isim = isyeri) min_maas
FROM
    markalar;
   
 
 /* -----------------------------------------------------------------------------
  ORNEK7: Her sirketin id’sini, ismini ve toplam kaç şehirde bulunduğunu 
  listeleyen bir SORGU yazınız.
 -----------------------------------------------------------------------------*/
   
   
   SELECT marka_id, marka_isim, ( SELECT COUNT(sehir) FROM calisanlar
                                    WHERE marka_isim=isyeri ) AS sehir_sayisi
    
    FROM markalar;
    