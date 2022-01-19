/* ========================================================= 
                        TABLO OLUŞTURMA  (CRUD - Create)                  
============================================================*/
CREATE TABLE student 
(   
    id VARCHAR(4),
  name VARCHAR(20),
    age int
);
/* ========================================================= 
                     VERİ GİRİŞİ 
===========================================================*/

INSERT INTO student VALUES('1001', 'MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYŞE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);

-- kayit denemesi yapildi
/* ========================================================= 
                  PARCALI  VERİ GİRİŞİ 
===========================================================*/
INSERT INTO student(name, age) VALUES('Samet Ay',24);

select * from student ;

/* ========================================================= 
                    TABLO SiLME  (CRUD - Drop )
===========================================================*/
DROP TABLE student;