(*** CSI 3520 Devoir 2 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de laboratoire via VCL, le
   la version est 4.05.0 ***)

(*************)
(* PROBL�ME 1 *)
(*************)

(* Pour chaque partie du probl�me 1, expliquez dans la cha�ne donn�e pourquoi le code
   ne passe pas le contr�le du type, puis suivez les instructions pour cette partie �
   changer le code pour qu'il v�rifie tout en gardant les m�mes valeurs
   comme pr�vu par le code erron�. Une fois que vous l'avez fait, d�commentez
   l'expression fixe pour la soumission.
*)

(* Probl�me 1a - Donnez votre explication dans exp1a puis corrigez le
   c�t� droit de l'affectation pour correspondre au type indiqu�.
   (Ne changez pas le c�t� gauche.)
*)

let exp1a : string = "les elements d'une liste sont separes par ; ou ::"
let prob1a : int list = [1; 2; 3];;

(* Probl�me 1b - Donnez votre explication dans exp1b puis corrigez le type
   de la variable prob1b pour correspondre au type de l'expression sur le
   c�t� droit de la mission. (Ne changez pas le
   du c�t� de la main droite.)
*)

let exp1b : string = "on a une liste de paires de string et int. il faut donc indiquer les elements qui sont en paires entre parentheses"
let prob1b : (string * int) list = [("CSI", 3125); ("CSI", 3525)];;

(* Probl�me 1c - Donnez votre explication dans exp1c, puis corrigez le
   c�t� droit de l'expression pour correspondre � la variable prob1c
   type r�pertori�.
   (Ne changez pas le c�t� gauche.)
*)

let exp1c : string = "pour ajouter des elements a une liste il faut avoir des element du type des elements de la liste et non pas deux listes du meme type"
let prob1c : float list = 2.0 :: 3.0 :: [4.0; 5.0];;

(*************)
(* PROBL�ME 2 *)
(*************)

(* Remplissez les expressions pour satisfaire les types suivants:
 *
 * REMARQUE: pour les types d�option, de liste et de fonction, vous devez
 * fournir une r�ponse non triviale. Pour une liste qui signifie un
 * non vide, pour un type d�option qui signifie
 * construction, et pour une fonction, cela signifie utiliser
 * ses arguments pour g�n�rer la valeur de retour.
 * exemple de probl�mes:
 *   let x : int option = ???
 *   let y : int list = ???
 *   let f (x: int) (y: int) : int = ???
 * r�ponses incorrectes:
 *   let x : int option = None
 *   let y : int list = []
 *   let f (x: int) (y: int) : int = 7
 * r�ponses correctes possibles:
 *   let x : int option = Some 1
 *   let y : int list = [1]
 *   let y : int list = [1; 2]
 *   let y : int list = 1 :: [2]
 *   let f (x: int) (y: int) : int = x + y
 *   let f (x: int) (y: int) : int = 
 *         String.length  ((string_of_int x) ^ (string_of_int y))
 *)

(*>* Probl�me 2a *>*)
let prob2a : (float * (string * int) option list) list = [(4.0, [Some ("hello", 2); None]); (1.0, [None; None])];;

(*>* Probl�me 2b *>*)
(* un �tudiant est un (nom, age option) pair *)

type student = string * int option;;
let prob2b : (student list option * int) list = [(Some [("Oliver", Some 7931937); ("Dmitry", None)], 25); (None, 13)];;

(*>* Probl�me 2c *>*)
(* Remplissez un appel de fonction valide � foo pour faire prob2c
   passer le contr�le du type *)

let prob2c =
  let rec foo bar =
    match bar with
    | (a, (b, c)) :: xs -> if a then (b + c + (foo xs)) else foo xs
    | _ -> 0
  in 
foo [(false, (0,1)); (true, (1,2)); (false, (0,1)); (true, (2,3))];;

(*************)
(* Probl�me 3 *)
(*************)

(* Consid�rons la fonction terriblement �crite suivante: *)

let rec zardoz ls acc =
  if (((List.length (ls@[])) = 1) = true) then ((List.hd(ls)) + (acc))
  else if (((List.length ls) = 0) = true) then acc
  else
    let hd = List.hd(ls) in
        let tl = List.tl(ls) in
      let ans = (hd) + (acc) in
    let ans = zardoz tl ans in
        ans;;

(* R��crire le code ci-dessus pour qu'il fasse la m�me chose
 * Mais le style est bien sup�rieur.
 * Assurez-vous de fournir des types pour les arguments de la fonction et pour
 * s'appeler (pas le zardoz original) de mani�re r�cursive au besoin.
 * Vous voudrez peut-�tre �crire des affirmations d'affirmation
 * pour v�rifier que votre fonction fait la m�me chose que zardoz. *)

let rec myzardoz (ls:int list) (acc:int) =
 if (List.length ls) = 1 then ((List.hd ls) + acc)
  else if (List.length ls) = 0 then acc
  else
    myzardoz (List.tl ls) ((List.hd ls) + (acc));;

(*************)
(* Probl�me 4 *)
(*************)

(* Donner une liste d'entiers l, renvoyer une nouvelle liste obtenue en lisant
   des groupes adjacents d'�l�ments identiques dans l. Par exemple, quand
   l'entr�e est:

l = [2; 2; 2]

le r�sultat devrait �tre:

[3; 2]

parce que je suis exactement "trois twos". De m�me, si l�entr�e est:

l = [1; 2; 2]

le r�sultat devrait �tre:

[1; 1; 2; 2]

parce que je suis exactement "un one, puis deux twos".

Lorsque l est la liste vide, le r�sultat est �galement la liste vide.

Pour obtenir un cr�dit complet, votre solution doit �tre une solution temporelle lin�aire. *)

let count_sequences (xs: int list) : int list =
let rec aux lst count cur acc =
match lst with
| [] | [_] -> !acc@[!count;cur]
| current :: next :: tail -> if current = next then count := !count + 1; if current <> next then acc := !acc@([!count; current]); if current <> next then count := 1; aux (next::tail) (count) (current) (acc)
in aux (List.sort compare xs) (ref 1) (List.hd xs) (ref []);;

(*************)
(* Probl�me 5 *)
(*************)
          
(* �crivez une fonction qui aplatit une liste de listes dans une seule
 * liste avec tous les �l�ments dans le m�me ordre dans lequel ils sont apparus dans
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