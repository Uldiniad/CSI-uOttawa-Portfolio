(* Question de révision 1: les références *)

type point = int ref * int ref

let f (p1:point) (p2:point) : int =
  match (p1,p2) with
  | (x1,y1),(x2,y2) ->
              (x1 := 17;
               let z = !x1 in
               x2 := 42;
               z);;

let point1 = (ref 3, ref 4);;
let point2 = (ref 8, ref 6);;
let a = f point1 point2;;
let b = match point1 with
    (x,y) -> (!x,!y);;
let c = match point2 with
    (x,y) -> (!x,!y);;

let a' = f point1 point1;;
let b' = match point1 with
    (x,y) -> (!x,!y);;

(* Quelles sont les valeurs de a, b, c, a', et b'? *)

(* Question 2: types de données inductifs *)

type tree = 
  | Empty
  | Node of tree * int * tree;;

(* fonction auxiliaire pour la construction d'arbres *)
let leaf (i:int) : tree =
  Node(Empty, i, Empty);;

let t1 = 
  Node(Node(leaf 2, 1, Empty),
       0,
       Node(leaf 7, 6, leaf 8));;

(* Question 2a. Dessinez l'arbre représenté par t1. *)
(* Question 2b. Que fait la fonction suivante? *)

let fun_2b (t:tree) : bool =
  begin match t with
  | Node(Empty,_,Empty) -> true
  | _ -> false
  end

(* Question 2c. Quelle est la valeur de l1 ci-dessous?
   Que fait la fonction fun_2c? *)

let rec fun_2c (t:tree) : int list =
  begin match t with
  | Empty -> []
  | Node(l,n,r) -> n::(fun_2c l)@(fun_2c r)
  end;;

let l1 = fun_2c t1;;

(* Question 3: Programmation d'ordre supérieur et polymorphisme *)

let add (x:int) (y:int) : int = x + y
let mult (x:int) (y:int) : int = x * y
           
let rec fun3 x n =
  match n with
  | 0 -> []
  | n -> if n < 0 then []
         else x::(fun3 x (n-1))

(* Question 3a. Que fait la fonction fun3? *)
(* Question 3b. Quel est le type de la fonction fun3? *)

let a3 = fun3 true 4
let b3 = fun3 add 2
let c3 = fun3 (add 3) 2
let d3 = fun3 (fun3 false 3) 2
                   
(* Question 3c. Quels sont les types et les valeurs de a3, b3, c3, et d3? *)

let e3 = (1,false)
let f3 = [(1,false);(2,true)]
let g3 = ([1;2],[false;true])
let h3 = fun3 4.3
let i3 = fun x -> x < 5
let j3 = [add;mult]

(* Question 3d.  Quels sont les types de e3, f3, g3, h3, i3? *)

(* Question 4. Lambda Calcul
Remarque: "lambda" est noté "|"
Utilisez la beta-réduction et trouvez une expression plus courte pour

(|x.|y.xy)(|x.xy)

 *)
