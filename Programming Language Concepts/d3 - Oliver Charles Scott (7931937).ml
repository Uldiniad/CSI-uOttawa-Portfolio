(*** CSI 3520 Devoir 3 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de laboratoire via VCL, le
   la version est 4.05.0 ***)

(*************)
(* PROBLÈME 1 *)
(*************)

(* Vous trouverez ci-dessous la définition d’un type de données pour la logique propositionnelle avec
   connecteurs pour la conjonction, (l'opérateur AND  / \),
   disjonction (l'opérateur OR  \ /) et implication logique
   (=>). 
   Par exemple, voici une formule de logique propositionnelle.
   (p /\ q) => (r \/ s)

   Notez que les chaînes sont utilisées pour représenter les variables propositionnelles.

   Le type env est utilisé pour mapper les variables propositionnelles aux valeurs booléennes.
 *)

type prop = string;;

type form =
  | True
  | False
  | Prop of prop 
  | And of form * form
  | Or of form * form
  | Imp of form * form
;;

type env = (prop * bool) list;;

(* Problème 1a: Ecrivez une fonction qui prend une "liste de prop" comme entrée
   et renvoie sa valeur en tant que "form" sous forme normale conjonctive (CNF).
   Une expression CNF est représentée par une série d'expressions OU
   réunis par ET.

   e.g. transformer ceci:

   [ ["x1"; "x2"]; ["x3"; "x4"; "x5"]; ["x6"] ]

   en une expression de type "form" qui représente la formule

   (x1 \/ x2) /\ (x3 \/ x4 \/ x5) /\ x6

   Notez que \/ et /\ sont associatifs, donc par exemple
   (x3 \/ x4 \/ x5) représente ((x3 \/ x4) \/ x5) et est équivalent
   à (x3 \/ (x4 \/ x5)), peut donc être représenté comme
   Ou (Or (Prop "x3",Prop "x4"),Prop "x5")  or
   Or (Prop "x3",Or (Prop "x4",Prop "x5"))

   Si une liste interne est vide, elle doit être remplacée par False, e.g.,

   [ ["x1"; "x2"]; []; ["x6"] ] as input results in output:

   (x1 \/ x2) /\ False /\ x6

   Si la liste d'entrée est vide, retourne True.

   Facultatif: vous pouvez utiliser "map" (de la classe) et / ou "reduce"
   (du tutoriel 1), qui sont inclus ci-dessous *)

let rec map (f:'a -> 'b) (xs: 'a list) : 'b list =
  match xs with
  | [] -> []
  | hd::tl -> (f hd) :: (map f tl)

let rec reduce (f:'a -> 'b -> 'b) (u:'b) (xs:'a list) : 'b =
  match xs with
  | [] -> u
  | hd::tl -> f hd (reduce f u tl);;

(* Dans cet exercice et dans tous les exercices, décommentez l'en-tête de la fonction et
   exemples de tests, remplissez les parties manquantes. Assurez-vous de tester votre code
   entièrement en utilisant vos propres tests aussi. Assurez-vous également d’ajouter «rec» à la
   en-tête si vous définissez une fonction récursive. *)

let rec disjunction (pl:prop list) =
  match pl with
  | [] -> False
  | [hd] -> Prop hd
  | hd::tl -> Or (Prop hd, disjunction tl)
;;

let rec cnf (pll:prop list list) : form =
  match pll with
  | [] -> True
  | [[hd]] -> Prop hd
  | [hd] -> disjunction hd
  | hd::tl -> And (disjunction hd, cnf tl)
;;

let test1a_1() = cnf [ ["x1"; "x2"]; ["x3"; "x4"; "x5"]; ["x6"] ];;
let test1a_2() = cnf [];;
let test1a_3() = cnf [ ["x1"; "x2"]; []; ["x6"] ];;

(* Problème 1b: Définir un nouveau type de données appelé form' qui remplace "form",
   mais est juste comme "form" sauf qu'elle représente aussi la négation (le
   PAS opérateur écrit ~). Votre code pour 1b et 1c ne fonctionne que
   sur le nouveau type form' (qui ne dépend pas du tout du type
   "form" de 1a).
   Cela devrait être facile.*)

type form' =
  | True
  | False
  | Prop of prop 
  | And of form' * form'
  | Or of form' * form'
  | Imp of form' * form'
  | Not of form'
;;

(* Problème 1c: Définir une fonction qui prend une form' et un env comme
   arguments et calcule la valeur de vérité. Par exemple, si

   e = [("p",true);("q",false);("r",true);("s",false)]

   alors votre fonction devrait retourner "true"
   pour la formule mentionnée ci-dessus:
   (p /\ q) => (r \/ s)
   
   Voir les tables de vérité à https://fr.wikipedia.org/wiki/Table_de_v%C3%A9rit%C3%A9
   pour savoir comment calculer les valeurs de vérité des formules propositionelles.
   
   Vous pouvez utiliser la fonction "lookup" ci-dessous. Votre fonction devrait retourner
   un bool. Supposons que l’une des variables de l’entrée de type form' qui
   n'apparaissent pas dans l'env d'entrée a la valeur "false".
 *)

(* retourne la valeur de la proposition p dans l'environnement env *)
let rec lookup (e:env) (p:prop) : bool option =
  match e with
  | [] -> None
  | (hd_p,hd_b)::tl_e -> 
      if p=hd_p then Some hd_b
      else lookup tl_e p
;;

let rec eval_prop (f:form') (e:env) : bool =
  match f with
  | True -> true
  | False -> false
  | And (hd,tl) -> eval_prop hd e && eval_prop tl e
  | Or (hd,tl) -> eval_prop hd e || eval_prop tl e
  | Imp (hd,tl) -> (not (eval_prop hd e)) || eval_prop tl e
  | Not (hd) -> not (eval_prop hd e)
  | Prop (hd) -> let result = lookup e hd in match result with | None -> false | Some bool -> bool
;;

(* Les éléments suivants peuvent être utiles pour les tests: *)
   let e = [("p",true);("q",false);("r",true);("s",false)];;
   let test1b (f:form') : bool = eval_prop f e;;

(*************)
(* PROBLÈME 2 *)
(*************)

(* Vous trouverez ci-dessous une implémentation d'un module implémentant un dictionnaire,
   qui est une structure de données également appelée tableau associatif. Voir
   https://fr.wikipedia.org/wiki/Tableau_associatif.
   Les clés sont des chaînes et les dictionnaires sont des listes. (Remarque
   qu'il existe de nombreux moyens plus efficaces de mettre en œuvre ces structures
   de données, que nous ignorons ici.) *)

module type DICT =
  sig
    type ('key,'value) dict = ('key * 'value) list
    val empty : unit -> ('key,'value) dict
    val lookup : ('key,'value) dict -> 'key -> 'value option
    val member : ('key,'value) dict -> 'key -> bool
    val insert : ('key,'value) dict -> 'key -> 'value -> ('key,'value) dict
    val remove : ('key,'value) dict -> 'key -> ('key,'value) dict
  end;;

module ListDict : DICT =
  struct
    type ('key,'value) dict = ('key * 'value) list

    (* Module invariant: les opérations sont implémentées pour qu'il y
       n'est jamais plus d'une occurrence d'une clé donnée, et la liste
       est toujours dans l'ordre trié. *)
              
    let empty () : ('key,'value) dict = []

    let rec lookup (d:('key,'value) dict) (k:'key) : 'value option  =
      match d with
      | [] -> None
      | (hd_k,hd_v)::tl -> if hd_k=k then Some hd_v
                           else lookup tl k

    let rec member (d:('key,'value) dict) (k:'key) : bool =
      match d with
      | [] -> false
      | (hd_k,hd_v)::tl -> hd_k=k || member tl k

    let rec insert (d:('key,'value) dict) (k:'key) (v:'value) : ('key,'value) dict =
      match d with
      | [] -> [(k,v)]
      | (hd_k,hd_v)::tl -> if (k < hd_k || k = hd_k)
                           then (k,v)::(hd_k,hd_v)::tl
                           else (hd_k,hd_v)::insert tl k v

    let rec remove (d:('key,'value) dict) (k:'key) : ('key,'value) dict =
      List.filter (fun (hd_k,_) -> hd_k<>k) d 
  end;;

(* Problème 2a: Remplacer l’implémentation de "remove" par un
   correct, c’est-à-dire qui supprime un élément de la
   dictionnaire s'il est présent dans le dictionnaire, sinon il laisse
   le dictionnaire inchangé.
   Notez qu’en raison de la manière dont cet "insert" est
   implémenté, plusieurs valeurs peuvent être associées à un
   clé donnée k, mais parce que le dictionnaire est trié, ces paires seront
   côte à côte dans la liste. En d'autres termes, il pourrait
   être un segment de la forme
   ...: :(( k, v1): :(( k, v2) :: ...: :(( k, vn) :: ...
   dans le dictionnaire où toutes les clés à gauche ont une valeur inférieure et
   toutes les clé à droite ont une plus grande valeur. Assurez-vous de enlever
   toutes les paires ayant la clé k. *)

(* Problème 2b: Notez que lorsque vous charger ce fichier dans OCaml, les types
   qui sont déduits comprennent 'a et' b.  Ces type sont plus général
   que nous avons l'intention qu'il soit. Ajouter des types à toutes les fonctions
   (types de paramètres et types de résultats)
   dans le module ListDict afin que toutes les occurrences de
   'a et' b disparaissent. Utilisez à la place les types 'key, 'value et
   ('key,'value) dict.
 *)

(* Problème 2c: Complétez la signature DICT ci-dessus. Inclure
   éléments de signature pour toutes les fonctions qui se produisent dans
   ListDict. Ajoutez des commentaires décrivant la nature de chaque opération.
   Une fois que vous avez terminé, supprimez le commentaire de la
   première ligne de la définition du module ListDict.
 *)

(* Problème 2d: Réimplémentez votre solution au problème 1c en utilisant
   la nouvelle définition suivante de "lookup". Développer du code pour
   des tests similaires à ce que vous avez fait pour le problème 1c.
   Vous trouverez ci-dessous un code initial sur lequel vous pouvez vous appuyer.
   Remarque: Cet exercice simple montre à quel point il est facile d’échanger
   une implantation avec une autre. *)

(* retourne la valeur de la proposition p dans l'environnement env *)
type env' = (string,bool) ListDict.dict;;
let lookup' (e:env') (p:prop) : bool option =
  ListDict.lookup e p;;

let env0 = ListDict.empty();;
let env1 = ListDict.insert env0 "p" true;;

let rec eval_prop' (f:form') (e:env') : bool =
  match f with
  | True -> true
  | False -> false
  | And (hd,tl) -> eval_prop' hd e && eval_prop' tl e
  | Or (hd,tl) -> eval_prop' hd e || eval_prop' tl e
  | Imp (hd,tl) -> (not (eval_prop' hd e)) || eval_prop' tl e
  | Not (hd) -> not (eval_prop' hd e)
  | Prop (hd) -> let result = lookup' e hd in match result with | None -> false | Some bool -> bool
;;

let env2 = ListDict.insert env1 "q" false;;
let env3 = ListDict.insert env2 "r" true;;
let env4 = ListDict.insert env3 "s" false;;

let test2d (f:form') : bool = eval_prop' f env4;;

(* Problème 2e: Notez que le dictionnaire ci-dessus est une version fonctionnelle.
   Concevoir une version impérative de la signature DICT, mais inclure
   seules les opérations "empty", "lookup" et "insert". (Omettre "member" et
   "remove".) Dans cette version, l'opération "empty" crée et retourne
   un dictionnaire mutable. L'opération "insert" prend un dictionnaire comme
   entrée, mais au lieu de renvoyer un nouveau dictionnaire, il modifie la
   dictionnaire d'entrée. Note: il n'y aura que très mineur
   modifications, semblables aux modifications apportées à STACK pour obtenir
   IMP_STACK dans les notes de cours. *)

module type IMP_DICT =
  sig
    type ('key,'value) dict
    val empty : unit -> ('key,'value) dict ref
    val lookup : ('key,'value) dict -> 'key -> 'value option 
    val insert : ('key,'value) dict ref -> 'key -> 'value -> unit
  end;;

(* Problème 2f: Implémentez un module de type IMP_DICT. Indice: faites-le par
   faire une copie du contenu du module ListDict, en supprimant le
   fonctions "member" and "remove", et modifier le reste au besoin. *)

module ImpListDict : IMP_DICT =
  struct
    type ('key,'value) dict = ('key * 'value) list

    let empty () : ('key,'value) dict ref = ref []

    let rec lookup (d:('key,'value) dict) (k:'key) : 'value option  =
      match d with
      | [] -> None
      | (hd_k,hd_v)::tl -> if hd_k=k then Some hd_v
                           else lookup tl k

    let rec insert (d:('key,'value) dict ref) (k:'key) (v:'value) : unit =
      match !d with
      | [] -> d := [(k,v)]
      | (hd_k,hd_v)::tl -> if (k <= hd_k)
                           then (d := (k,v)::(hd_k,hd_v)::tl)
                           else (insert (ref tl) k v; d := (hd_k,hd_v)::!d)
  end;;

(* Quelques codes pour vous aider à tester votre implémentation: *)

type env'' = (string,bool) ImpListDict.dict;;
let lookup'' (e:env'') (p:prop) : bool option =
  ImpListDict.lookup e p
;;
let e'' = ImpListDict.empty();;
let _ = ImpListDict.insert e'' "p" true;;