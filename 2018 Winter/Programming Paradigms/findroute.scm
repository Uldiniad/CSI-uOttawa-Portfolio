#lang scheme

(define (parse File) (map string-split (file->lines File)))
;converts each line in File into a string and builds a list out of those strings. Then, proceeds to splitting every string in the list by its tokens (substrings).
(define (reversedParse File) (map reverse (parse File)))
;reverses parse
(define (latitudeToNumber File) (map string->number(map car (reversedParse File))))
;converts all latitudes in the reversed parse from string to number
(define (longitudeToNumber File) (map string->number(map cadr (reversedParse File))))
;converts all longitudes in the reversed parse from string to number
(define (name File) (map caddr (reversedParse File)))
;builds a list of the names found in the reversed parse
(define (firstName File) (map cdddr (reversedParse File)))
;builds a list of the firt names found in the reversed parse
(define (fullName File) (map (lambda (Name FirstName) (if (pair? FirstName) (string-append (car FirstName) " " Name) (string-append Name ""))) (name File) (firstName File)))
;appends the first names to their names if the first names are not empty
(define (pools File) (map reverse(map (lambda (Latitude Longitude Name) (append (list Latitude) (list Longitude) (list Name))) (latitudeToNumber File) (longitudeToNumber File) (fullName File))))
;appends the names, latitudes and longitudes so that we now have a processed parse (the first names appended to their names in one string
;and the latitudes and longitudes as floating point numbers). All three as elements of a list.
;Reverse the list to have the name of the pool first, the longitude second and the latitude third (as original parse)
(define (sortPools File) (sort (pools File) (lambda (x y) (< (cadr x) (cadr y)))))
;the longitudes are now numbers and the second element of the list. sort by the second element of the list
;this will result in the list being sorted by longitude. 
(define (root File) (car (sortPools File)))
;the root of the tree will be the westmost node (the head of the sorted list)
(define (distanceBetween Node1 Node2) (distance (cadr Node1) (caddr Node1) (cadr Node2) (caddr Node2)))
;helper function that will extract the latitudes and longitudes of the given nodes to send them to the distance function and will return the result
(define (distance Longitude_1 Latitude_1 Longitude_2 Latitude_2) (* 6371 (* 2 (asin(sqrt(+(expt(sin(/(-(degrees->radians Latitude_1) (degrees->radians Latitude_2))2))2) (*(*(cos(degrees->radians Latitude_1)) (cos(degrees->radians Latitude_2))) (expt(sin(/(-(degrees->radians Longitude_1) (degrees->radians Longitude_2))2))2))))))))
;calculates the distance between geographical coordinates
(define (leastDistant Node PoolList) (car (sort (map (lambda (Current) (append (list(car Current)) (distanceBetween Node Current))) PoolList) (lambda(x y) (< (cdr x) (cdr y))))))
;finds the node from PoolList that is least distant from Node (without coordinates) by building a list based on the distance between Node and all other nodes in PoolList
;then sorting that list and extracting its head (because the head of the sorted built list will be the least distant node).
(define (findInList Node PoolList) (car (filter (lambda (Current) (equal? (car Current) (car (leastDistant Node PoolList)))) PoolList)))
;helper function that will return the node from PoolList that is least distant from Node (with coordinates)
(define (rootLessPools File) (cdr (sortPools File)))
;the tail of the sorted pools
(define (rootChild File) (findInList (root File) (rootLessPools File)))
;find the child of the root in rootLessPools
(define (lessPools File) (remove (rootChild File) (rootLessPools File)))
;list of pools with root nor rootChild missing
(define (initialTree File) (list (root File) (rootChild File)))
;the tree at first will be composed of the root and its child
(define (edgeList File) (list (initialTree File)))
;the first edge in the tree is between the root and its child
(define (buildTree NotAdded EdgeList Added) (if (pair? NotAdded) (buildTree (cdr NotAdded) (append EdgeList (list (list (findInList (car NotAdded) Added) (car NotAdded)))) (append Added (list (car NotAdded)))) (car (list EdgeList))))
;build tree by taking every node in NotAdded and adding them to the tree (which is tracked by Added) and adding an edge between the currently NotAdded node and the closest node in the tree (Added) (does so by using the helper function findInList).
(define (findEdges Node Tree) (filter (lambda (Current) (equal? (caar Current) (car Node))) Tree))
;helper function that will find all edges going out of Node
(define (preorder Node Tree) (if (pair? (findEdges Node Tree)) (append (list Node) (map (lambda (Edge) (preorder (cadr Edge) (remove (list Node (cadr Edge)) Tree))) (findEdges Node Tree))) Node))
;builds a tree out of the preorder traversal of the tree
(define (flattenedPreorder File) (flatten (preorder (root File) (buildTree (lessPools File) (edgeList File) (initialTree File)))))
;flatten the list returned by the preorder traversal
(define (splitByPool FlatPreorder) (if (pair? FlatPreorder) (append (list (take FlatPreorder 3)) (splitByPool (drop FlatPreorder 3)))'()))
;build a list by splitting the flattened list every three elements (name, longitude and latitude)
(define (route File) (splitByPool (flattenedPreorder File)))
;return the list built by splitByPool
(define (sumRoute Route Sum) (if (pair? (cdr Route)) (append (list (list (caar Route) Sum)) (sumRoute (cdr Route) (+ Sum (distanceBetween (car Route) (cadr Route)))))(list(list (caar Route) Sum))))
;build a list by appending the currently traveled distance (the distance between the current node and the previous node added to the total traveled distance so far) for every node of the Route
(define (findRoute File) (sumRoute (route File) 0))
;finds a route for File getting the result from sumRoute (sending it File and an initial traveled distance of 0)
(define (saveRoute Route File) (display-lines-to-file Route File #:mode 'text #:exists 'replace) (file-exists? File))
;saves the Route into File (overwriting file if it exists) and verifies that File was indeed created