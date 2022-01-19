/*================================== DELETE =================================*/
        -- DELETE FROM tablo_adi; tablonun tüm icerigini siler
        -- DML komutudur. devaminda WHERE gibi ifadeler kullanilabilir
        
        -- DELETE FROM tablo_adi
        -- WHERE sutun_adi = veri;
        
         CREATE TABLE ogrenciler2
        (
            id CHAR(3),
            isim VARCHAR2(50),
            veli_isim VARCHAR2(50),
            yazili_notu NUMBER(3)       
        );
        
        INSERT INTO ogrenciler2 VALUES(123, 'Ali Can', 'Hasan', 75);
        INSERT INTO ogrenciler2 VALUES(124, 'Merve Gul', 'Ayse', 85);
        INSERT INTO ogrenciler2 VALUES(125, 'Kemal Yasa', 'Hasan', 85);
        INSERT INTO ogrenciler2 VALUES(126, 'Nesibe Yilmaz', 'Ayse', 95);
        INSERT INTO ogrenciler2 VALUES(127, 'Mustafa Bak', 'Can', 99);
    
        SELECT * FROM ogrenciler2;
         DROP TABLE ogrenciler2;
         
         -- id'si 124 olan ogrenciyi silelim
         DELETE FROM ogrenciler2
         WHERE id = 124;
         
         --adi kemal yasa olan kaydi  silelim
         DELETE FROM ogrenciler2
         WHERE isim = 'Kemal Yasa';
         
         --adi nesibe yoilmaz ve mustafa bak olanlari silelim
         DELETE FROM ogrenciler2
         WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';
         
         DELETE FROM ogrenciler2
         WHERE isim = 'Ali Can' AND id = 123;
         
         -- id'si 126'dan büyük olan kayitlari silelim
         DELETE FROM ogrenciler2
         WHERE id > 126;
         
         --id'si 123 ve 125 126 olanlari silelim
         DELETE FROM ogrenciler2
         WHERE id IN(123, 125, 126);
         
         -- Tüm kayitlari silelim
         SELECT * FROM ogrenciler2;
         DELETE FROM ogrenciler2;
        
        FLASHBACK TABLE ogrenciler2 TO BEFORE DROP;
         DROP TABLE ogrenciler2 PURGE;
         
         /*============================== TRUNCATE ============================*/
         
         -- DELETE gibi tüm verileri siler
         -- Silinenler geri getirilemez ROLLBAK ile
         -- DROP -- TRUNCATE -- DELETE
         
        CREATE TABLE talebeler
        (
            id CHAR(3),  --PK
            isim VARCHAR2(50),
            veli_isim VARCHAR2(50),
            yazili_notu NUMBER(3),
            CONSTRAINT talebe_pk PRIMARY KEY (id)
        );
        
        INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
        INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
        INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
        INSERT INTO talebeler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
        INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
             
             
        CREATE TABLE notlar 
        ( 
            talebe_id char(3), --FK
            ders_adi varchar2(30), 
            yazili_notu number (3), 
            CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
            REFERENCES talebeler(id) ON DELETE CASCADE
        );
    
        INSERT INTO notlar VALUES ('123','kimya',75);
        INSERT INTO notlar VALUES ('124', 'fizik',65);
        INSERT INTO notlar VALUES ('125', 'tarih',90);
        INSERT INTO notlar VALUES ('126', 'matematik',90);
             
             DELETE FROM notlar
             WHERE talebe_id = 124;
             
             DELETE FROM talebeler
             WHERE id = 124;  -- bunu calistirmak icin önce notlara ki 124 id yi silmek gerekir
                                            -- ya da PREFERENCES talebeler(id) 'Den sonra ON DELETE CASCADE yazarak silebiliriz
                                            -- ON DELETE CASCADE kullanirsak 124 olan id'yi iki tablodanda siler
             DROP TABLE talebeler;
             DROP TABLE notlar;
         
         
         
         
         
         
         
         