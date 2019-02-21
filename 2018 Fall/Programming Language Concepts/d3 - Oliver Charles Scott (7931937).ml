(*** CSI 3520 Devoir 3 ***)
(*** Oliver Charles Scott ***)
(*** 7931937 ***)
(*** OCaml version 4.05.0 ***)
(* Si vous utilisez la version disponible sur les machines de laboratoire via VCL, le
   la version est 4.05.0 ***)

(*************)
(* PROBL�ME 1 *)
(*************)

(* Vous trouverez ci-dessous la d�finition d�un type de donn�es pour la logique propositionnelle avec
   connecteurs pour la conjonction, (l'op�rateur AND  / \),
   disjonction (l'op�rateur OR  \ /) et implication logique
   (=>). 
   Par exemple, voici une formule de logique propositionnelle.
   (p /\ q) => (r \/ s)

   Notez que les cha�nes sont utilis�es pour repr�senter les variables propositionnelles.

   Le type env est utilis� pour mapper les variables propositionnelles aux valeurs bool�ennes.
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

(* Probl�me 1a: Ecrivez une fonction qui prend une "liste de prop" comme entr�e
   et renvoie sa valeur en tant que "form" sous forme normale conjonctive (CNF).
   Une expression CNF est repr�sent�e par une s�rie d'expressions OU
   r�unis par ET.

   e.g. transformer ceci:

   [ ["x1"; "x2"]; ["x3"; "x4"; "x5"]; ["x6"] ]

   en une expression de type "form" qui repr�sente la formule

   (x1 \/ x2) /\ (x3 \/ x4 \/ x5) /\ x6

   Notez que \/ et /\ sont associatifs, donc par exemple
   (x3 \/ x4 \/ x5) repr�sente ((x3 \/ x4) \/ x5) et est �quivalent
   � (x3 \/ (x4 \/ x5)), peut donc �tre repr�sent� comme
   Ou (Or (Prop "x3",Prop "x4"),Prop "x5")  or
   Or (Prop "x3",Or (Prop "x4",Prop "x5"))

   Si une liste interne est vide, elle doit �tre remplac�e par False, e.g.,

   [ ["x1"; "x2"]; []; ["x6"] ] as input results in output:

   (x1 \/ x2) /\ False /\ x6

   Si la liste d'entr�e est vide, retourne True.

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

(* Dans cet exercice et dans tous les exercices, d�commentez l'en-t�te de la fonction et
   exemples de tests, remplissez les parties manquantes. Assurez-vous de tester votre code
   enti�rement en utilisant vos propres tests aussi. Assurez-vous �galement d�ajouter �rec� � la
   en-t�te si vous d�finissez une fonction r�cursive. *)

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

(* Probl�me 1b: D�finir un nouveau type de donn�es appel� form' qui remplace "form",
   mais est juste comme "form" sauf qu'elle repr�sente aussi la n�gation (le
   PAS op�rateur �crit ~). Votre code pour 1b et 1c ne fonctionne que
   sur le nouveau type form' (qui ne d�pend pas du tout du type
   "form" de 1a).
   Cela devrait �tre facile.*)

type form' =
  | True
  | False
  | Prop of prop 
  | And of form' * form'
  | Or of form' * form'
  | Imp of form' * form'
  | Not of form'
;;

(* Probl�me 1c: D�finir une fonction qui prend une form' et un env comme
   arguments et calcule la valeur de v�rit�. Par exemple, si

   e = [("p",true);("q",false);("r",true);("s",false)]

   alors votre fonction devrait retourner "true"
   pour la formule mentionn�e ci-dessus:
   (p /\ q) => (r \/ s)
   
   Voir les tables de v�rit� � https://fr.wikipedia.org/wiki/Table_de_v%C3%A9rit%C3%A9
   pour savoir comment calculer les valeurs de v�rit� des formules propositionelles.
   
   Vous pouvez utiliser la fonction "lookup" ci-dessous. Votre fonction devrait retourner
   un bool. Supposons que l�une des variables de l�entr�e de type form' qui
   n'apparaissent pas dans l'env d'entr�e a la valeur "false".
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

(* Les �l�ments suivants peuvent �tre utiles pour les tests: *)
   let e = [("p",true);("q",false);("r",true);("s",false)];;
   let test1b (f:form') : bool = eval_prop f e;;

(*************)
(* PROBL�ME 2 *)
(*************)

(* Vous trouverez ci-dessous une impl�mentation d'un module impl�mentant un dictionnaire,
   qui est une structure de donn�es �galement appel�e tableau associatif. Voir
   https://fr.wikipedia.org/wiki/Tableau_associatif.
   Les cl�s sont des cha�nes et les dictionnaires sont des listes. (Remarque
   qu'il existe de nombreux moyens plus efficaces de mettre en �uvre ces structures
   de donn�es, que nous ignorons ici.) *)

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

    (* Module invariant: les op�rations sont impl�ment�es pour qu'il y
       n'est jamais plus d'une occurrence d'une cl� donn�e, et la liste
       est toujours dans l'ordre tri�. *)
              
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

(* Probl�me 2a: Remplacer l�impl�mentation de "remove" par un
   correct, c�est-�-dire qui supprime un �l�ment de la
   dictionnaire s'il est pr�sent dans le dictionnaire, sinon il laisse
   le dictionnaire inchang�.
   Notez qu�en raison de la mani�re dont cet "insert" est
   impl�ment�, plusieurs valeurs peuvent �tre associ�es � un
   cl� donn�e k, mais parce que le dictionnaire est tri�, ces paires seront
   c�te � c�te dans la liste. En d'autres termes, il pourrait
   �tre un segment de la forme
   ...: :(( k, v1): :(( k, v2) :: ...: :(( k, vn) :: ...
   dans le dictionnaire o� toutes les cl�s � gauche ont une valeur inf�rieure et
   toutes les cl� � droite ont une plus grande valeur. Assurez-vous de enlever
   toutes les paires ayant la cl� k. *)

(* Probl�me 2b: Notez que lorsque vous charger ce fichier dans OCaml, les types
   qui sont d�duits comprennent 'a et' b.  Ces type sont plus g�n�ral
   que nous avons l'intention qu'il soit. Ajouter des types � toutes les fonctions
   (types de param�tres et types de r�sultats)
   dans le module ListDict afin que toutes les occurrences de
   'a et' b disparaissent. Utilisez � la place les types 'key, 'value et
   ('key,'value) dict.
 *)

(* Probl�me 2c: Compl�tez la signature DICT ci-dessus. Inclure
   �l�ments de signature pour toutes les fonctions qui se produisent dans
   ListDict. Ajoutez des commentaires d�crivant la nature de chaque op�ration.
   Une fois que vous avez termin�, supprimez le commentaire de la
   premi�re ligne de la d�finition du module ListDict.
 *)

(* Probl�me 2d: R�impl�mentez votre solution au probl�me 1c en utilisant
   la nouvelle d�finition suivante de "lookup". D�velopper du code pour
   des tests similaires � ce que vous avez fait pour le probl�me 1c.
   Vous trouverez ci-dessous un code initial sur lequel vous pouvez vous appuyer.
   Remarque: Cet exercice simple montre � quel point il est facile d��changer
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

(* Probl�me 2e: Notez que le dictionnaire ci-dessus est une version fonctionnelle.
   Concevoir une version imp�rative de la signature DICT, mais inclure
   seules les op�rations "empty", "lookup" et "insert". (Omettre "member" et
   "remove".) Dans cette version, l'op�ration "empty" cr�e et retourne
   un dictionnaire mutable. L'op�ration "insert" prend un dictionnaire comme
   entr�e, mais au lieu de renvoyer un nouveau dictionnaire, il modifie la
   dictionnaire d'entr�e. Note: il n'y aura que tr�s mineur
   modifications, semblables aux modifications apport�es � STACK pour obtenir
   IMP_STACK dans les notes de cours. *)

module type IMP_DICT =
  sig
    type ('key,'value) dict
    val empty : unit -> ('key,'value) dict ref
    val lookup : ('key,'value) dict -> 'key -> 'value option 
    val insert : ('key,'value) dict ref -> 'key -> 'value -> unit
  end;;

(* Probl�me 2f: Impl�mentez un module de type IMP_DICT. Indice: faites-le par
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

(* Quelques codes pour vous aider � tester votre impl�mentation: *)

type env'' = (string,bool) ImpListDict.dict;;
let lookup'' (e:env'') (p:prop) : bool option =
  ImpListDict.lookup e p
;;
let e'' = ImpListDict.empty();;
let _ = ImpListDict.insert e'' "p" true;;