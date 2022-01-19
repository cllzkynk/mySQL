/*================== SUBQUERIES ========================
        SORGU icinde SORGUYA SUBQUERY (ALT SORGU) denir
==============================================================*/
        CREATE TABLE personel 
        (
            id NUMBER(9), 
            isim VARCHAR2(50), 
            sehir VARCHAR2(50), 
            maas NUMBER(20), 
            sirket VARCHAR2(20)
        );
        INSERT INTO personel VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
        INSERT INTO personel VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
        INSERT INTO personel VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
        INSERT INTO personel VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
        INSERT INTO personel VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
        INSERT INTO personel VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
        INSERT INTO personel VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');
        
        CREATE TABLE sirketler
        (
            sirket_id NUMBER(9), 
            sirket_adi VARCHAR2(20), 
            personel_sayisi NUMBER(20)
        );
        
        INSERT INTO sirketler VALUES(100, 'Honda', 12000);
        INSERT INTO sirketler VALUES(101, 'Ford', 18000);
        INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
        INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
    
        SELECT *FROM sirketler;
        SELECT * FROM personel;
    
    -- Personel sayisi 15.000'den cok olan sirketlerin isimlerini ve bu sirkette 
    -- calisan personelin isimlerini listeleyiniz
    
        SELECT isim, sirket FROM personel
        WHERE sirket IN(SELECT sirket_adi FROM sirketler
                                        WHERE personel_sayisi > 15000);
        
  -- ORNEK2: sirket_id’si 101’den büyük olan ?irket çal??anlar?n?n isim, maa? ve 
  -- ?ehirlerini listeleyiniz. 
        
        SELECT isim, maas, sehir FROM personel
        WHERE sirket IN(SELECT sirket_adi FROM sirketler
                                        WHERE sirket_id > 101);
 
 
    -- Ankara’da personeli olan ?irketlerin ?irket id'lerini ve personel 
    --say?lar?n? listeleyiniz.
        
        SELECT sirket_id, personel_sayisi FROM sirketler
        WHERE sirket_adi IN(SELECT sirket FROM personel
                                               WHERE sehir = 'Ankara');
        
        
         /* ===================== AGGREGATE METOT KULLANIMI ===========================
                Aggregate Metotlar?(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullan?labilir.
                Ancak, Sorgu tek bir de?er döndüryor olmal?d?r.
                ==============================================================================*/   
        
    -- Her ?irketin ismini, personel say?s?n? ve o ?irkete ait personelin
    -- toplam maa??n? listeleyen bir Sorgu yaz?n?z.
        
        SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas) FROM personel
                                                                        WHERE sirket = sirketler.sirket_adi) AS toplam_maas
        FROM sirketler;
    
    -- Her ?irketin ismini, personel say?s?n? ve o ?irkete ait personelin
    -- ortalama maa??n? listeleyen bir Sorgu yaz?n?z.
        
        SELECT sirket_adi, personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel
                                                                        WHERE sirket = sirket_adi) AS ortalama_maas
        FROM sirketler;
        
    -- Her ?irketin ismini, personel say?s?n? ve o ?irkete ait personelin
    --  maksimum ve minumum maa??n? listeleyen bir Sorgu yaz?n?z.
      
        SELECT sirket_adi, personel_sayisi, (SELECT MAX(maas) FROM personel
                                                                        WHERE sirket = sirket_adi) AS max_maas,
                                                                        (SELECT MIN(maas) FROM personel
                                                                        WHERE sirket = sirket_adi) AS min_maas
        FROM sirketler;
        
  
    --Her sirketin id’sini, ismini ve toplam kaç ?ehirde bulundu?unu 
    -- listeleyen bir SORGU yaz?n?z.
        
        SELECT sirket_id, sirket_adi, (SELECT COUNT(sehir) FROM personel
                                                            WHERE sirket=sirketler.sirket_adi) AS sehir_sayisi
        FROM sirketler;                                                    
        
    
    
        
        
        
        
        
        
        
        
        
        
