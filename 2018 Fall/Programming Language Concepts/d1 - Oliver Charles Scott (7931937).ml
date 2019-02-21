(*** CSI 3520 Devoir 1 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de
   laboratoire via VCL, la version est 4.05.0 *)

(* Vous n'avez pas à comprendre la définition de la fonction "undefined"
   ci-dessous. Une partie de votre travail consiste à remplacer tous les appels
   fonction dans le code ci-dessous avec les réponses exigées. *)


let undefined : unit -> 'a = fun () -> failwith "undefined";;

(* 1. Veuillez définir ces variables avec les valeurs appropriées. 
Assurez-vous que ces instructions sont toutes vérifiées après leur édition. Vous
pouvez le faire en copiant et en collant dans la fenêtre shell exécutant 
OCaml en compilant avec "ocaml" et en chargeant dans la fenetre shell
en cours d'exécution ... dans l'émulateur de terminal ou en utilisant une évaluation
plugin installé dans votre éditeur, par exemple, Ctrl + c puis
Ctrl + e dans Emacs en mode Touareg *)
                                     
(* 1a. Créez une chaîne avec votre prénom *)
let name : string = "Oliver";;

(* 1b. Utilisez un opérateur de chaîne sur la chaîne de 1.a pour créer un
chaîne contenant à la fois votre prénom et votre nom. *)
let fullname : string = "Oliver" ^ " Charles " ^ "Scott";;

(* 1c. Créez une chaîne contenant votre adresse e-mail *)
let email : string = "oscot042@uottawa.ca";;

(* 1d. Remplacer (Other "...") dans class_year avec l'élément approprié
   au dessous de *)
(* ie: remplacer (Other "...") par SecondYear ou ThirdYear  *)
type year = FirstYear | SecondYear | ThirdYear | FourthYear | Other of string;;

let class_year : year = FourthYear;;

(* 1e. Remplacez le .... par une chose que vous espérez apprendre dans
   ce cours *)
let learning : string = "I hope to learn more about concurrency";;

let print = Printf.printf;;

let print_survey () = 
  let string_year = 
    (match class_year with
       | FirstYear -> "2022"
       | SecondYear -> "2021"
       | ThirdYear -> "2020"
       | FourthYear -> "2019"
       | Other s -> "Other: " ^ s
    ) in
    (print "----------------------------------------\n";
     print "Name: %s\n" name;
     print "Email: %s\n" email;
     print "Year: %s\n" string_year; 
     print "%s\n" learning;
     print "----------------------------------------\n\n");;

(* Problème 2 - Remplir les types: *)
(* Remplacez chaque ??? avec le type approprié du correspondant
   expression. Veillez à supprimer les commentaires de chaque sous-problème
   et pour taper le vérifier avant la soumission. *)

(* Notez que les expressions peuvent ne rien faire d’utile - et dans
   fait pourrait même afficher des problèmes intéressants! - mais tout ce que tu devrais
   faire est de remplir le ??? pour les faire vérifier le type. *)

(* Problème 2a. *)
let prob2a : string  = let greet y = "Hello " ^ y in greet "World!";;

(* Problème 2b. *)
let prob2b : float = float_of_int( int_of_float(2.2 +. 7.7));;

(* Problème 2c. *)
let rec prob2c (x : char) : char =
  prob2c ( if true then prob2c x else 'h');;

(* Problème 2d. *)
let rec prob2d (y:bool) (z:bool) : bool =
   prob2d (prob2d z y) (not y);;

(* Problème 3 - Expliquez pourquoi chacun des 3a, 3b, 3c ne compilera pas (utilisez
   les chaînes exp3a, exp3b et exp3c pour vos réponses) et changer
   le code d'une certaine manière pour qu'il le fasse, et laisser prob3a,
   prob3b, et prob3c sans commentaire. Ne changez pas le type de niveau supérieur
   associé à l'expression. *)

(* Problème 3a. *)
let exp3a : string = "Ce n'est pas possible de comparer un int et un float directement";;
let prob3a : bool = 
  let compare x y = x < y in 
  compare 3.9 (float_of_int 4);;

(* Problème 3b. *)
let exp3b : string = "n-1 and x+y need brackets since they need to be evaluated before being fed into the aux function again";;
let prob3b : int = 
  let fib n =
   let rec aux n y x =
    if n <= 0 then x 
    else aux (n-1) (x+y) y 
   in
   aux n 1 0
  in
  fib 10;;

(* Problème 3c. *)
let exp3c : string = "sumTo must be defined recursively so that it can be used within its own definition";;
let prob3c : int =
  let rec sumTo (n:int) : int =
  if n <= 0 then 0
  else n + sumTo (n-1)
  in
  sumTo 10;;

(* Problème 4 *)
(* Remplacez chacun par le type de l'expression correspondante, et
   écrire une fonction f qui a la signature de type correcte. Expliquez dans
   exp4 un problème qui reste avec la fonction prob4 *)

let rec f (a:int) (b:int) : float =
let rec prob4 (x:float) (y:int) : float =
  prob4 (f y 4) (int_of_float x) in
prob4 1.0 2;;

let exp4 : string = "every let that is not top-level requires an in (in this case prob4). f is used within its definition, therefore it must be delcared rec";;

(* Problème 5 *)

(* Vous n'avez pas à comprendre la définition d'exception suivante
   mais vous l'utiliserez ci-dessous. *)

exception BadDivisors of int
let bad_divisors n = raise (BadDivisors n)

let count_divisors n =
let count = ref 0 in
for i = 1 to n do
    if n mod i = 0 then incr count;
done;
!count;;

(* Écrivez la fonction count_divisors, qui prend un paramètre n et
   renvoie le nombre de diviseurs que n a (incluant 1 et n): *)
let _ = count_divisors 17;; (* 2 -- 17 divides only 1 and 17 *)
let _ = count_divisors 4;;  (* 3 -- 4 divides 1, 4, and 2 *)
let _ = count_divisors 18;; (* 6 -- 18 divides 1, 18, 2, 3, 6, and 9 *)
                             
(* La signature de type pour count_divisors est: *)
(*   count_divisors : int -> int *)

(* count_divisors devrait appeler la fonction (bad_divisors n) définie)
   above if n <= 0  *)

(* Vous pouvez écrire autant de fonctions "auxiliaires" que nécessaire
   "let..in" or just "let". *)

(* Après avoir écrit count_divisors ci-dessus, décommentez les lignes suivantes
   pour tester votre code. (Remarque: votre code n'est pas nécessairement complet
   correct juste parce qu'il réussit ces 3 tests. *)

let _ = assert (count_divisors 17 = 2);;
let _ = assert (not (count_divisors 4 = 2));;
let _ = assert (count_divisors 18 = 6);;