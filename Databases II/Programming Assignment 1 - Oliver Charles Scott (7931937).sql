-- A)
CREATE TABLE Sailors (
  sid    INTEGER PRIMARY KEY,
  sname  TEXT NOT NULL,
  rating INTEGER,
  age    REAL NOT NULL
);

CREATE TABLE Boats (
  bid   INTEGER PRIMARY KEY,
  bname TEXT NOT NULL,
  color TEXT
);

CREATE TABLE Reserves (
  PRIMARY KEY (sid, bid, day),
  sid INTEGER NOT NULL,
  bid INTEGER NOT NULL,
  day DATE    NOT NULL,
  FOREIGN KEY (sid) REFERENCES Sailors (sid) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (bid) REFERENCES Boats (bid) ON DELETE CASCADE ON UPDATE CASCADE
);

--B)
CREATE OR REPLACE FUNCTION random(names text [])
  RETURNS text AS $$
BEGIN
  RETURN (SELECT (names) [
                 floor(1 + random() * array_length(names, 1)) ]);
END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random(first_date date, last_date date)
  RETURNS date AS $$
BEGIN
  RETURN first_date + make_interval(days := ((random() * (last_date - first_date)) :: integer));
END
$$
LANGUAGE plpgsql;

INSERT INTO Sailors
    (SELECT generate_series(1, 100000),
            random(ARRAY ['Dustin','Brutus','Lubber','Andy','Rusty','Zorba','Horatio','Art','Bob']),
            floor(1 + random() * 10),
            floor(13 + random() * (100 - 13)));

INSERT INTO Boats (SELECT generate_series(1, 100000),
                          random(ARRAY ['Interlake','Clipper','Marine']),
                          random(ARRAY['Blue','Red','Green']));

INSERT INTO Reserves (SELECT sid, bid, date
                      FROM (SELECT generate_series(1, 100000),
                                   floor(1 + random() * (SELECT count(*) FROM Sailors)) as sid,
                                   floor(1 + random() * (SELECT count(*) FROM Boats))   as bid,
                                   random('2018-09-01', '2018-12-31')                   as date) as tmp);

--A)
--Queries
-- 1.
SET ENABLE_SEQSCAN TO TRUE;
EXPLAIN ANALYZE SELECT sname, age
                FROM Sailors;

-- 2.
EXPLAIN ANALYZE SELECT DISTINCT sname, age
                FROM Sailors;

-- 3.
EXPLAIN ANALYZE SELECT *
                FROM Sailors
                WHERE rating > 7;

-- 4.
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid
                  AND bid = 103;

-- 5.
EXPLAIN ANALYZE SELECT DISTINCT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Boats.bid = Reserves.bid
                  AND color = 'Red';

-- 6.
EXPLAIN ANALYZE SELECT DISTINCT color
                FROM Boats,
                     Reserves,
                     Sailors
                WHERE Boats.bid = Reserves.bid
                  AND Sailors.sid = Reserves.sid
                  AND sname = 'Lubber';

-- 7.
EXPLAIN ANALYZE SELECT DISTINCT sname
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid;

-- 8.
EXPLAIN ANALYZE SELECT DISTINCT sname, rating
                FROM Sailors,
                     Reserves AS R1,
                     Reserves AS R2
                WHERE Sailors.sid = R1.sid
                  AND Sailors.sid = R2.sid
                  AND R1.bid != R2.bid
                  AND R1.day = R2.day;

-- 9.
EXPLAIN ANALYZE SELECT age
                FROM Sailors
                WHERE sname LIKE 'B_%b';

-- 10.
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Red'
                UNION
                SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Green';

-- 11.
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Red'
                INTERSECT
                SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Green';

-- 12.
EXPLAIN ANALYZE SELECT sname
                FROM Sailors
                WHERE sid IN (SELECT sid
                              FROM Reserves,
                                   Boats
                              WHERE Boats.bid = Reserves.bid
                                AND color = 'Red'
                                AND sid NOT IN (SELECT sid
                                                FROM Reserves,
                                                     Boats
                                                WHERE Boats.bid = Reserves.bid
                                                  AND color = 'Green'));

-- 13.
EXPLAIN ANALYZE SELECT DISTINCT Sailors.sid
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid
                  AND (rating = 10
                         OR bid = 104);

-- 14.
EXPLAIN ANALYZE SELECT avg(age)
                FROM Sailors;

-- 15.
EXPLAIN ANALYZE SELECT avg(age)
                FROM Sailors
                WHERE rating = 10;

-- 16.
EXPLAIN ANALYZE SELECT sname, age
                FROM Sailors
                WHERE age = (SELECT max(age) FROM Sailors);

-- 17.
EXPLAIN ANALYZE SELECT count(*)
                FROM Sailors;

-- 18.
EXPLAIN ANALYZE SELECT count(DISTINCT sname)
                FROM Sailors;

-- 19.
EXPLAIN ANALYZE SELECT rating, min(age)
                FROM Sailors
                GROUP BY rating;

-- 20.
EXPLAIN ANALYZE SELECT rating, min(age)
                FROM Sailors
                WHERE age >= 18
                GROUP BY rating
                HAVING COUNT(rating) >= 2;

--C)

-- 1. Seq Scan on sailors  (cost=0.00..1233.27 rows=65427 width=36) (actual time=0.002..200.014 rows=100000 loops=1)
-- Planning time: 0.059 ms
-- Execution time: 400.240 ms

-- 2. HashAggregate  (cost=2079.00..2086.83 rows=783 width=10) (actual time=400.254..401.820 rows=783 loops=1)
--   Group Key: sname, age
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.043 rows=100000 loops=1)
-- Planning time: 0.066 ms
-- Execution time: 403.413 ms

-- 3. Seq Scan on sailors  (cost=0.00..1829.00 rows=30290 width=18) (actual time=0.002..60.356 rows=30148 loops=1)
--   Filter: (rating > 7)
--   Rows Removed by Filter: 69852
-- Planning time: 0.074 ms
-- Execution time: 120.673 ms

-- 4. Nested Loop  (cost=0.29..1757.64 rows=2 width=6) (actual time=1.444..10.895 rows=1 loops=1)
--   ->  Seq Scan on reserves  (cost=0.00..1741.00 rows=2 width=4) (actual time=1.436..10.879 rows=1 loops=1)
--         Filter: (bid = 103)
--         Rows Removed by Filter: 99999
--   ->  Index Scan using sailors_pkey on sailors  (cost=0.29..8.31 rows=1 width=10) (actual time=0.002..0.004 rows=1 loops=1)
--         Index Cond: (sid = reserves.sid)
-- Planning time: 0.206 ms
-- Execution time: 10.921 ms

