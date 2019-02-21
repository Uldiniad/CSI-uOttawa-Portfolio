(* 

  Plan:
   * tuples et listes
   * options
   * fonctions d'ordre supérieur

*)

(* Un employé est un tuple de nom, d'âge et de booléen indiquant le statut de mariage *)
type employee = string * int * bool
                                 
(* 1. Écrivez une fonction qui prend un employé et imprime les informations sous une forme lisible. *)

let print_employee_info t =
match t with
| (name,age,married) -> print_newline (print_string ("Name: " ^ name));
print_newline (print_string ("Age: " ^ string_of_int age));
print_newline (print_string ("Married: " ^ string_of_bool married));;

(* 2. Réimplémenter les fonctions standard OCaml List.length et List.rev *)

let length (l:'a list) : int =
let rec aux count list =
match list with
| [] -> count
| h::t -> aux (count + 1) t
in aux 0 l;;

let rev (l:'a list) : 'a list =
let rec aux list acc =
match list with
| [] -> acc
| h::t -> aux t ([h]@acc)
in aux l [];;

(* 3. Supprimer le k ième élément d'une liste. Supposons l'indexation à partir de 0 *)
(* exemple: rmk 2 ["to" ; "be" ; "or" ; "not" ; "to" ; "be"] 
 * résultats in: [["to" ; "be" ; "not" ; "to" ; "be"] *)
let rmk (k:int) (l:'a list) : 'a list = 
let rec aux position list acc =
match list with
| [] -> acc
| h::t -> aux (position+1) t (acc@ if position <> k then [h] else [])
in aux 0 l [];;


(* 4. Écrivez une fonction pour renvoyer la plus petite des deux options int, ou None
 * si les deux sont null. Si exactement un argument est null, renvoyez l'autre. Faire
 * le même pour la plus grande des deux options int.*)

let min_option (x: int option) (y: int option) : int option =
if (x = None && y = None) then None
else if (x = None) then y
else if (y = None) then x
else min x y;;

let max_option (x: int option) (y: int option) : int option =
if (x = None && y = None) then None
else if (x = None) then y
else if (y = None) then x
else max x y;;

(* 5. Ecrire une fonction qui renvoie l'entier enterré dans l'argument
 * ou aucun autre *)  
let get_option (x: int option option option option) : int option =
match x with
| Some Some Some Some x -> Some x
| _ -> None;;

(* 6. Ecrivez une fonction pour retourner le booléen AND / OR de deux options bool,
 * ou Aucun si les deux sont null. Si exactement l'un est null, renvoyez l'autre. *)

let and_option (x:bool option) (y: bool option) : bool option =
match x, y with
| None, None -> None
| Some x, None -> Some x
| None, Some y -> Some y
| Some x, Some y -> Some (x&&y);;

let or_option (x:bool option) (y: bool option) : bool option =
match x, y with
| None, None -> None
| Some x, None -> Some x
| None, Some y -> Some y
| Some x, Some y -> Some (x||y);;

(* Quel est le modèle? Comment pouvons-nous factoriser un code similaire? *)

(* 7. Écrivez une fonction d'ordre supérieur pour les opérations binaires sur les options.
 * Si les deux arguments sont présents, appliquez l'opération.
 * Si les deux arguments sont null, renvoyez null. Si un argument est (Some x)
 * et l'autre argument est null, la fonction devrait renvoyer (Some x) *)
(* Quel est la signature de calc_option's  *)

(*
let calc_option (f: 'a->'a->'a) (x: 'a option) (y: 'a option) : 'a option =  
*)

(* 8. Maintenant, réécrivez les fonctions suivantes en utilisant la fonction d'ordre supérieur ci-dessus
 * Écrivez une fonction pour renvoyer la plus petite des deux options int ou null
 * si les deux sont null. Si exactement un argument est null, renvoyez l'autre. *)

(*
let min_option2 (x: int option) (y: int option) : int option = 
*)

(*
let max_option2 (x: int option) (y: int option) : int option = 
*)

(* 9. Ecrire une fonction qui retourne l'élément final d'une liste,
   s'il existe, et aucun autrement*)
(*
let final (l: 'a list) : 'a option = 
*)
