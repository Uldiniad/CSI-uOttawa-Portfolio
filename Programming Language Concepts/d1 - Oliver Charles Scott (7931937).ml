(*** CSI 3520 Devoir 1 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de
   laboratoire via VCL, la version est 4.05.0 *)

(* Vous n'avez pas � comprendre la d�finition de la fonction "undefined"
   ci-dessous. Une partie de votre travail consiste � remplacer tous les appels
   fonction dans le code ci-dessous avec les r�ponses exig�es. *)


let undefined : unit -> 'a = fun () -> failwith "undefined";;

(* 1. Veuillez d�finir ces variables avec les valeurs appropri�es. 
Assurez-vous que ces instructions sont toutes v�rifi�es apr�s leur �dition. Vous
pouvez le faire en copiant et en collant dans la fen�tre shell ex�cutant 
OCaml en compilant avec "ocaml" et en chargeant dans la fenetre shell
en cours d'ex�cution ... dans l'�mulateur de terminal ou en utilisant une �valuation
plugin install� dans votre �diteur, par exemple, Ctrl + c puis
Ctrl + e dans Emacs en mode Touareg *)
                                     
(* 1a. Cr�ez une cha�ne avec votre pr�nom *)
let name : string = "Oliver";;

(* 1b. Utilisez un op�rateur de cha�ne sur la cha�ne de 1.a pour cr�er un
cha�ne contenant � la fois votre pr�nom et votre nom. *)
let fullname : string = "Oliver" ^ " Charles " ^ "Scott";;

(* 1c. Cr�ez une cha�ne contenant votre adresse e-mail *)
let email : string = "oscot042@uottawa.ca";;

(* 1d. Remplacer (Other "...") dans class_year avec l'�l�ment appropri�
   au dessous de *)
(* ie: remplacer (Other "...") par SecondYear ou ThirdYear  *)
type year = FirstYear | SecondYear | ThirdYear | FourthYear | Other of string;;

let class_year : year = FourthYear;;

(* 1e. Remplacez le .... par une chose que vous esp�rez apprendre dans
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

(* Probl�me 2 - Remplir les types: *)
(* Remplacez chaque ??? avec le type appropri� du correspondant
   expression. Veillez � supprimer les commentaires de chaque sous-probl�me
   et pour taper le v�rifier avant la soumission. *)

(* Notez que les expressions peuvent ne rien faire d�utile - et dans
   fait pourrait m�me afficher des probl�mes int�ressants! - mais tout ce que tu devrais
   faire est de remplir le ??? pour les faire v�rifier le type. *)

(* Probl�me 2a. *)
let prob2a : string  = let greet y = "Hello " ^ y in greet "World!";;

(* Probl�me 2b. *)
let prob2b : float = float_of_int( int_of_float(2.2 +. 7.7));;

(* Probl�me 2c. *)
let rec prob2c (x : char) : char =
  prob2c ( if true then prob2c x else 'h');;

(* Probl�me 2d. *)
let rec prob2d (y:bool) (z:bool) : bool =
   prob2d (prob2d z y) (not y);;

(* Probl�me 3 - Expliquez pourquoi chacun des 3a, 3b, 3c ne compilera pas (utilisez
   les cha�nes exp3a, exp3b et exp3c pour vos r�ponses) et changer
   le code d'une certaine mani�re pour qu'il le fasse, et laisser prob3a,
   prob3b, et prob3c sans commentaire. Ne changez pas le type de niveau sup�rieur
   associ� � l'expression. *)

(* Probl�me 3a. *)
let exp3a : string = "Ce n'est pas possible de comparer un int et un float directement";;
let prob3a : bool = 
  let compare x y = x < y in 
  compare 3.9 (float_of_int 4);;

(* Probl�me 3b. *)
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

(* Probl�me 3c. *)
let exp3c : string = "sumTo must be defined recursively so that it can be used within its own definition";;
let prob3c : int =
  let rec sumTo (n:int) : int =
  if n <= 0 then 0
  else n + sumTo (n-1)
  in
  sumTo 10;;

(* Probl�me 4 *)
(* Remplacez chacun par le type de l'expression correspondante, et
   �crire une fonction f qui a la signature de type correcte. Expliquez dans
   exp4 un probl�me qui reste avec la fonction prob4 *)

let rec f (a:int) (b:int) : float =
let rec prob4 (x:float) (y:int) : float =
  prob4 (f y 4) (int_of_float x) in
prob4 1.0 2;;

let exp4 : string = "every let that is not top-level requires an in (in this case prob4). f is used within its definition, therefore it must be delcared rec";;

(* Probl�me 5 *)

(* Vous n'avez pas � comprendre la d�finition d'exception suivante
   mais vous l'utiliserez ci-dessous. *)

exception BadDivisors of int
let bad_divisors n = raise (BadDivisors n)

let count_divisors n =
let count = ref 0 in
for i = 1 to n do
    if n mod i = 0 then incr count;
done;
!count;;

(* �crivez la fonction count_divisors, qui prend un param�tre n et
   renvoie le nombre de diviseurs que n a (incluant 1 et n): *)
let _ = count_divisors 17;; (* 2 -- 17 divides only 1 and 17 *)
let _ = count_divisors 4;;  (* 3 -- 4 divides 1, 4, and 2 *)
let _ = count_divisors 18;; (* 6 -- 18 divides 1, 18, 2, 3, 6, and 9 *)
                             
(* La signature de type pour count_divisors est: *)
(*   count_divisors : int -> int *)

(* count_divisors devrait appeler la fonction (bad_divisors n) d�finie)
   above if n <= 0  *)

(* Vous pouvez �crire autant de fonctions "auxiliaires" que n�cessaire
   "let..in" or just "let". *)

(* Apr�s avoir �crit count_divisors ci-dessus, d�commentez les lignes suivantes
   pour tester votre code. (Remarque: votre code n'est pas n�cessairement complet
   correct juste parce qu'il r�ussit ces 3 tests. *)

let _ = assert (count_divisors 17 = 2);;
let _ = assert (not (count_divisors 4 = 2));;
let _ = assert (count_divisors 18 = 6);;