-- 5. HashAggregate  (cost=7598.47..7598.56 rows=9 width=6) (actual time=1198.959..1198.977 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Hash Join  (cost=4853.56..7515.28 rows=33273 width=6) (actual time=665.942..1132.616 rows=33177 loops=1)
--         Hash Cond: (sailors.sid = reserves.sid)
--         ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.091 rows=100000 loops=1)
--         ->  Hash  (cost=4437.64..4437.64 rows=33273 width=4) (actual time=665.860..665.860 rows=33177 loops=1)
--               Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--               ->  Hash Join  (cost=2238.91..4437.64 rows=33273 width=4) (actual time=132.821..599.486 rows=33177 loops=1)
--                     Hash Cond: (reserves.bid = boats.bid)
--                     ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.411 rows=100000 loops=1)
--                     ->  Hash  (cost=1823.00..1823.00 rows=33273 width=4) (actual time=132.743..132.743 rows=33164 loops=1)
--                           Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--                           ->  Seq Scan on boats  (cost=0.00..1823.00 rows=33273 width=4) (actual time=0.002..66.471 rows=33164 loops=1)
--                                 Filter: (color = 'Red'::text)
--                                 Rows Removed by Filter: 66836
-- Planning time: 0.354 ms
-- Execution time: 1199.029 ms

-- 6. HashAggregate  (cost=6783.38..6783.40 rows=3 width=5) (actual time=934.736..934.742 rows=3 loops=1)
--   Group Key: boats.color
--   ->  Hash Join  (cost=4074.75..6756.25 rows=10850 width=5) (actual time=489.738..912.315 rows=11201 loops=1)
--         Hash Cond: (boats.bid = reserves.bid)
--         ->  Seq Scan on boats  (cost=0.00..1573.00 rows=100000 width=9) (actual time=0.002..200.066 rows=100000 loops=1)
--         ->  Hash  (cost=3939.12..3939.12 rows=10850 width=4) (actual time=489.677..489.677 rows=11201 loops=1)
--               Buckets: 16384  Batches: 1  Memory Usage: 327kB
--               ->  Hash Join  (cost=1964.62..3939.12 rows=10850 width=4) (actual time=44.650..467.268 rows=11201 loops=1)
--                     Hash Cond: (reserves.sid = sailors.sid)
--                     ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..199.999 rows=100000 loops=1)
--                     ->  Hash  (cost=1829.00..1829.00 rows=10850 width=4) (actual time=44.625..44.625 rows=11146 loops=1)
--                           Buckets: 16384  Batches: 1  Memory Usage: 326kB
--                           ->  Seq Scan on sailors  (cost=0.00..1829.00 rows=10850 width=4) (actual time=0.002..22.272 rows=11146 loops=1)
--                                 Filter: (sname = 'Lubber'::text)
--                                 Rows Removed by Filter: 88854
-- Planning time: 0.000 ms
-- Execution time: 934.750 ms

-- 7. HashAggregate  (cost=5945.00..5945.09 rows=9 width=6) (actual time=1200.790..1200.806 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Hash Join  (cost=2829.00..5695.00 rows=100000 width=6) (actual time=400.257..1000.707 rows=100000 loops=1)
--         Hash Cond: (reserves.sid = sailors.sid)
--         ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=4) (actual time=0.002..200.365 rows=100000 loops=1)
--         ->  Hash  (cost=1579.00..1579.00 rows=100000 width=10) (actual time=400.251..400.251 rows=100000 loops=1)
--               Buckets: 131072  Batches: 1  Memory Usage: 3551kB
--               ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.151 rows=100000 loops=1)
-- Planning time: 0.000 ms
-- Execution time: 1200.990 ms

-- 8. HashAggregate  (cost=8818.94..8819.84 rows=90 width=10) (actual time=813.435..813.611 rows=88 loops=1)
--   Group Key: sailors.sname, sailors.rating
--   ->  Nested Loop  (cost=2991.29..8814.84 rows=820 width=10) (actual time=401.555..811.828 rows=800 loops=1)
--         ->  Hash Join  (cost=2991.00..8251.99 rows=1599 width=8) (actual time=401.547..802.214 rows=800 loops=1)
--               Hash Cond: ((r1.sid = r2.sid) AND (r1.day = r2.day))
--               Join Filter: (r1.bid <> r2.bid)
--               Rows Removed by Join Filter: 100000
--               ->  Seq Scan on reserves r1  (cost=0.00..1491.00 rows=100000 width=12) (actual time=0.002..200.032 rows=100000 loops=1)
--               ->  Hash  (cost=1491.00..1491.00 rows=100000 width=12) (actual time=400.243..400.243 rows=100000 loops=1)
--                     Buckets: 131072  Batches: 1  Memory Usage: 3637kB
--                     ->  Seq Scan on reserves r2  (cost=0.00..1491.00 rows=100000 width=12) (actual time=0.002..200.127 rows=100000 loops=1)
--         ->  Index Scan using sailors_pkey on sailors  (cost=0.29..0.34 rows=1 width=14) (actual time=0.002..0.004 rows=1 loops=800)
--               Index Cond: (sid = r1.sid)
-- Planning time: 0.471 ms
-- Execution time: 813.825 ms

-- 9. Seq Scan on sailors  (cost=0.00..1829.00 rows=11023 width=4) (actual time=0.026..22.220 rows=11092 loops=1)
--   Filter: (sname ~~ 'B_%b'::text)
--   Rows Removed by Filter: 88908
-- Planning time: 0.070 ms
-- Execution time: 44.422 ms

