CREATE TABLE REP
(
  REP_NUM    CHAR(2) PRIMARY KEY,
  LAST_NAME  CHAR(15),
  FIRST_NAME CHAR(15),
  STREET     CHAR(15),
  CITY       CHAR(15),
  PROVINCE   CHAR(3),
  CHECK (PROVINCE = 'ONT' OR PROVINCE = 'QC'), /*Modified*/
  ZIP        CHAR(5),
  COMMISSION DECIMAL(7, 2) NOT NULL, /*Modified*/
  RATE       DECIMAL(3, 2)
    CHECK (COMMISSION <= 0.15) /*Modified*/
);


CREATE TABLE CUSTOMER
(
  CUSTOMER_NUM  CHAR(3) PRIMARY KEY,
  CUSTOMER_NAME CHAR(35) NOT NULL,
  STREET        CHAR(15),
  CITY          CHAR(15) DEFAULT 'Ottawa' /*Modified*/,
  PROVINCE      CHAR(3),
  ZIP           CHAR(5),
  BALANCE       DECIMAL(8, 2),
  CREDIT_LIMIT  DECIMAL(8, 2),
  REP_NUM       CHAR(2),
  CHECK (BALANCE <= CREDIT_LIMIT) /*Modified*/
);

CREATE TABLE ORDERS
(
  ORDER_NUM    CHAR(5) PRIMARY KEY,
  ORDER_DATE   DATE,
  CUSTOMER_NUM CHAR(3)
);

CREATE TABLE PART
(
  PART_NUM    CHAR(4) PRIMARY KEY,
  DESCRIPTION CHAR(15),
  ON_HAND     DECIMAL(4, 0),
  CLASS       CHAR(2),
  WAREHOUSE   CHAR(1),
  PRICE       DECIMAL(6, 2)
);

CREATE TABLE ORDER_LINE
(
  ORDER_NUM    CHAR(5),
  PART_NUM     CHAR(4),
  NUM_ORDERED  DECIMAL(3, 0),
  QUOTED_PRICE DECIMAL(6, 2),
  PRIMARY KEY (ORDER_NUM, PART_NUM)
);


INSERT INTO REP
VALUES
  ('20', 'Kaiser', 'Valerie', '624 Randall', 'Ottawa', 'ONT', '33321', 2542.50, 0.05);
INSERT INTO REP
VALUES /*Broken*/
  ('35', 'Hull', 'Richard', '532 Jackson', 'Toronto', 'ONT', '33553', 30000.00, 0.07);

INSERT INTO REP
VALUES
  ('45', 'Hull', 'Ann', '532 Jackson', 'Toronto', 'ONT', '33553', 9600.00, 0.10);
INSERT INTO REP
VALUES
  ('65', 'Perez', 'Juan', '1626 Taylor', 'Barrhaven', 'ONT', '33336', 23487.00, 0.05);

