CREATE TABLE SALESMAN (
    SALESMAN_ID INTEGER,
    NAME VARCHAR(20),
    CITY VARCHAR(20),
    COMMISSION VARCHAR(20),
    PRIMARY KEY (SALESMAN_ID)
);

CREATE TABLE CUSTOMER (
    CUSTOMER_ID INTEGER,
    CUST_NAME VARCHAR(20),
    CITY VARCHAR(20),
    GRADE INTEGER,
    PRIMARY KEY (CUSTOMER_ID),
    SALESMAN_ID INTEGER,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE SET NULL
);

CREATE TABLE ORDERS (
    ORD_NO INTEGER,
    PURCHASE_AMT INTEGER,
    ORD_DATE DATE,
    PRIMARY KEY (ORD_NO),
    CUSTOMER_ID INTEGER,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID) ON DELETE CASCADE,
    SALESMAN_ID INTEGER,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE
);

INSERT INTO SALESMAN VALUES 
(1000, 'JOHN', 'BANGALORE', '25 %'), 
(2000, 'RAVI', 'BANGALORE', '20 %'), 
(3000, 'KUMAR', 'MYSORE', '15 %'), 
(4000, 'SMITH', 'DELHI', '30 %'), 
(5000, 'HARSHA', 'HYDRABAD', '15 %');

INSERT INTO CUSTOMER VALUES 
(10, 'PREETHI', 'BANGALORE', 100, 1000), 
(11, 'VIVEK', 'MANGALORE', 300, 1000), 
(12, 'BHASKAR', 'CHENNAI', 400, 2000), 
(13, 'CHETHAN', 'BANGALORE', 200, 2000), 
(14, 'MAMATHA', 'BANGALORE', 400, 3000);

INSERT INTO ORDERS VALUES 
(50, 5000, '2017-05-04', 10, 1000), 
(51, 450, '2017-01-20', 10, 2000), 
(52, 1000, '2017-02-24', 13, 2000), 
(53, 3500, '2017-04-13', 14, 3000), 
(54, 550, '2017-03-09', 12, 2000);



SELECT GRADE, COUNT(DISTINCT CUSTOMER_ID) 
FROM CUSTOMER 
WHERE GRADE > (
    SELECT AVG(GRADE) 
    FROM CUSTOMER 
    WHERE CITY = 'BANGALORE'
)
GROUP BY GRADE;

SELECT SALESMAN_ID, NAME 
FROM SALESMAN A 
WHERE 1 < (
    SELECT COUNT (*) 
    FROM CUSTOMER 
    WHERE SALESMAN_ID = A.SALESMAN_ID
);

SELECT SALESMAN_ID, NAME 
FROM SALESMAN A 
WHERE 1 < (SELECT COUNT(*) 
           FROM CUSTOMER 
           WHERE SALESMAN_ID = A.SALESMAN_ID);

SELECT SALESMAN.SALESMAN_ID, NAME, CUST_NAME, COMMISSION 
FROM SALESMAN
JOIN CUSTOMER ON SALESMAN.CITY = CUSTOMER.CITY  
UNION 
SELECT SALESMAN_ID, NAME, 'NO MATCH', COMMISSION 
FROM SALESMAN 
WHERE CITY NOT IN (SELECT CITY FROM CUSTOMER) 
ORDER BY NAME DESC;

CREATE VIEW ELITSALESMAN AS 
SELECT B.ORD_DATE, A.SALESMAN_ID, A.NAME 
FROM SALESMAN A
JOIN ORDERS B ON A.SALESMAN_ID = B.SALESMAN_ID 
WHERE B.PURCHASE_AMT = (
    SELECT MAX(PURCHASE_AMT) 
    FROM ORDERS C 
    WHERE C.ORD_DATE = B.ORD_DATE
);

DELETE FROM SALESMAN 
WHERE SALESMAN_ID=1000;