-- 10. HashAggregate  (cost=16015.57..16685.93 rows=67036 width=6) (actual time=2666.808..2666.828 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Append  (cost=4853.56..15847.98 rows=67036 width=6) (actual time=665.796..2533.558 rows=66579 loops=1)
--         ->  Hash Join  (cost=4853.56..7515.28 rows=33273 width=6) (actual time=665.792..1132.493 rows=33177 loops=1)
--               Hash Cond: (sailors.sid = reserves.sid)
--               ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.189 rows=100000 loops=1)
--               ->  Hash  (cost=4437.64..4437.64 rows=33273 width=4) (actual time=665.778..665.778 rows=33177 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--                     ->  Hash Join  (cost=2238.91..4437.64 rows=33273 width=4) (actual time=132.769..599.371 rows=33177 loops=1)
--                           Hash Cond: (reserves.bid = boats.bid)
--                           ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.174 rows=100000 loops=1)
--                           ->  Hash  (cost=1823.00..1823.00 rows=33273 width=4) (actual time=132.755..132.755 rows=33164 loops=1)
--                                 Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--                                 ->  Seq Scan on boats  (cost=0.00..1823.00 rows=33273 width=4) (actual time=0.002..66.393 rows=33164 loops=1)
--                                       Filter: (color = 'Red'::text)
--                                       Rows Removed by Filter: 66836
--         ->  Hash Join  (cost=4870.70..7662.34 rows=33763 width=6) (actual time=667.566..1134.670 rows=33402 loops=1)
--               Hash Cond: (sailors_1.sid = reserves_1.sid)
--               ->  Seq Scan on sailors sailors_1  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.296 rows=100000 loops=1)
--               ->  Hash  (cost=4448.67..4448.67 rows=33763 width=4) (actual time=667.556..667.556 rows=33402 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                     ->  Hash Join  (cost=2245.04..4448.67 rows=33763 width=4) (actual time=133.683..600.667 rows=33402 loops=1)
--                           Hash Cond: (reserves_1.bid = boats_1.bid)
--                           ->  Seq Scan on reserves reserves_1  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.274 rows=100000 loops=1)
--                           ->  Hash  (cost=1823.00..1823.00 rows=33763 width=4) (actual time=133.657..133.657 rows=33390 loops=1)
--                                 Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                                 ->  Seq Scan on boats boats_1  (cost=0.00..1823.00 rows=33763 width=4) (actual time=0.002..66.850 rows=33390 loops=1)
--                                       Filter: (color = 'Green'::text)
--                                       Rows Removed by Filter: 66610
-- Planning time: 0.000 ms
-- Execution time: 2666.846 ms

-- 11. HashSetOp Intersect  (cost=4853.56..16015.57 rows=9 width=6) (actual time=2933.540..2933.558 rows=9 loops=1)
--   ->  Append  (cost=4853.56..15847.98 rows=67036 width=6) (actual time=665.856..2800.289 rows=66579 loops=1)
--         ->  Subquery Scan on "*SELECT* 1"  (cost=4853.56..7848.01 rows=33273 width=6) (actual time=665.852..1265.419 rows=33177 loops=1)
--               ->  Hash Join  (cost=4853.56..7515.28 rows=33273 width=6) (actual time=665.848..1132.586 rows=33177 loops=1)
--                     Hash Cond: (sailors.sid = reserves.sid)
--                     ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.157 rows=100000 loops=1)
--                     ->  Hash  (cost=4437.64..4437.64 rows=33273 width=4) (actual time=665.834..665.834 rows=33177 loops=1)
--                           Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--                           ->  Hash Join  (cost=2238.91..4437.64 rows=33273 width=4) (actual time=132.771..599.377 rows=33177 loops=1)
--                                 Hash Cond: (reserves.bid = boats.bid)
--                                 ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.237 rows=100000 loops=1)
--                                 ->  Hash  (cost=1823.00..1823.00 rows=33273 width=4) (actual time=132.757..132.757 rows=33164 loops=1)
--                                       Buckets: 65536  Batches: 1  Memory Usage: 1034kB
--                                       ->  Seq Scan on boats  (cost=0.00..1823.00 rows=33273 width=4) (actual time=0.002..66.417 rows=33164 loops=1)
--                                             Filter: (color = 'Red'::text)
--                                             Rows Removed by Filter: 66836
--         ->  Subquery Scan on "*SELECT* 2"  (cost=4870.70..7999.97 rows=33763 width=6) (actual time=667.656..1268.397 rows=33402 loops=1)
--               ->  Hash Join  (cost=4870.70..7662.34 rows=33763 width=6) (actual time=667.652..1134.683 rows=33402 loops=1)
--                     Hash Cond: (sailors_1.sid = reserves_1.sid)
--                     ->  Seq Scan on sailors sailors_1  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.185 rows=100000 loops=1)
--                     ->  Hash  (cost=4448.67..4448.67 rows=33763 width=4) (actual time=667.642..667.642 rows=33402 loops=1)
--                           Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                           ->  Hash Join  (cost=2245.04..4448.67 rows=33763 width=4) (actual time=133.693..600.808 rows=33402 loops=1)
--                                 Hash Cond: (reserves_1.bid = boats_1.bid)
--                                 ->  Seq Scan on reserves reserves_1  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.200 rows=100000 loops=1)
--                                 ->  Hash  (cost=1823.00..1823.00 rows=33763 width=4) (actual time=133.667..133.667 rows=33390 loops=1)
--                                       Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                                       ->  Seq Scan on boats boats_1  (cost=0.00..1823.00 rows=33763 width=4) (actual time=0.002..66.812 rows=33390 loops=1)
--                                             Filter: (color = 'Green'::text)
--                                             Rows Removed by Filter: 66610
-- Planning time: 0.000 ms
-- Execution time: 2933.580 ms

-- 12. Hash Semi Join  (cost=9060.50..11148.92 rows=16600 width=6) (actual time=1087.726..1528.626 rows=20330 loops=1)
--   Hash Cond: (sailors.sid = reserves.sid)
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=10) (actual time=0.002..200.078 rows=100000 loops=1)
--   ->  Hash  (cost=8853.00..8853.00 rows=16600 width=4) (actual time=1087.662..1087.662 rows=23964 loops=1)
--         Buckets: 32768  Batches: 1  Memory Usage: 690kB
--         ->  Hash Join  (cost=6758.50..8853.00 rows=16600 width=4) (actual time=800.250..1039.747 rows=23964 loops=1)
--               Hash Cond: (reserves.bid = boats.bid)
--               ->  Seq Scan on reserves  (cost=4520.50..6261.50 rows=50000 width=8) (actual time=666.570..762.266 rows=47841 loops=1)
--                     Filter: (NOT (hashed SubPlan 1))
--                     Rows Removed by Filter: 52159
--                     SubPlan 1
--                       ->  Hash Join  (cost=2238.75..4437.35 rows=33260 width=4) (actual time=133.365..600.114 rows=33226 loops=1)
--                             Hash Cond: (reserves_1.bid = boats_1.bid)
--                             ->  Seq Scan on reserves reserves_1  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..199.914 rows=100000 loops=1)
--                             ->  Hash  (cost=1823.00..1823.00 rows=33260 width=4) (actual time=133.359..133.359 rows=33317 loops=1)
--                                   Buckets: 65536  Batches: 1  Memory Usage: 1037kB
--                                   ->  Seq Scan on boats boats_1  (cost=0.00..1823.00 rows=33260 width=4) (actual time=0.000..66.657 rows=33317 loops=1)
--                                         Filter: (color = 'Green'::text)
--                                         Rows Removed by Filter: 66683
--               ->  Hash  (cost=1823.00..1823.00 rows=33200 width=4) (actual time=133.605..133.605 rows=33390 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                     ->  Seq Scan on boats  (cost=0.00..1823.00 rows=33200 width=4) (actual time=0.002..66.739 rows=33390 loops=1)
--                           Filter: (color = 'Red'::text)
--                           Rows Removed by Filter: 66610
-- Planning time: 0.867 ms
-- Execution time: 1569.351 ms

-- 13. HashAggregate  (cost=6220.56..6322.78 rows=10222 width=4) (actual time=840.662..853.338 rows=6334 loops=1)
--   Group Key: sailors.sid
--   ->  Hash Join  (cost=2829.00..6195.00 rows=10222 width=4) (actual time=400.412..820.665 rows=9991 loops=1)
--         Hash Cond: (reserves.sid = sailors.sid)
--         Join Filter: ((sailors.rating = 10) OR (reserves.bid = 104))
--         Rows Removed by Join Filter: 90009
--         ->  Seq Scan on reserves  (cost=0.00..1491.00 rows=100000 width=8) (actual time=0.002..200.128 rows=100000 loops=1)
--         ->  Hash  (cost=1579.00..1579.00 rows=100000 width=8) (actual time=400.273..400.273 rows=100000 loops=1)
--               Buckets: 131072  Batches: 1  Memory Usage: 3247kB
--               ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=8) (actual time=0.002..200.105 rows=100000 loops=1)
-- Planning time: 0.213 ms
-- Execution time: 866.213 ms

