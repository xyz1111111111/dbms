CREATE TABLE  PUBLISHER
(NAME VARCHAR (20) PRIMARY KEY,
PHONE INTEGER,
ADDRESS VARCHAR (20));


CREATE TABLE  BOOK
(BOOK_ID INTEGER PRIMARY KEY,
TITLE VARCHAR(20),
PUB_YEAR VARCHAR(20),
PUBLISHER_NAME VARCHAR(20),
FOREIGN KEY(PUBLISHER_NAME) REFERENCES PUBLISHER (NAME) ON DELETE CASCADE);


CREATE TABLE  BOOK_AUTHORS (
AUTHOR_NAME VARCHAR (20),
BOOK_ID INTEGER,
FOREIGN KEY(BOOK_ID) REFERENCES
BOOK(BOOK_ID) ON DELETE CASCADE,
PRIMARY KEY (BOOK_ID, AUTHOR_NAME));


CREATE TABLE  LIBRARY_PROGRAMME
(PROGRAMME_ID INTEGER PRIMARY KEY,
PROGRAMME_NAME VARCHAR(50),
ADDRESS VARCHAR (50));


CREATE TABLE  BOOK_COPIES (
	NO_OF_COPIES INTEGER,
	BOOK_ID INTEGER ,
	PROGRAMME_ID INTEGER,
FOREIGN KEY(BOOK_ID) REFERENCES BOOK (BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY(PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME
(PROGRAMME_ID) ON DELETE CASCADE,
PRIMARY KEY (BOOK_ID, PROGRAMME_ID));


CREATE TABLE  CARD
(CARD_NO INTEGER PRIMARY KEY);


CREATE TABLE  BOOK_LENDING
(DATE_OUT DATE,
DUE_DATE DATE,
BOOK_ID INTEGER,
PROGRAMME_ID INTEGER,
FOREIGN KEY(BOOK_ID) REFERENCES BOOK (BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY(PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME (PROGRAMME_ID) ON DELETE CASCADE,
CARD_NO INTEGER);





INSERT INTO PUBLISHER 
VALUES 
  ('MCGRAW-HILL', 99890765, 'BANGALORE'),
  ('PEARSON', 98890765, 'NEWDELHI'),
  ('RANDOM HOUSE', 74556793, 'HYDERABAD'),
  ('HACHETTE LIVRE', 89708623, 'CHENNAI'),
  ('GRUPO PLANETA', 77561202, 'BANGALORE');


INSERT INTO BOOK 
VALUES 
  (1, 'DBMS', '01-JAN-2017', 'MCGRAW-HILL'),
  (2, 'ADBMS', '02-JUN-2016', 'MCGRAW-HILL'),
  (3, 'CN', '03-SEP-2016', 'PEARSON'),
  (4, 'CG', '04-SEP-2015', 'GRUPO PLANETA'),
  (5, 'OS', '05-MAY-2016', 'PEARSON');


INSERT INTO BOOK_AUTHORS 
VALUES 
  ('NAVATHE', 1),
  ('NAVATHE', 2),
  ('TANENBAUM', 3),
  ('EDWARD ANGEL', 4),
  ('GALVIN', 5);


INSERT INTO LIBRARY_PROGRAMME 
VALUES 
  (10, 'RRNAGAR', 'BANGALORE'),
  (11, 'APSCE', 'BANGALORE'),
  (12, 'N R COLONY', 'BANGALORE'),
  (13, 'NITTE', 'MANGALORE'),
  (14, 'MANIPAL', 'UDUPI');


INSERT INTO BOOK_COPIES 
VALUES 
  (10, 1, 10),
  (5, 1, 11),
  (2, 2, 12),
  (5, 2, 13),
  (7, 3, 14),
  (1, 5, 10),
  (3, 4, 11);



INSERT INTO BOOK_LENDING 
VALUES 
  ('2017-01-01', '2017-06-01', 1, 10, 101),
  ('2017-01-11', '2017-03-11', 3, 14, 101),
  ('2017-02-21', '2017-04-21', 2, 13, 101),
  ('2017-03-15', '2017-07-15', 4, 11, 101),
  ('2017-04-12', '2017-05-12', 1, 11, 104);





SELECT B.BOOK_ID, B.TITLE, B.PUBLISHER_NAME, A.AUTHOR_NAME,C.NO_OF_COPIES, L.PROGRAMME_ID
FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES C, LIBRARY_PROGRAMME L
WHERE B.BOOK_ID=A.BOOK_ID
AND B.BOOK_ID=C.BOOK_ID
AND L. PROGRAMME_ID=C. PROGRAMME_ID;


SELECT CARD_NO
FROM BOOK_LENDING
WHERE DATE_OUT BETWEEN '2017-01-01' AND '2017-07-01'
GROUP BY CARD_NO
HAVING COUNT(*) > 3;


DELETE FROM BOOK
WHERE BOOK_ID=3;


CREATE VIEW V_PUBLICATION AS
SELECT PUB_YEAR
FROM BOOK;


CREATE VIEW V_BOOKS AS
SELECT B.BOOK_ID, B.TITLE, C.NO_OF_COPIES
FROM BOOK B, BOOK_COPIES C,LIBRARY_PROGRAMME L
WHERE B.BOOK_ID=C.BOOK_ID AND
C. PROGRAMME_ID=L.PROGRAMME_ID;