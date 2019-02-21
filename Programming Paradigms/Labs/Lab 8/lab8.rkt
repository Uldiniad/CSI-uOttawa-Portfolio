#lang racket

(cons 3 '(4))
(cons 1 '(2 3))
(cons 'a '((b c)))
(cons '1 '())
(cons '2'((3(4))))

(define (range x y)(for/list ([i (in-range x (+ y 1))]) i))