-- 14. Aggregate  (cost=1829.00..1829.01 rows=1 width=4) (actual time=400.256..400.258 rows=1 loops=1)
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=4) (actual time=0.002..200.060 rows=100000 loops=1)
-- Planning time: 0.060 ms
-- Execution time: 400.291 ms

-- 15. Aggregate  (cost=1854.55..1854.56 rows=1 width=4) (actual time=40.460..40.462 rows=1 loops=1)
--   ->  Seq Scan on sailors  (cost=0.00..1829.00 rows=10220 width=4) (actual time=0.002..20.201 rows=10104 loops=1)
--         Filter: (rating = 10)
--         Rows Removed by Filter: 89896
-- Planning time: 0.073 ms
-- Execution time: 40.497 ms

-- 16. Seq Scan on sailors  (cost=1829.01..3658.01 rows=1149 width=10) (actual time=400.279..402.009 rows=1100 loops=1)
--   Filter: (age = $0)
--   Rows Removed by Filter: 98900
--   InitPlan 1 (returns $0)
--     ->  Aggregate  (cost=1829.00..1829.01 rows=1 width=4) (actual time=400.273..400.275 rows=1 loops=1)
--           ->  Seq Scan on sailors sailors_1  (cost=0.00..1579.00 rows=100000 width=4) (actual time=0.002..200.145 rows=100000 loops=1)
-- Planning time: 0.000 ms
-- Execution time: 404.219 ms

-- 17. Aggregate  (cost=1829.00..1829.01 rows=1 width=0) (actual time=400.233..400.235 rows=1 loops=1)
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=0) (actual time=0.004..200.278 rows=100000 loops=1)
-- Planning time: 0.000 ms
-- Execution time: 400.241 ms

-- 18. Aggregate  (cost=1829.00..1829.01 rows=1 width=6) (actual time=400.306..400.308 rows=1 loops=1)
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=6) (actual time=0.002..200.044 rows=100000 loops=1)
-- Planning time: 0.055 ms
-- Execution time: 400.335 ms

-- 19. HashAggregate  (cost=2079.00..2079.10 rows=10 width=8) (actual time=400.260..400.280 rows=10 loops=1)
--   Group Key: rating
--   ->  Seq Scan on sailors  (cost=0.00..1579.00 rows=100000 width=8) (actual time=0.003..200.153 rows=100000 loops=1)
-- Planning time: 0.000 ms
-- Execution time: 400.304 ms

-- 20. HashAggregate  (cost=2537.47..2537.60 rows=10 width=8) (actual time=377.635..377.655 rows=10 loops=1)
--   Group Key: rating
--   Filter: (count(rating) >= 2)
--   ->  Seq Scan on sailors  (cost=0.00..1829.00 rows=94463 width=8) (actual time=0.002..188.817 rows=94350 loops=1)
--         Filter: (age >= '18'::double precision)
--         Rows Removed by Filter: 5650
-- Planning time: 0.000 ms
-- Execution time: 377.679 ms


--D)
-- 1.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (sname, age);
EXPLAIN ANALYZE SELECT sname, age
                FROM Sailors;
DROP INDEX tmp;

-- Bitmap Heap Scan on sailors  (cost=1805.42..3384.42 rows=100000 width=10) (actual time=10.359..210.517 rows=100000 loops=1)
--   Heap Blocks: exact=579
--   ->  Bitmap Index Scan on tmp  (cost=0.00..1780.42 rows=100000 width=0) (actual time=10.281..10.281 rows=100000 loops=1)
-- Planning time: 0.129 ms
-- Execution time: 410.600 ms

-- Both strategies had negligible difference in execution time

-- 2.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (sname, age);
EXPLAIN ANALYZE SELECT DISTINCT sname, age
                FROM Sailors;
DROP INDEX tmp;

-- Unique  (cost=0.42..5584.00 rows=783 width=10) (actual time=0.050..401.767 rows=783 loops=1)
--   ->  Index Only Scan using tmp on sailors  (cost=0.42..5084.00 rows=100000 width=10) (actual time=0.046..200.101 rows=100000 loops=1)
--         Heap Fetches: 100000
-- Planning time: 0.169 ms
-- Execution time: 403.342 ms

-- Both strategies had negligible difference in execution time

-- 3.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (rating);
EXPLAIN ANALYZE SELECT *
                FROM Sailors
                WHERE rating > 7;
DROP INDEX tmp;

-- Bitmap Heap Scan on sailors  (cost=507.66..1466.28 rows=30370 width=18) (actual time=3.276..63.209 rows=29987 loops=1)
--   Recheck Cond: (rating > 7)
--   Heap Blocks: exact=579
--   ->  Bitmap Index Scan on tmp  (cost=0.00..500.07 rows=30370 width=0) (actual time=3.195..3.195 rows=29987 loops=1)
--         Index Cond: (rating > 7)
-- Planning time: 0.165 ms
-- Execution time: 123.300 ms

-- Both strategies had negligible difference in execution time

-- 4.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Boats
  USING hash (bid);
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid
                  AND bid = 103;
DROP INDEX tmp;

