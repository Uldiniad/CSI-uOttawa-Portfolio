(* Exercice 1 *)
(* Regardez la définition de type suivante. *)
type colour = Red | Yellow | Blue | Green | Orange | Purple | Garnet | Other of string;;
type favourite = Colour of colour | Movie of string | Tvshow of string |
                 Number of float | Letter of char;;

(* Vous trouverez ci-dessous des exemples de listes de films préférés, couleurs préférés, etc.
 * Vous pouvez considérer chacune de ces listes comme une liste de choses préférées d'une personne.
 * Vous peut les utiliser pour tester vos fonctions. *)

let a : favourite list = [Movie "Love Story"; Colour Blue;
                          Tvshow "The Simpsons"; Colour Orange];;

let b : favourite list = [Number 1.0; Number 2.0; Number 5.0;
                          Number 14.0; Number 42.0];;

let c : favourite list = [Movie "A Beautiful Mind"; Tvshow "House";
                          Letter 'P'; Colour Orange];;

let d : favourite list = [Tvshow "Lost"; Number 3.14];;

let students = [a; b; c; d];;

(* 1a. Définissez une valeur de type "favourite list" pour quelqu'un dont
 * son couleur préférée est Aubergine et son nombre préféré est 5. *)

let prob1a : favourite list = [Colour Purple; Number 5.0];;


(* 1b. Écrivez une fonction qui prend une valeur de type "favourite list" (comme l'exemple
 * ci-dessus) et renvoie le titre du film préféré de cette personne, ou
 * "None" si un film favori n'est pas donné. Si plusieurs films sont dans la liste,
 * renvoie le premier. Quelle est la signature de type pour cette fonction? (Donnez le
 * type de "favmovie" sous forme de chaîne de caractères dans "favmovie_type" ci-dessous.) *)

let favmovie_type = "favourite list -> string option"

let rec favmovie (lst : favourite list) : string option =
match lst with
| [] -> None
| (Movie movie)::tl -> Some movie
| _::tl -> favmovie tl
;;

(* 1c. Écrivez une fonction qui prend une valeur de type "favourite list" et
 * renvoie "true" si et seulement si cette personne a inclus "Garnet" en tant que
 * couleur préférée. Quelle est la signature de type pour cette fonction? *)

let uottawa_colours_type = "favourite list -> bool"

let rec uottawa_colours (lst : favourite list) : bool =
match lst with
| [] -> false
| hd::tl -> if hd = Colour Garnet then true else uottawa_colours tl
;;

(* Exercice 2 *)
(* 2a. Définissez un type de données représentant des "int"s ou des "float"s *)

type realnum =
  | Int of int
  | Float of float
;;


(* 2b. Définissez deux fonctions pour créer des nombres réels à partir d'un "int" et d'un "float", respectivement *)

let real_of_int (i:int) : realnum = Int i;;

let real_of_float (f:float) : realnum = Float f;;

(* 2c. Définissez une fonction qui teste si deux réels sont égaux. La fonction doit functionner
 * sur des "int"s et des "float"s, par exemple (realequal 4 4.0) => True. *)

let realequal (a: realnum) (b: realnum) : bool =
match a,b with
| (Int i, Int j) -> i = j
| (Float i, Float j) -> i = j
| (Int i, Float j) -> float_of_int i = j
| (Float i, Int j) -> i = float_of_int j
;;

(* Exercice 3: Vous trouverez ci-dessous le type de données qui apparaît dans le Devoir 3 *)
(* Rappelons que nous avons défini un type 'prop' pour les variables propositionnelles et un
   type "form" qui est composé de 'True', 'False', 'And', 'Or', 'Imp' et
   variables. Un environnement est un mappage de variables propositionnelles à des valeurs booléennes.
*)

type prop = string

type form =
  | True
  | False
  | Prop of prop 
  | And of form * form
  | Or of form * form
  | Imp of form * form

type env = (prop * bool) list

(* 3a. Ecrivez une fonction qui prend comme entreé une formule
   booléenne, et renvoie la liste de tous les variables
   propositionnelles uniques quui apparaissent dans la formule.
   *)

let fvars (f:form) : prop list =
let temp = [];
match f with
| Prop p -> temp@[p];

(* 3b. Écrivez une fonction qui prend une formule booléenne et teste si
   il est sous forme normale conjonctive (CNF). (Voir Devoir 3
   pour une description de CNF.) En général, une expression CNF est
   représentée sous la forme d'une série d'expressions OR connecté par AND.
   Par exemple, la formule suivante est dans CNF:

   (x1 \/ x2) /\ (x3 \/ x4 \/ x5) /\ x6

   De plus, chacun des variables (x1, ..., x6) est soit vrai, soit faux, soit
   une variable propositionnelle. Traitez les cas comme x6
   comme une expression OR qui ne contient aucun "Or" (cas de base). Également,
   considérez le cas où il n'y a pas d'AND dans la formule. Par exemple,
   les formules suivantes sont en forme CNF.

   (x3 \/ x4 \/ x5)
   x
   True
   False
*)

let is_cnf (f:form) : bool =
match f with
| 

(* Quelques tests pour 3a et 3b. *)

let c1 = Or (Prop "x1",Prop "x2")
let c2 = Or (Or (Prop "x3",Prop "x4"),Prop "x5")
let c3 = Prop "x2"

let test_is_cnf1 = is_cnf (And (c1,And (c2,c3)))
let test_is_cnf2 = is_cnf (And (And (c1,c2),c3))
let test_is_cnf3 = is_cnf (And (Imp (c1,c2),c3))
let test_is_cnf4 = is_cnf c2
let test_is_cnf5 = is_cnf c3

let test_fvars1 = fvars c2
let test_fvars2 = fvars (And (Imp (c1,c2),c3))
