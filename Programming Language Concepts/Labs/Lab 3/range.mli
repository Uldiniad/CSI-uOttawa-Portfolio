module type RANGE =
sig
  (* les types *)
  (* type de l'intervalle *)
  type t
  (* type des élements *)
  type e
    
  (* constructeurs *)
  (* construire une intervalle d'un seul point *)
  val singleton : e -> t
  (* construire une intervalle de deux extrémités *)
  val range : e -> e -> t

  (* modificateurs *)
  (* "scalar add range", par exemple si r est une intervalle de -4 à 6,
     sadd r 1 la modifie pour devenir une intervalle de -3 à 7.
     Cette opération ne modifie pas la taille de l'intervalle *)
  val sadd : t -> e -> t
  (* "scalar multiply range", par exemple si r est une intervalle de 2 à 4,
     smult r 3 la modifie pour devenir une intervalle de 6 à 12.
     Cette opération peut changer la taille de l'intervalle. *)                        
  val smult : t -> e -> t
  (* modifie le premier argument pour qu'il devient une intervalle qui
     couvre les deux intervalle données, par exemple, si on les
     entrées sont une intervalle de -4 à 6 et une intervalle de 10 à
     12, la première intervalle est modifiée pour devenir une
     intervalle de -4 à 12. *)
  val bridge : t -> t -> t

  (* observateurs *)
  (* combien d'éléments sont dans l'intervalle? *)
  val size : t -> int
  (* est-ce qu'elle contient e? *)
  val contains : t -> e -> bool
  (* Est-ce qu'un élément arbitraire de la première intervalle est
     moins qu'un élément arbitraire de la deuxième intervalle?  Si les
     intervallees se chevauchent, renvoyer None, parce que les
     réponses diffèrent selon l'élément choisi.
     Sinon, renvoie le résultat d'un test qui détermine si le maximum
     de la première intervalle < le minimum de la deuxième intervalle
     *)
  val rless : t -> t -> bool option
      
end