-- Nested Loop  (cost=0.71..2523.08 rows=2 width=6) (actual time=0.242..2.439 rows=3 loops=1)
--   ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..2506.44 rows=2 width=4) (actual time=0.234..2.399 rows=3 loops=1)
--         Index Cond: (bid = 103)
--         Heap Fetches: 3
--   ->  Index Scan using sailors_pkey on sailors  (cost=0.29..8.31 rows=1 width=10) (actual time=0.002..0.004 rows=1 loops=3)
--         Index Cond: (sid = reserves.sid)
-- Planning time: 0.216 ms
-- Execution time: 2.475 ms

-- The index strategy was 5 times faster.

-- 5.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Boats
  USING hash (color);
EXPLAIN ANALYZE SELECT DISTINCT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Boats.bid = Reserves.bid
                  AND color = 'Red';
DROP INDEX tmp;

-- HashAggregate  (cost=13072.94..13073.03 rows=9 width=6) (actual time=1471.763..1471.781 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Hash Join  (cost=2605.24..12989.94 rows=33200 width=6) (actual time=137.362..1404.986 rows=33401 loops=1)
--         Hash Cond: (reserves.bid = boats.bid)
--         ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=10) (actual time=0.014..1000.679 rows=100000 loops=1)
--               Merge Cond: (sailors.sid = reserves.sid)
--               ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.002..200.109 rows=100000 loops=1)
--               ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.003..200.197 rows=100000 loops=1)
--                     Heap Fetches: 100000
--         ->  Hash  (cost=2189.30..2189.30 rows=33200 width=4) (actual time=137.260..137.260 rows=33390 loops=1)
--               Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--               ->  Bitmap Heap Scan on boats  (cost=1201.30..2189.30 rows=33200 width=4) (actual time=3.613..70.398 rows=33390 loops=1)
--                     Recheck Cond: (color = 'Red'::text)
--                     Heap Blocks: exact=573
--                     ->  Bitmap Index Scan on tmp  (cost=0.00..1193.00 rows=33200 width=0) (actual time=3.538..3.538 rows=33390 loops=1)
--                           Index Cond: (color = 'Red'::text)
-- Planning time: 0.430 ms
-- Execution time: 1471.840 ms

-- The sequential scan strategy was faster by around 300ms.

-- 6.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors
  USING hash (sname);
EXPLAIN ANALYZE SELECT DISTINCT color
                FROM Boats,
                     Reserves,
                     Sailors
                WHERE Boats.bid = Reserves.bid
                  AND Sailors.sid = Reserves.sid
                  AND sname = 'Lubber';
DROP INDEX tmp;

-- HashAggregate  (cost=10888.00..10888.03 rows=3 width=5) (actual time=623.944..623.950 rows=3 loops=1)
--   Group Key: boats.color
--   ->  Nested Loop  (cost=1259.14..10860.26 rows=11097 width=5) (actual time=45.595..601.657 rows=11126 loops=1)
--         ->  Hash Join  (cost=1258.84..6956.78 rows=11097 width=4) (actual time=45.589..468.171 rows=11126 loops=1)
--               Hash Cond: (reserves.sid = sailors.sid)
--               ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.146 rows=100000 loops=1)
--                     Heap Fetches: 100000
--               ->  Hash  (cost=1119.71..1119.71 rows=11097 width=4) (actual time=45.546..45.546 rows=11056 loops=1)
--                     Buckets: 16384  Batches: 1  Memory Usage: 324kB
--                     ->  Bitmap Heap Scan on sailors  (cost=402.00..1119.71 rows=11097 width=4) (actual time=1.274..23.441 rows=11056 loops=1)
--                           Recheck Cond: (sname = 'Lubber'::text)
--                           Heap Blocks: exact=579
--                           ->  Bitmap Index Scan on tmp  (cost=0.00..399.23 rows=11097 width=0) (actual time=1.200..1.200 rows=11056 loops=1)
--                                 Index Cond: (sname = 'Lubber'::text)
--         ->  Index Scan using boats_pkey on boats  (cost=0.29..0.34 rows=1 width=9) (actual time=0.002..0.004 rows=1 loops=11126)
--               Index Cond: (bid = reserves.bid)
-- Planning time: 0.393 ms
-- Execution time: 623.993 ms

-- The index strategy was faster by around 300ms.

-- 7.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (sid, sname);
EXPLAIN ANALYZE SELECT DISTINCT sname
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid;
DROP INDEX tmp;

-- HashAggregate  (cost=9928.64..9928.73 rows=9 width=6) (actual time=1200.775..1200.791 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=6) (actual time=0.014..1000.450 rows=100000 loops=1)
--         Merge Cond: (sailors.sid = reserves.sid)
--         ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.002..199.974 rows=100000 loops=1)
--         ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=4) (actual time=0.003..200.208 rows=100000 loops=1)
--               Heap Fetches: 100000
-- Planning time: 0.302 ms
-- Execution time: 1200.842 ms

-- Both strategies had negligible difference in execution time

-- 8.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (sid);
EXPLAIN ANALYZE SELECT DISTINCT sname, rating
                FROM Sailors,
                     Reserves AS R1,
                     Reserves AS R2
                WHERE Sailors.sid = R1.sid
                  AND Sailors.sid = R2.sid
                  AND R1.bid != R2.bid
                  AND R1.day = R2.day;
DROP INDEX tmp;

-- HashAggregate  (cost=15148.86..15149.76 rows=90 width=10) (actual time=1614.275..1614.456 rows=90 loops=1)
--   Group Key: sailors.sname, sailors.rating
--   ->  Nested Loop  (cost=1.13..15144.76 rows=820 width=10) (actual time=10.774..1612.623 rows=824 loops=1)
--         ->  Merge Join  (cost=0.83..14581.21 rows=1601 width=8) (actual time=10.766..1602.739 rows=824 loops=1)
--               Merge Cond: (r1.sid = r2.sid)
--               Join Filter: ((r1.bid <> r2.bid) AND (r1.day = r2.day))
--               Rows Removed by Join Filter: 199164
--               ->  Index Only Scan using reserves_pkey on reserves r1  (cost=0.42..5212.38 rows=100000 width=12) (actual time=0.002..200.319 rows=100000 loops=1)
--                     Heap Fetches: 100000
--               ->  Materialize  (cost=0.42..5462.38 rows=100000 width=12) (actual time=0.006..800.630 rows=199988 loops=1)
--                     ->  Index Only Scan using reserves_pkey on reserves r2  (cost=0.42..5212.38 rows=100000 width=12) (actual time=0.002..200.419 rows=100000 loops=1)
--                           Heap Fetches: 100000
--         ->  Index Scan using tmp on sailors  (cost=0.29..0.34 rows=1 width=14) (actual time=0.002..0.004 rows=1 loops=824)
--               Index Cond: (sid = r1.sid)
-- Planning time: 0.639 ms
-- Execution time: 1614.675 ms

