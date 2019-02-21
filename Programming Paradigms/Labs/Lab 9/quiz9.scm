#lang scheme
(let ((a 5) (b 2))
  (let f ((k a)(acc b)) (if (= k 1) acc (f (- k 1) (* b acc)))))