INSERT INTO CUSTOMER
VALUES
  ('148', 'Al''s Appliance and Sport', '2837
Greenway', 'Barrhaven', 'ONT', '33336', 6550.00, 7500.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('282', 'Brookings Direct', '3827
Devon', 'Ottawa', 'ONT', '33321', 431.50, 10000.00, '35');
INSERT INTO CUSTOMER
VALUES
  ('356', 'Ferguson''s', '382
Wildwood', 'Northfield', 'ONT', '33146', 5785.00, 7500.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('408', 'The Everything Shop', '1828
Raven', 'Chelsea', 'QC', '33503', 5285.25, 7500.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('462', 'Bargains Galore', '3829
Central', 'Ottawa', 'ONT', '33321', 3412.00, 9000.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('524', 'Kline''s', '838
Ridgeland', 'Barrhaven', 'ONT', '33336', 12762.00, 15000.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('608', 'Johnson''s Department Store', '372
Oxford', 'Toronto', 'ONT', '33553', 2106.00, 10000.00, '65');
INSERT INTO CUSTOMER
VALUES
  ('140', 'The Everything Shop', '1828
Raven', 'Chelsea', 'QC', '33503', 5285.25, 6500.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('687', 'Lee''s Sport and Appliance', '282
Evergreen', 'Chelsea', 'QC', '32543', 2851.00, 5000.00, '35');
INSERT INTO CUSTOMER
VALUES
  ('725', 'Deerfield''s Four Seasons', '282
Columbia', 'Toronto', 'ONT', '33553', 248.00, 7500.00, '35');
INSERT INTO CUSTOMER
VALUES
  ('842', 'All Season', '28 Lakeview', 'Ottawa', 'ONT', '33321', 8221.00, 17500.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('892', 'All Season', '28 Lakeside', 'Ottawa', 'ONT', '34321', 1021.00, 7000.00, '20');
INSERT INTO CUSTOMER
VALUES
  ('998', 'Joe Store', '12 Riverside', 'Ottawa', 'ONT', '23231', 0.00, 0.00, '20');


INSERT INTO ORDERS
VALUES
  ('21608', '2010-10-20', '148');
INSERT INTO ORDERS
VALUES
  ('21610', '2010-10-20', '356');
INSERT INTO ORDERS
VALUES
  ('21613', '2010-10-21', '282');
INSERT INTO ORDERS
VALUES
  ('21614', '2010-10-21', '282');
INSERT INTO ORDERS
VALUES
  ('21617', '2010-10-23', '608');
INSERT INTO ORDERS
VALUES
  ('21619', '2010-10-23', '148');
INSERT INTO ORDERS
VALUES
  ('21623', '2010-10-23', '608');

INSERT INTO PART
VALUES
  ('AT94', 'Fireplace', 50, 'HW', '3', 24.95);
INSERT INTO PART
VALUES
  ('BV06', 'Home Gym', 45, 'SG', '2', 794.95);
INSERT INTO PART
VALUES
  ('CD52', 'Microwave Oven', 32, 'AP', '1', 165.00);
INSERT INTO PART
VALUES
  ('DL71', 'Dishwasher', 21, 'HW', '3', 129.95);
INSERT INTO PART
VALUES
  ('DR93', 'Gas Range', 8, 'AP', '2', 495.00);
INSERT INTO PART
VALUES
  ('DW11', 'Washer', 12, 'AP', '3', 399.99);
INSERT INTO PART
VALUES
  ('FD21', 'Mixer', 22, 'HW', '3', 159.95);
INSERT INTO PART
VALUES
  ('KL62', 'Dryer', 12, 'AP', '1', 349.95);
INSERT INTO PART
VALUES
  ('KT03', 'Dishwasher', 8, 'AP', '3', 595.00);
INSERT INTO PART
VALUES
  ('KZ09', 'Treadmill', 9, 'SG', '2', 1390.00);
INSERT INTO PART
VALUES
  ('KV29', 'Treadmill', 9, 'SG', '2', 1390.00);
INSERT INTO PART
VALUES
  ('TV09', 'Treadmill', 9, 'SG', '2', 1390.00);


INSERT INTO ORDER_LINE
VALUES
  ('21608', 'AT94', 11, 21.95);
INSERT INTO ORDER_LINE
VALUES
  ('21608', 'BV06', 400.00);
INSERT INTO ORDER_LINE
VALUES
  ('21613', 'DR93', 1, 495.00);
INSERT INTO ORDER_LINE
VALUES
  ('21613', 'DW11', 1, 399.99);
INSERT INTO ORDER_LINE
VALUES
  ('21613', 'KL62', 4, 329.95);
INSERT INTO ORDER_LINE
VALUES
  ('21614', 'KZ09', 2, 595.00);
INSERT INTO ORDER_LINE
VALUES
  ('21617', 'BV06', 2, 794.95);
INSERT INTO ORDER_LINE
VALUES
  ('21617', 'CD52', 4, 150.00);
INSERT INTO ORDER_LINE
VALUES
  ('21619', 'DR93', 1, 495.00);
INSERT INTO ORDER_LINE
VALUES
  ('21619', 'CD52', 795.00);
INSERT INTO ORDER_LINE
VALUES
  ('21619', 'BV06', 2, 794.95);
INSERT INTO ORDER_LINE
VALUES
  ('21619', 'KV39', 1, 800.00);
INSERT INTO ORDER_LINE
VALUES
  ('21623', 'KV29', 21, 290.00);
INSERT INTO ORDER_LINE
VALUES
  ('21623', 'AT94', 11, 21.95);
INSERT INTO ORDER_LINE
VALUES
  ('21623', 'BV06', 410.00);

/*2.*/
SELECT sum(BALANCE) AS total_of_balances
FROM CUSTOMER
GROUP BY REP_NUM
HAVING (count(REP_NUM) >= 2);

/*3*/
SELECT
  sum(NUM_ORDERED * ORDER_LINE.QUOTED_PRICE) AS order_total,
  ORDER_NUM
FROM ORDER_LINE
GROUP BY ORDER_NUM
HAVING sum(NUM_ORDERED * ORDER_LINE.QUOTED_PRICE) > 1000
ORDER BY ORDER_NUM;

/*4*/
SELECT
  CUSTOMER_NUM,
  CUSTOMER_NAME,
  BALANCE,
  REP_NUM
FROM CUSTOMER
WHERE BALANCE < (SELECT min(BALANCE)
                 FROM CUSTOMER
                 WHERE CUSTOMER.REP_NUM = (SELECT REP_NUM
                                           FROM REP
                                           WHERE FIRST_NAME = 'Ann' AND LAST_NAME = 'Hull'));

/*5*/
SELECT
  CUSTOMER_NUM,
  CUSTOMER_NAME,
  BALANCE,
  REP_NUM
FROM CUSTOMER
WHERE BALANCE < (SELECT avg(BALANCE)
                 FROM CUSTOMER
                 WHERE CUSTOMER.REP_NUM = (SELECT REP_NUM
                                           FROM REP
                                           WHERE FIRST_NAME = 'Ann' AND LAST_NAME = 'Hull'));

/*6*/
SELECT
  CUSTOMER_NUM,
  CUSTOMER_NAME
FROM CUSTOMER
WHERE (REP_NUM = (SELECT REP_NUM
                  FROM REP
                  WHERE FIRST_NAME = 'Ann' AND LAST_NAME = 'Hull') AND
       NOT exists(SELECT ORDERS.CUSTOMER_NUM
                  FROM ORDERS
                  WHERE ORDERS.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM));

/*7*/
SELECT
  ORDER_NUM,
  ORDER_DATE
FROM ORDERS
WHERE (CUSTOMER_NUM = (SELECT CUSTOMER_NUM
                       FROM CUSTOMER
                       WHERE CUSTOMER_NAME = 'Brookings Direct') AND ORDER_NUM NOT IN (SELECT ORDER_NUM
                                                                                       FROM ORDER_LINE
                                                                                       WHERE
                                                                                         PART_NUM IN (SELECT PART_NUM
                                                                                                      FROM PART
                                                                                                      WHERE
                                                                                                        DESCRIPTION =
                                                                                                        'Treadmill')));

/*8*/
SELECT DISTINCT
  CUSTOMER_NAME,
  CITY,
  CREDIT_LIMIT,
  sum(QUOTED_PRICE * NUM_ORDERED) AS total_quoted_price
FROM CUSTOMER, ORDERS, ORDER_LINE
WHERE (CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM AND ORDERS.ORDER_NUM IN (SELECT DISTINCT ORDER_NUM
                                                                            FROM ORDER_LINE
                                                                            WHERE PART_NUM IN (SELECT PART_NUM
                                                                                               FROM PART
                                                                                               WHERE DESCRIPTION =
                                                                                                     'Home Gym') AND
                                                                                  ORDER_NUM IN
                                                                                  (SELECT DISTINCT ORDER_NUM
                                                                                   FROM ORDER_LINE
                                                                                   WHERE
                                                                                     PART_NUM IN (SELECT PART_NUM
                                                                                                  FROM PART
                                                                                                  WHERE
                                                                                                    DESCRIPTION =
                                                                                                    'Fireplace'))) AND
       ORDER_LINE.ORDER_NUM = ORDERS.ORDER_NUM)
GROUP BY CUSTOMER_NAME, CITY, CREDIT_LIMIT;

/*9*/
SELECT
  CUSTOMER_NAME,
  BALANCE
FROM CUSTOMER
WHERE NOT exists(SELECT ORDERS.CUSTOMER_NUM
                 FROM ORDERS
                 WHERE ORDERS.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM);

/*10*/
SELECT avg(BALANCE)
FROM CUSTOMER
WHERE (CUSTOMER_NUM IN (SELECT DISTINCT CUSTOMER_NUM
                        FROM ORDERS
                        WHERE (ORDER_NUM IN (SELECT DISTINCT ORDER_NUM
                                             FROM ORDER_LINE
                                             WHERE PART_NUM IN (SELECT DISTINCT PART_NUM
                                                                FROM ORDER_LINE
                                                                GROUP BY PART_NUM
                                                                HAVING sum(NUM_ORDERED) >= 2)))));