-- The sequential scan strategy was about two times faster.

-- 9.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (sname);
EXPLAIN ANALYZE SELECT age
                FROM Sailors
                WHERE sname LIKE 'B_%b';
DROP INDEX tmp;

-- Bitmap Heap Scan on sailors  (cost=461.58..1318.70 rows=11143 width=4) (actual time=4.413..27.007 rows=11290 loops=1)
--   Filter: (sname ~~ 'B_%b'::text)
--   Rows Removed by Filter: 11145
--   Heap Blocks: exact=579
--   ->  Bitmap Index Scan on tmp  (cost=0.00..458.79 rows=22250 width=0) (actual time=4.334..4.334 rows=22435 loops=1)
--         Index Cond: ((sname >= 'B'::text) AND (sname < 'C'::text))
-- Planning time: 0.247 ms
-- Execution time: 49.601 ms

-- Both strategies had negligible difference in execution time

-- 10.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Boats
  USING hash (color);
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Red'
                UNION
                SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Green';
DROP INDEX tmp;

-- HashAggregate  (cost=26813.20..27477.80 rows=66460 width=6) (actual time=3205.844..3205.859 rows=9 loops=1)
--   Group Key: sailors.sname
--   ->  Append  (cost=2605.24..26647.05 rows=66460 width=6) (actual time=137.535..3072.390 rows=66627 loops=1)
--         ->  Hash Join  (cost=2605.24..12989.94 rows=33200 width=6) (actual time=137.531..1405.092 rows=33401 loops=1)
--               Hash Cond: (reserves.bid = boats.bid)
--               ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=10) (actual time=0.013..1000.518 rows=100000 loops=1)
--                     Merge Cond: (sailors.sid = reserves.sid)
--                     ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.003..200.264 rows=100000 loops=1)
--                     ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.203 rows=100000 loops=1)
--                           Heap Fetches: 100000
--               ->  Hash  (cost=2189.30..2189.30 rows=33200 width=4) (actual time=137.342..137.342 rows=33390 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                     ->  Bitmap Heap Scan on boats  (cost=1201.30..2189.30 rows=33200 width=4) (actual time=3.677..70.493 rows=33390 loops=1)
--                           Recheck Cond: (color = 'Red'::text)
--                           Heap Blocks: exact=573
--                           ->  Bitmap Index Scan on tmp  (cost=0.00..1193.00 rows=33200 width=0) (actual time=3.601..3.601 rows=33390 loops=1)
--                                 Index Cond: (color = 'Red'::text)
--         ->  Hash Join  (cost=2607.20..12992.51 rows=33260 width=6) (actual time=133.381..1400.727 rows=33226 loops=1)
--               Hash Cond: (reserves_1.bid = boats_1.bid)
--               ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=10) (actual time=0.014..1000.557 rows=100000 loops=1)
--                     Merge Cond: (sailors_1.sid = reserves_1.sid)
--                     ->  Index Scan using sailors_pkey on sailors sailors_1  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.002..200.173 rows=100000 loops=1)
--                     ->  Index Only Scan using reserves_pkey on reserves reserves_1  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.300 rows=100000 loops=1)
--                           Heap Fetches: 100000
--               ->  Hash  (cost=2190.52..2190.52 rows=33260 width=4) (actual time=133.363..133.363 rows=33317 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1037kB
--                     ->  Bitmap Heap Scan on boats boats_1  (cost=1201.77..2190.52 rows=33260 width=4) (actual time=0.002..66.727 rows=33317 loops=1)
--                           Recheck Cond: (color = 'Green'::text)
--                           Heap Blocks: exact=573
--                           ->  Bitmap Index Scan on tmp  (cost=0.00..1193.45 rows=33260 width=0) (actual time=0.000..0.000 rows=33317 loops=1)
--                                 Index Cond: (color = 'Green'::text)
-- Planning time: 0.657 ms
-- Execution time: 3206.094 ms

-- The sequential scan strategy was about two times faster.

-- 11.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Boats
  USING hash (color);
EXPLAIN ANALYZE SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Red'
                INTERSECT
                SELECT sname
                FROM Sailors,
                     Reserves,
                     Boats
                WHERE Sailors.sid = Reserves.sid
                  AND Reserves.bid = Boats.bid
                  AND color = 'Green';
DROP INDEX tmp;

-- HashSetOp Intersect  (cost=2605.24..26813.20 rows=9 width=6) (actual time=3472.299..3472.317 rows=9 loops=1)
--   ->  Append  (cost=2605.24..26647.05 rows=66460 width=6) (actual time=137.349..3338.848 rows=66627 loops=1)
--         ->  Subquery Scan on "*SELECT* 1"  (cost=2605.24..13321.94 rows=33200 width=6) (actual time=137.345..1538.634 rows=33401 loops=1)
--               ->  Hash Join  (cost=2605.24..12989.94 rows=33200 width=6) (actual time=137.341..1404.986 rows=33401 loops=1)
--                     Hash Cond: (reserves.bid = boats.bid)
--                     ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=10) (actual time=0.014..1000.726 rows=100000 loops=1)
--                           Merge Cond: (sailors.sid = reserves.sid)
--                           ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.002..200.117 rows=100000 loops=1)
--                           ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.147 rows=100000 loops=1)
--                                 Heap Fetches: 100000
--                     ->  Hash  (cost=2189.30..2189.30 rows=33200 width=4) (actual time=137.243..137.243 rows=33390 loops=1)
--                           Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                           ->  Bitmap Heap Scan on boats  (cost=1201.30..2189.30 rows=33200 width=4) (actual time=3.603..70.491 rows=33390 loops=1)
--                                 Recheck Cond: (color = 'Red'::text)
--                                 Heap Blocks: exact=573
--                                 ->  Bitmap Index Scan on tmp  (cost=0.00..1193.00 rows=33200 width=0) (actual time=3.527..3.527 rows=33390 loops=1)
--                                       Index Cond: (color = 'Red'::text)
--         ->  Subquery Scan on "*SELECT* 2"  (cost=2607.20..13325.11 rows=33260 width=6) (actual time=133.382..1533.629 rows=33226 loops=1)
--               ->  Hash Join  (cost=2607.20..12992.51 rows=33260 width=6) (actual time=133.378..1400.599 rows=33226 loops=1)
--                     Hash Cond: (reserves_1.bid = boats_1.bid)
--                     ->  Merge Join  (cost=0.94..9678.64 rows=100000 width=10) (actual time=0.014..1000.767 rows=100000 loops=1)
--                           Merge Cond: (sailors_1.sid = reserves_1.sid)
--                           ->  Index Scan using sailors_pkey on sailors sailors_1  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.003..200.062 rows=100000 loops=1)
--                           ->  Index Only Scan using reserves_pkey on reserves reserves_1  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.251 rows=100000 loops=1)
--                                 Heap Fetches: 100000
--                     ->  Hash  (cost=2190.52..2190.52 rows=33260 width=4) (actual time=133.360..133.360 rows=33317 loops=1)
--                           Buckets: 65536  Batches: 1  Memory Usage: 1037kB
--                           ->  Bitmap Heap Scan on boats boats_1  (cost=1201.77..2190.52 rows=33260 width=4) (actual time=0.003..66.728 rows=33317 loops=1)
--                                 Recheck Cond: (color = 'Green'::text)
--                                 Heap Blocks: exact=573
--                                 ->  Bitmap Index Scan on tmp  (cost=0.00..1193.45 rows=33260 width=0) (actual time=0.001..0.001 rows=33317 loops=1)
--                                       Index Cond: (color = 'Green'::text)
-- Planning time: 0.679 ms
-- Execution time: 3472.393 ms

