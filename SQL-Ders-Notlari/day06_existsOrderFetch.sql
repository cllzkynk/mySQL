

/*=========================== EXISTS, NOT EXIST ================================
                EXISTS operatorü bir Boolean operatördür ve true - false de?er döndürür. 
                EXISTS operatorü s?kl?kla Subquery'lerde sat?rlar?n do?rulu?unu test etmek 
                için kullan?l?r.
                
                E?er bir subquery (altsorgu) bir sat?r? döndürürse EXISTS operatörü de TRUE 
                de?er döndürür. Aksi takdirde, FALSE de?er döndürecektir.
                
                Özellikle altsorgularda h?zl? kontrol i?lemi gerçekle?tirmek için kullan?l?r
==============================================================================*/
        CREATE TABLE mart_satislar
            (
                urun_id number(10),
                musteri_isim varchar2(50), 
                urun_isim varchar2(50)
            );
            
         CREATE TABLE nisan_satislar 
            (
                urun_id number(10),
                musteri_isim varchar2(50), 
                urun_isim varchar2(50)
            );
            
            INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
            INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
            INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
            INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
            INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
            INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
            INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
            INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');
            
            
            INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
            INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
            INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
            INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
            INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');
        
            SELECT * FROM mart_satislar;
            SELECT * FROM nisan_satislar;
           
            DELETE FROM nisan_satislar;
            
    -- tablolara k?sa isim vermek mümkündür. Böylece sorgular?m?z?n daha k?sa 
    -- gözükmesini sa?labiliriz.
    
    -- AS  -> bir sutuna k?sa isim veriyor.
    -- Bir sorgu içerisinde  tabloya da k?sa isim vermek mümkün. 
    -- tablo_Adi k?sa_isim
    
        /* ORNEK1: MART VE N?SAN aylar?nda ayn? URUN_ID ile sat?lan ürünlerin
  URUN_ID’lerini listeleyen ve ayn? zamanda bu ürünleri MART ay?nda alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yaz?n?z. 
 -----------------------------------------------------------------------------*/                   
        SELECT urun_id, musteri_isim FROM mart_satislar m
        WHERE EXISTS (SELECT urun_id FROM nisan_satislar n
                                       WHERE m.urun_id = urun_id);
                                       
        
       --  WHERE urun_id IN(SELECT urun_id FROM nisan_satislar
       --                                      WHERE mart_satislar.urun_id = nisan_satislar.urun_id);
       
       
       
       --     Her iki ayda da sat?lan ürünlerin URUN_ISIM'lerini ve bu ürünleri
       --   N?SAN ay?nda sat?n alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaz?n?z. 
        
        SELECT urun_isim, musteri_isim FROM nisan_satislar n
        WHERE EXISTS (SELECT urun_id FROM mart_satislar m
                                        WHERE m.urun_isim = n.urun_isim);
       
       -- Her iki ayda da ortak olarak sat?lmayan ürünlerin URUN_ISIM'lerini 
       -- ve bu ürünleri N?SAN ay?nda sat?n alan MUSTERI_ISIM'lerini listeleyiniz.
            
        SELECT urun_isim, musteri_isim FROM nisan_satislar n
        WHERE NOT EXISTS (SELECT urun_id FROM mart_satislar m
                                               WHERE m.urun_isim = n.urun_isim);
            
             /*===================== IS NULL, IS NOT NULL, COALESCE ========================
    
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup 
    olmad???n? kontrol ederler.  
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi döndürür. E?er ald??? tüm ifadeler NULL ise NULL döndürürür.
    
    sutun_adi = COALESCE(ifade1, ifade2, .....ifadeN)
    
==============================================================================*/
         CREATE TABLE insanlar 
        (
            ssn CHAR(9),
            isim VARCHAR2(50), 
            adres VARCHAR2(50) 
        );
    
        INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
        INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
        INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
        INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
        INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
        INSERT INTO insanlar (adres) VALUES('Sakarya');
        INSERT INTO insanlar (ssn) VALUES('999111222');
        
        DELETE FROM insanlar;
            
            --ORNEK1: isim 'i NULL olanlar? sorgulay?n?z.
            SELECT * FROM insanlar
            WHERE isim IS NULL;
            
            -- ORNEK2: isim 'i NULL olmayanlar? sorgulay?n?z.
            SELECT * FROM insanlar
            WHERE isim IS NOT NULL;
            
            -- ORNEK3: isim 'i NULL olan ki?ilerin isim'ine NO NAME atay?n?z.
            UPDATE insanlar
            SET isim = 'NO NAME'
            WHERE isim IS NULL;
            
            -- isim 'i NULL olanlara 'Henuz isim girilmedi'
            -- adres 'i NULL olanlara 'Henuz adres girilmedi'
            -- ssn 'i NULL olanlara ' no ssn' atayal?m.
            
           UPDATE   insanlar
           SET isim = COALESCE (isim, 'Henüz isim girilmedi'),  --isim eger NULL ise Henüz isim girilmedi atanir
                    adres = COALESCE (adres, 'Henüz adres girilmedi'),
                    ssn = COALESCE (ssn, 'No SSN');

 /*================================ ORDER BY  ===================================
           ORDER BY cümleci?i bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
           SIRALAMA yapmak için kullan?l?r.
           
           Syntax
           -------
              ORDER BY sutun_adi ASC   -- ARTAN
              ORDER BY sutun_adi DESC  -- AZALAN
 ==============================================================================*/       
            CREATE TABLE kisiler 
            (
                ssn CHAR(9) PRIMARY KEY,
                isim VARCHAR2(50), 
                soyisim VARCHAR2(50), 
                maas NUMBER,
                adres VARCHAR2(50) 
            );
            
            INSERT INTO kisiler VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
            INSERT INTO kisiler VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
            INSERT INTO kisiler VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
            INSERT INTO kisiler VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
            INSERT INTO kisiler VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
            INSERT INTO kisiler VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');
        
            SELECT * FROM kisiler;
                    
            -- kisiler tablosunu adres'e göre s?ralayarak sorgulay?n?z.
            SELECT * FROM kisiler
            ORDER BY adres;
            
            -- kisiler tablosunu maas'a göre s?ralayarak sorgulay?n?z.
            SELECT * FROM kisiler
            ORDER BY maas;  --ASC
            
            -- kisiler tablosunu maas'a göre AZALAN s?rada sorgulay?n?z.
             SELECT * FROM kisiler
            ORDER BY maas DESC;
            
            -- ismi Mine olanlar?, SSN'e göre AZALAN s?rada sorgulay?n?z.
            SELECT * FROM kisiler
            WHERE isim='Mine'
            ORDER BY ssn DESC;
            
            --soyismi 'i Bulut olanlar? isim s?ral? olarak sorgulay?n?z.
            SELECT * FROM kisiler
            WHERE soyisim='Bulut'
            ORDER BY 2;   -- isim 2. sütunda oldugu icin 2 yazabiliriz
            
    /*====================== FETCH NEXT, OFFSET (12C VE ÜSTÜ) ======================
                       FETCH cümleci?i ile listelenecek kay?tlar? s?n?rland?rabiliriz. ?stersek 
                       sat?r say?s?na göre istersek de toplam sat?r say?s?n?n belli bir yüzdesine 
                       göre s?n?rland?rma koymak mümkündür. 
                       
                       Syntax
                       ---------
                       FETCH NEXT satir_sayisi ROWS ONLY;
                       FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
                    
                       OFFSET Cümleci?i ile de listenecek olan sat?rlardan s?ras?yla istedi?imiz 
                       kadar?n? atlayabiliriz.  
                       
                       Syntax
                       ----------
                       OFFSET sat?r_sayisi ROWS;
  
==============================================================================*/ 

        --MAA?'? en yüksek 3 ki?inin bilgilerini listeleyen sorguyu yaz?n?z.
        SELECT * FROM kisiler
        ORDER BY maas DESC
        FETCH NEXT 3 ROWS ONLY;
        
        -- MAA?'? en DÜ?ÜK 2 ki?inin bilgilerini listeleyen sorguyu yaz?n?z.
        SELECT * FROM kisiler
        ORDER BY maas ASC
        FETCH NEXT 2 ROWS ONLY;
        
        -- MAA?'a göre s?ralamada 4. ile 6. ki?ilerin bilgilerini listeleyen 
        -- sorguyu yaz?n?z.
        SELECT * FROM kisiler
        ORDER BY maas DESC
        OFFSET 3 ROWS  --ilk 3 satiri atladik
        FETCH NEXT 3 ROWS ONLY;  -- sonraki 3 kaydi sectik
        
       