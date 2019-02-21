#lang racket

(define (range x y) (for/list ([i (in-range x (+ y 1))]) i))

(define (remove-at List Position) (remove (list-ref List Position) List))

(define (insert-at Element List Position) (append (take List Position) (list Element) (drop List Position)))

(define (random-select List Num) (map (append (list-ref List (random (length List)))) List))

(define (random-permutation List) (list-ref (permutations List) (random (length List))))