-- The sequential scan strategy was faster by around 500ms.

-- 12.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Boats
  USING hash (color);
EXPLAIN ANALYZE SELECT sname
                FROM Sailors
                WHERE sid IN (SELECT sid
                              FROM Reserves,
                                   Boats
                              WHERE Boats.bid = Reserves.bid
                                AND color = 'Red'
                                AND sid NOT IN (SELECT sid
                                                FROM Reserves,
                                                     Boats
                                                WHERE Boats.bid = Reserves.bid
                                                  AND color = 'Green'));
DROP INDEX tmp;

-- Hash Semi Join  (cost=17237.38..20712.80 rows=16600 width=6) (actual time=1091.429..1532.353 rows=20330 loops=1)
--   Hash Cond: (sailors.sid = reserves.sid)
--   ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=10) (actual time=0.002..200.113 rows=100000 loops=1)
--   ->  Hash  (cost=17029.58..17029.58 rows=16600 width=4) (actual time=1091.369..1091.369 rows=23964 loops=1)
--         Buckets: 32768  Batches: 1  Memory Usage: 690kB
--         ->  Hash Join  (cost=11214.12..17029.58 rows=16600 width=4) (actual time=803.995..1043.397 rows=23964 loops=1)
--               Hash Cond: (reserves.bid = boats.bid)
--               ->  Index Only Scan using reserves_pkey on reserves  (cost=8609.82..14071.78 rows=50000 width=8) (actual time=666.656..762.574 rows=47841 loops=1)
--                     Filter: (NOT (hashed SubPlan 1))
--                     Rows Removed by Filter: 52159
--                     Heap Fetches: 100000
--                     SubPlan 1
--                       ->  Hash Join  (cost=2606.68..8526.25 rows=33260 width=4) (actual time=133.375..600.175 rows=33226 loops=1)
--                             Hash Cond: (reserves_1.bid = boats_1.bid)
--                             ->  Index Only Scan using reserves_pkey on reserves reserves_1  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.002..200.148 rows=100000 loops=1)
--                                   Heap Fetches: 100000
--                             ->  Hash  (cost=2190.52..2190.52 rows=33260 width=4) (actual time=133.369..133.369 rows=33317 loops=1)
--                                   Buckets: 65536  Batches: 1  Memory Usage: 1037kB
--                                   ->  Bitmap Heap Scan on boats boats_1  (cost=1201.77..2190.52 rows=33260 width=4) (actual time=0.002..66.747 rows=33317 loops=1)
--                                         Recheck Cond: (color = 'Green'::text)
--                                         Heap Blocks: exact=573
--                                         ->  Bitmap Index Scan on tmp  (cost=0.00..1193.45 rows=33260 width=0) (actual time=0.000..0.000 rows=33317 loops=1)
--                                               Index Cond: (color = 'Green'::text)
--               ->  Hash  (cost=2189.30..2189.30 rows=33200 width=4) (actual time=137.273..137.273 rows=33390 loops=1)
--                     Buckets: 65536  Batches: 1  Memory Usage: 1039kB
--                     ->  Bitmap Heap Scan on boats  (cost=1201.30..2189.30 rows=33200 width=4) (actual time=3.638..70.383 rows=33390 loops=1)
--                           Recheck Cond: (color = 'Red'::text)
--                           Heap Blocks: exact=573
--                           ->  Bitmap Index Scan on tmp  (cost=0.00..1193.00 rows=33200 width=0) (actual time=3.561..3.561 rows=33390 loops=1)
--                                 Index Cond: (color = 'Red'::text)
-- Planning time: 0.486 ms
-- Execution time: 1573.126 ms

-- Both strategies had negligible difference in execution time

-- 13.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors
  USING hash (rating);
CREATE INDEX tmp2
  ON Reserves
  USING hash (bid);
EXPLAIN ANALYZE SELECT DISTINCT Sailors.sid
                FROM Sailors,
                     Reserves
                WHERE Sailors.sid = Reserves.sid
                  AND (rating = 10
                         OR bid = 104);
DROP INDEX tmp;
DROP INDEX tmp2;

-- Unique  (cost=0.94..10203.95 rows=10122 width=4) (actual time=0.172..853.387 rows=6331 loops=1)
--   ->  Merge Join  (cost=0.94..10178.64 rows=10122 width=4) (actual time=0.168..820.675 rows=10018 loops=1)
--         Merge Cond: (sailors.sid = reserves.sid)
--         Join Filter: ((sailors.rating = 10) OR (reserves.bid = 104))
--         Rows Removed by Join Filter: 89982
--         ->  Index Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=8) (actual time=0.002..200.163 rows=100000 loops=1)
--         ->  Index Only Scan using reserves_pkey on reserves  (cost=0.42..5212.38 rows=100000 width=8) (actual time=0.028..200.177 rows=100000 loops=1)
--               Heap Fetches: 100000
-- Planning time: 0.350 ms
-- Execution time: 866.093 ms

-- Both strategies had negligible difference in execution time

-- 14.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (age);
EXPLAIN ANALYZE SELECT avg(age)
                FROM Sailors;
DROP INDEX tmp;

-- Aggregate  (cost=3238.30..3238.31 rows=1 width=4) (actual time=410.507..410.511 rows=1 loops=1)
--   ->  Bitmap Heap Scan on sailors  (cost=1409.29..2988.29 rows=100000 width=4) (actual time=10.254..210.429 rows=100000 loops=1)
--         Heap Blocks: exact=579
--         ->  Bitmap Index Scan on tmp  (cost=0.00..1384.29 rows=100000 width=0) (actual time=10.160..10.160 rows=100000 loops=1)
-- Planning time: 0.136 ms
-- Execution time: 410.548 ms

