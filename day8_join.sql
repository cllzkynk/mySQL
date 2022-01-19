use sys;
/*============================== JOIN İSLEMLERİ ===============================
    
    Set Operatorleri (Union,Union All, {oracle->Intersect,Minus}) farklı tablolardaki sutunlari 
    birlestirmek kullanilir.
    
    Join islemleri ise farklı Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    mySQL'de 3 Cesit Join islemi kullanilabilmektedir.
    
    1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    2) LEFT JOIN:  Ilk tabloda (Sol) olan sonuclari gosterir
    3) RIGHT JOIN:  Ikinci tabloda (sağ) olan tum sonuclari gosterir
       full JOIN=(left join + union  + right join) Tablodaki tum sonuclari gosterir
==============================================================================*/   
    CREATE TABLE sirketler 
    (
        sirket_id int, 
        sirket_isim VARCHAR(20)
    );
    
    INSERT INTO sirketler VALUES(100, 'Toyota');
    INSERT INTO sirketler VALUES(101, 'Honda');
    INSERT INTO sirketler VALUES(102, 'Ford');
    INSERT INTO sirketler VALUES(103, 'Hyundai');
  
    CREATE TABLE siparisler
    (
        siparis_id int,
        sirket_id int, 
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
    INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
    INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
    INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
    INSERT INTO siparisler VALUES(55, 105, '2020-04-21');
    
    /*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
================================================================================  
    
  
/* -----------------------------------------------------------------------------
  ORNEK1: Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

select sir.sirket_isim, sip.siparis_id,sip.siparis_tarihi,sip.sirket_id
from sirketler sir
inner join siparisler sip
on sir.sirket_id=sip.sirket_id;
-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
    -- Diger bir ifadeyle iki tablodaki ortak olan sirket_id degerleri icin 
    -- ilgili sutunlar listenir.
    
    -- INNER anahtar kelimesi opsiyoneldir.
    
        
/*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/  
            
/* -----------------------------------------------------------------------------
  ORNEK2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   
select sir.sirket_isim, sip.siparis_id, sip.siparis_tarihi, sir.sirket_id
from sirketler sir
left join siparisler sip
on sir.sirket_id=sip.sirket_id;

select sir.sirket_isim, sip.siparis_id, sip.siparis_tarihi, sir.sirket_id
from siparisler sip
right join sirketler sir
on sir.sirket_id=sip.sirket_id;
    
    
    -- Left Join'de ilk tablodaki (fromdan sonra gelen ) tum satirlar gosterilir.
    -- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar 
	-- gosterilir, ancak ortak olmayan kisimlar bos kalir
          
/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/   
      
/* -----------------------------------------------------------------------------
  ORNEK3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   