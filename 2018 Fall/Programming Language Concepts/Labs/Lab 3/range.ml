(* Une version condensée de la signature dans range.mli. Votre première étape consiste à étudier le contenu de range.mli. *)
module type RANGE =
sig
  type t
  type e
  val singleton : e -> t
  val range : e -> e -> t
  val sadd : t -> e -> t
  val smult : t -> e -> t
  val bridge : t -> t -> t
  val size : t -> int
  val contains : t -> e -> bool
  val rless : t -> t -> bool option
end;;

(* Une implémentation du type de données RANGE avec int comme type des
   éléments et des paires qui représentent une intervalle *)
module LoHiPairRange : RANGE with type e = int =
struct
  type e = int
  type t = e * e
  let singleton (i:e) : t = (i,i)
  let range (i:e) (j:e) : t = ((min i j), (max i j))
  let sadd (x:t) (i:e) : t = let (lo,hi) = x in (lo+i,hi+i)
  let smult (x:t) (i:e) : t =
    let (lo, hi) = x in
    if i >= 0 then (lo*i,hi*i)
    else (hi*i,lo*i)
  let bridge (x:t) (y:t) : t =
    let (lx, hx) = x in
    let (ly, hy) = y in
    ((min lx ly), (max hx hy))
  let size (x:t) : int =
    let (lo,hi) = x in
    hi - lo - (-1)
  let contains (x:t) (i:e) : bool =
    let (lo,hi) = x in
    (lo <= i) && (i <= hi)
  let rless (x:t) (y:t) : bool option =
    let (lx, hx) = x in
    let (ly, hy) = y in
    if hx < ly then Some true
    else if hy < lx then Some false
    else None
end;;

(* Exercice 1: Completer la nouvelle implémentation de RANGE dans le
   module ListRange ci-dessous. La partie qui est déjà implémentée
   devrait vous donner suffisamment d’informations pour implanter le
   reste. Ajouter du code pour tester votre implémentation. *)
    
(* Une implémentation du type de données RANGE avec int comme type des
   éléments et des listes qui représentent une intervalle *)
module ListRange : RANGE with type e = int =
struct
  type e = int
  type t = e list

  (* des fonctions auxilliares *)
  let minmax (l:t) : (e*e) option =
      let rec max (t:t) (e:e) : e =
          match t with
          | [] -> e
          | h::r -> max r h
      in
      match l with
      | [] -> None
      | h::r -> Some (h, (max r h))
  let rec build (i:e) (j:e) : e list =
    if i = j then [j]
    else i :: build (i+1) j
  
  let singleton (i:e) : t = [i]
  let range (i:e) (j:e) : t = build (min i j) (max i j)
  (* TODO Exercise 1: Remplacez tout le code ci-dessous par les
     implémentations correctes des opérations. *)
  let sadd (x:t) (i:e) : t = x
  let smult (x:t) (i:e) : t = x
  let bridge (x:t) (y:t) : t = x
  let size (x:t) : int = 0
  let contains (x:t) (i:e) : bool = false
  let rless (x:t) (y:t) : bool option =
    if List.hd (List.rev x) < List.hd y then Some true
    else if List.hd (List.rev y) < List.hd x then Some false
    else None
end;;

(* TODO Exercice 1: Ajoutez du code de test pour tester votre
   nouvelle implémentation. *)

(* Exercice 2: Implanter une version impérative de RANGE. D'abord,
   vous pouvez copier range.mli, le coller ci-dessous, et changer
   les types si nécessaire. Et puis copiez l'implémentation de
   LoHiPairRange et faites les modifications nécessaires.  If faut
   inclure toutes les opérations qui sont dans la version
   fonctionnelle. Les opérations "singleton" et "range" doivent
   créer une nouvelle intervalle. Les opérations "sadd" et "smult"
   doivent modifier des intervalles existantes. Considerez les choix
   de conception et concevez vôtre propre version du "bridge". *)