-- Both strategies had negligible difference in execution time

-- 15.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (rating, age);
EXPLAIN ANALYZE SELECT avg(age)
                FROM Sailors
                WHERE rating = 10;
DROP INDEX tmp;

-- Aggregate  (cost=921.52..921.53 rows=1 width=4) (actual time=42.083..42.085 rows=1 loops=1)
--   ->  Bitmap Heap Scan on sailors  (cost=190.72..896.22 rows=10120 width=4) (actual time=1.805..21.943 rows=10063 loops=1)
--         Recheck Cond: (rating = 10)
--         Heap Blocks: exact=579
--         ->  Bitmap Index Scan on tmp  (cost=0.00..188.19 rows=10120 width=0) (actual time=1.708..1.708 rows=10063 loops=1)
--               Index Cond: (rating = 10)
-- Planning time: 0.209 ms
-- Execution time: 42.134 ms

-- Both strategies had negligible difference in execution time

-- 16.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors(age)
EXPLAIN ANALYZE SELECT sname, age
                FROM Sailors
                WHERE age = (SELECT max(age) FROM Sailors);
DROP INDEX tmp;

-- Bitmap Heap Scan on sailors  (cost=10000001869.91..10000002464.27 rows=1149 width=10) (actual time=400.269..402.565 rows=1146 loops=1)
--   Recheck Cond: (age = $0)
--   Heap Blocks: exact=490
--   InitPlan 1 (returns $0)
--     ->  Aggregate  (cost=10000001829.00..10000001829.01 rows=1 width=4) (actual time=400.261..400.263 rows=1 loops=1)
--           ->  Seq Scan on sailors sailors_1  (cost=10000000000.00..10000001579.00 rows=100000 width=4) (actual time=0.002..200.115 rows=100000 loops=1)
--   ->  Bitmap Index Scan on tmp  (cost=0.00..40.62 rows=1149 width=0) (actual time=400.267..400.267 rows=1146 loops=1)
--         Index Cond: (age = $0)
-- Planning time: 0.199 ms
-- Execution time: 404.887 ms

-- Both strategies had negligible difference in execution time

-- 17.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors
  USING hash (sid);
EXPLAIN ANALYZE SELECT count(*)
                FROM Sailors;
DROP INDEX tmp;

-- Aggregate  (cost=3216.29..3216.30 rows=1 width=0) (actual time=400.248..400.250 rows=1 loops=1)
--   ->  Index Only Scan using sailors_pkey on sailors  (cost=0.29..2966.29 rows=100000 width=0) (actual time=0.031..200.246 rows=100000 loops=1)
--         Heap Fetches: 100000
-- Planning time: 0.094 ms
-- Execution time: 400.274 ms

-- Both strategies had negligible difference in execution time

-- 18.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors
  USING hash (sname);
EXPLAIN ANALYZE SELECT count(DISTINCT sname)
                FROM Sailors;
DROP INDEX tmp;

-- Aggregate  (cost=10000001829.00..10000001829.01 rows=1 width=6) (actual time=400.225..400.227 rows=1 loops=1)
--   ->  Seq Scan on sailors  (cost=10000000000.00..10000001579.00 rows=100000 width=6) (actual time=0.002..200.131 rows=100000 loops=1)
-- Planning time: 0.094 ms
-- Execution time: 400.253 ms

-- Both strategies had negligible difference in execution time

-- 19.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (rating, age);
EXPLAIN ANALYZE SELECT rating, min(age)
                FROM Sailors
                GROUP BY rating;
DROP INDEX tmp;

-- GroupAggregate  (cost=0.29..5410.15 rows=10 width=8) (actual time=40.558..399.772 rows=10 loops=1)
--   Group Key: rating
--   ->  Index Only Scan using tmp on sailors  (cost=0.29..4910.05 rows=100000 width=8) (actual time=0.036..199.674 rows=100000 loops=1)
--         Heap Fetches: 100000
-- Planning time: 0.145 ms
-- Execution time: 399.817 ms

-- Both strategies had negligible difference in execution time

-- 20.
SET ENABLE_SEQSCAN TO FALSE;
CREATE INDEX tmp
  ON Sailors (rating, age);
EXPLAIN ANALYZE SELECT rating, min(age)
                FROM Sailors
                WHERE age >= 18
                GROUP BY rating
                HAVING COUNT(rating) >= 2;
DROP INDEX tmp;

-- HashAggregate  (cost=4339.77..4339.89 rows=10 width=8) (actual time=388.439..388.459 rows=10 loops=1)
--   Group Key: rating
--   Filter: (count(rating) >= 2)
--   ->  Bitmap Heap Scan on sailors  (cost=1877.83..3633.67 rows=94147 width=8) (actual time=11.354..199.830 rows=94210 loops=1)
--         Recheck Cond: (age >= '18'::double precision)
--         Heap Blocks: exact=579
--         ->  Bitmap Index Scan on tmp  (cost=0.00..1854.29 rows=94147 width=0) (actual time=11.278..11.278 rows=94210 loops=1)
--               Index Cond: (age >= '18'::double precision)
-- Planning time: 0.168 ms
-- Execution time: 388.512 ms

-- Both strategies had negligible difference in execution time


-- TEST
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (22, 'Dustin', 7, 45.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (29, 'Brutus', 1, 33.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (31, 'Lubber', 8, 55.5);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (32, 'Andy', 1, 25.5);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (58, 'Rusty', 10, 35.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (64, 'Horatio', 7, 35.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (71, 'Zorba', 10, 16.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (74, 'Horatio', 9, 35.0);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (85, 'Art', 3, 25.5);
-- INSERT INTO Sailors (sid, sname, rating, age)
-- VALUES (95, 'Bob', 3, 63.5);
--
-- INSERT INTO Boats (bid, bname, color)
-- VALUES (101, 'Interlake', 'Blue');
-- INSERT INTO Boats (bid, bname, color)
-- VALUES (102, 'Interlake', 'Red');
-- INSERT INTO Boats (bid, bname, color)
-- VALUES (103, 'Clipper', 'Green');
-- INSERT INTO Boats (bid, bname, color)
-- VALUES (104, 'Marine', 'Red');
--
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (22, 101, '10 / 10 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (22, 102, '10 / 10 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (22, 103, '10 / 8 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (22, 104, '10 / 7 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (31, 102, '11 / 10 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (31, 103, '11 / 6 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (31, 104, '11 / 12 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (64, 101, '9 / 5 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (64, 102, '9 / 8 / 98');
-- INSERT INTO Reserves (sid, bid, day)
-- VALUES (74, 103, '9 / 8 / 98');