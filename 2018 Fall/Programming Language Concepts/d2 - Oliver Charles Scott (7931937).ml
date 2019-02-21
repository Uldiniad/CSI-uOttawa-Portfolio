(*** CSI 3520 Devoir 2 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de laboratoire via VCL, le
   la version est 4.05.0 ***)

(*************)
(* PROBLÈME 1 *)
(*************)

(* Pour chaque partie du problème 1, expliquez dans la chaîne donnée pourquoi le code
   ne passe pas le contrôle du type, puis suivez les instructions pour cette partie à
   changer le code pour qu'il vérifie tout en gardant les mêmes valeurs
   comme prévu par le code erroné. Une fois que vous l'avez fait, décommentez
   l'expression fixe pour la soumission.
*)

(* Problème 1a - Donnez votre explication dans exp1a puis corrigez le
   côté droit de l'affectation pour correspondre au type indiqué.
   (Ne changez pas le côté gauche.)
*)

let exp1a : string = "les elements d'une liste sont separes par ; ou ::"
let prob1a : int list = [1; 2; 3];;

(* Problème 1b - Donnez votre explication dans exp1b puis corrigez le type
   de la variable prob1b pour correspondre au type de l'expression sur le
   côté droit de la mission. (Ne changez pas le
   du côté de la main droite.)
*)

let exp1b : string = "on a une liste de paires de string et int. il faut donc indiquer les elements qui sont en paires entre parentheses"
let prob1b : (string * int) list = [("CSI", 3125); ("CSI", 3525)];;

(* Problème 1c - Donnez votre explication dans exp1c, puis corrigez le
   côté droit de l'expression pour correspondre à la variable prob1c
   type répertorié.
   (Ne changez pas le côté gauche.)
*)

let exp1c : string = "pour ajouter des elements a une liste il faut avoir des element du type des elements de la liste et non pas deux listes du meme type"
let prob1c : float list = 2.0 :: 3.0 :: [4.0; 5.0];;

(*************)
(* PROBLÈME 2 *)
(*************)

(* Remplissez les expressions pour satisfaire les types suivants:
 *
 * REMARQUE: pour les types d’option, de liste et de fonction, vous devez
 * fournir une réponse non triviale. Pour une liste qui signifie un
 * non vide, pour un type d’option qui signifie
 * construction, et pour une fonction, cela signifie utiliser
 * ses arguments pour générer la valeur de retour.
 * exemple de problèmes:
 *   let x : int option = ???
 *   let y : int list = ???
 *   let f (x: int) (y: int) : int = ???
 * réponses incorrectes:
 *   let x : int option = None
 *   let y : int list = []
 *   let f (x: int) (y: int) : int = 7
 * réponses correctes possibles:
 *   let x : int option = Some 1
 *   let y : int list = [1]
 *   let y : int list = [1; 2]
 *   let y : int list = 1 :: [2]
 *   let f (x: int) (y: int) : int = x + y
 *   let f (x: int) (y: int) : int = 
 *         String.length  ((string_of_int x) ^ (string_of_int y))
 *)

(*>* Problème 2a *>*)
let prob2a : (float * (string * int) option list) list = [(4.0, [Some ("hello", 2); None]); (1.0, [None; None])];;

(*>* Problème 2b *>*)
(* un étudiant est un (nom, age option) pair *)

type student = string * int option;;
let prob2b : (student list option * int) list = [(Some [("Oliver", Some 7931937); ("Dmitry", None)], 25); (None, 13)];;

(*>* Problème 2c *>*)
(* Remplissez un appel de fonction valide à foo pour faire prob2c
   passer le contrôle du type *)

let prob2c =
  let rec foo bar =
    match bar with
    | (a, (b, c)) :: xs -> if a then (b + c + (foo xs)) else foo xs
    | _ -> 0
  in 
foo [(false, (0,1)); (true, (1,2)); (false, (0,1)); (true, (2,3))];;

(*************)
(* Problème 3 *)
(*************)

(* Considérons la fonction terriblement écrite suivante: *)

let rec zardoz ls acc =
  if (((List.length (ls@[])) = 1) = true) then ((List.hd(ls)) + (acc))
  else if (((List.length ls) = 0) = true) then acc
  else
    let hd = List.hd(ls) in
        let tl = List.tl(ls) in
      let ans = (hd) + (acc) in
    let ans = zardoz tl ans in
        ans;;

(* Réécrire le code ci-dessus pour qu'il fasse la même chose
 * Mais le style est bien supérieur.
 * Assurez-vous de fournir des types pour les arguments de la fonction et pour
 * s'appeler (pas le zardoz original) de manière récursive au besoin.
 * Vous voudrez peut-être écrire des affirmations d'affirmation
 * pour vérifier que votre fonction fait la même chose que zardoz. *)

let rec myzardoz (ls:int list) (acc:int) =
 if (List.length ls) = 1 then ((List.hd ls) + acc)
  else if (List.length ls) = 0 then acc
  else
    myzardoz (List.tl ls) ((List.hd ls) + (acc));;

(*************)
(* Problème 4 *)
(*************)

(* Donner une liste d'entiers l, renvoyer une nouvelle liste obtenue en lisant
   des groupes adjacents d'éléments identiques dans l. Par exemple, quand
   l'entrée est:

l = [2; 2; 2]

le résultat devrait être:

[3; 2]

parce que je suis exactement "trois twos". De même, si l’entrée est:

l = [1; 2; 2]

le résultat devrait être:

[1; 1; 2; 2]

parce que je suis exactement "un one, puis deux twos".

Lorsque l est la liste vide, le résultat est également la liste vide.

Pour obtenir un crédit complet, votre solution doit être une solution temporelle linéaire. *)

let count_sequences (xs: int list) : int list =
let rec aux lst count cur acc =
match lst with
| [] | [_] -> !acc@[!count;cur]
| current :: next :: tail -> if current = next then count := !count + 1; if current <> next then acc := !acc@([!count; current]); if current <> next then count := 1; aux (next::tail) (count) (current) (acc)
in aux (List.sort compare xs) (ref 1) (List.hd xs) (ref []);;

(*************)
(* Problème 5 *)
(*************)
          
(* Écrivez une fonction qui aplatit une liste de listes dans une seule
 * liste avec tous les éléments dans le même ordre dans lequel ils sont apparus dans
 * la liste originale des listes. par exemple:
 *
 * flatten [[1;2;3]; []; [4]; [5;6]] = [1;2;3;4;5;6];; 
 * flatten [[]; [5;4]; [1;2;3]] = [5;4;1;2;3];;
 *)

let rec flatten (xss:int list list) : int list =
let rec aux list acc =
match list with
| [] -> acc
| head::tail -> aux tail (acc @ head)
in aux xss [];;