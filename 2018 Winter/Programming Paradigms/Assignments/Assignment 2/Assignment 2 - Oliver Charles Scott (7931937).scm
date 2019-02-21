#lang scheme
;Question 1
(define (distanceGPS Latitude_1 Longitude_1 Latitude_2 Longitude_2) (* 6371 (* 2 (asin(sqrt(+(expt(sin(/(-(degrees->radians Latitude_1) (degrees->radians Latitude_2))2))2) (*(*(cos(degrees->radians Latitude_1)) (cos(degrees->radians Latitude_2))) (expt(sin(/(-(degrees->radians Longitude_1) (degrees->radians Longitude_2))2))2))))))))

;Question 2
(define (absDiff List1 List2) (for/list ([i List1] [j List2]) (abs (- i j))))
(define (absDiffA List1 List2) (if (> (length List1) (length List2)) (append (absDiff List1 List2) (drop List1 (length List2))) (append (absDiff List1 List2) (drop List2 (length List1)))))
(define (absDiffB List1 List2) (absDiff List1 List2))

;Question 3
(define (duplicatePair List) (remove-duplicates (map (lambda (x) (append (list x) (count (lambda (y) (eq? x y)) List))) List)))
(define (duplicateList List) (remove-duplicates (map (lambda (x) (append (list x) (list (count (lambda (y) (eq? x y)) List)))) List)))
(define (duplicateListSorted List) (sort (duplicateList List) (lambda (x y) (> (cadr x) (cadr y)))))

;Question 4
(define (children Node Tree) (sort (flatten (if (equal? (car Tree) Node) (cdr Tree) (map (lambda (current) (children Node current)) (cdr Tree)))) >))