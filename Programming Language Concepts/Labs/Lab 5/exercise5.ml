(*
  Ordre du jour:
   * portée
   * passage de paramètres
   * fonctions à récursivité terminale
 *)

(* QUESTION 1. Portée statique *)
(* 1 Considérons le programme suivant dans le pseudo-code de style Algol
   utilisé dans le manuel, où f, g et h sont des fonctions (chacune avec
   un paramètre) et le corps de la fonction est entre  {}.

{ begin
  int x = ...
  int y = ...
  int z = ...
  int f (int u)
      { int a = ...
        int y = ...
        int z = ...
        ...code de la fonction f...
      }
  int g (int u)
      { int a = ...
        int x = ...
        int w = ...
        int h (int v
            { int a = ...
              int b = ...
              int z = ...
              ...code de la fonction h...
            }
        ...code de la fonction g...
      }
  ...code du "main" (bloc principal)...
}                

   Supposons que la portée statique est utilisée.
   (i) Énumérez toutes les variables visibles dans le corps de f,
       et indiquez l'endroit où ils sont déclarés.
   (ii) Faites de même pour la fonction g.
   (iii) Faites de même pour la fonction h.
   (iv) Traduisez le code ci-dessus en OCaml en donnant des valeurs de
   votre choix aux variables.  Dans le code du bloc "main", faires des
   appels aux fonctions f et g en utilisant des paramètres de votre
   choix.  Dans le corps de chaque fonction, insérez des instructions
   qui impriment les noms de chaque variable qui est visible et qui
   impriment aussi son valeur. *)

(* QUESTION 2. Portée dynamique *)
(* Considérons le programme suivant (une version modifiée du programme
   précédent L'entrée de chaque fonction a le type unité, c'est-à-dire
   n'a aucune entrée).

{ begin
  int x = ...
  int y = ...
  int z = ...
  int f ()
      { int a = ...
        int y = ...
        int z = ...
        ...code de la fonction f...
      }
  int g ()
      { int a = ...
        int b = ...
        int z = ...
        ...code de la fonction g...
      }
  int h ()
      { int a = ...
        int x = ...
        int w = ...
        ...code de la fonction h...
      }
  ...code du "main" (bloc principal)...
}                
    Cette fois supposons une portée dynamique. Considérez les
    séquences suivantes des appels de fonction.  Quelles variables
    sont visibles lors de l'exécution du dernier appel de fonction
    dans chaque séquence? Donnez le nom de chaque variable visible
    et le nom du bloc où elle est déclarée (main, f, g ou h).
   (i) appels principaux f; f appelle g; g appelle h.
   (ii) appels principaux f; f appelle h.
   (iii) appels principaux g; g appelle h; h appelle f.
   Dessinez la pile d'activation complète. Dans chaque enregistrement
   d'activation, incluez les variables locales et le lien de dynamique
   uniquement. *)

(* QUESTION 3. Passage des paramètres *)
(* Dans "passage par valeur-résultat" (appelé en anglais
   "pass-by-value-result", "call-by-value-result" or
   "copy-in/copy-out", une valeur est passée à la fonction de la même
   manière que "passage par valeur", mais le corps de la fonction
   traite ce paramètre comme dans "passage par référence".  Plus
   précisément, supposons que la fonction f a un paramètre "u" qui est
   désigné "passe par valeur-résultat" et que la fonction est appelé
   en passant le paramètre réel "v".  Dans l’enregistrement
   d’activation de f, "u" sera un pointeur vers une cellule qui est
   initialisé à la valeur-R de "v". Dans le corps de f,
   l'identificateur "u" est traité comme une variable modifiable.  Au
   retour de l'appel de f, le paramètre actuel "v" est donné la
   valeur-R de "u".

   Le pseudo-code Algol suivant illustre les propriétés principales de
   "passage par valeur-résultat".

   var x : integer;
   x := 0;
   procedure p(value-result y : integer)
     begin
        y := 1;
        x := 1;
     end;
   p(x);

   Dans cet exemple, la valeur finale de "x" sera 1.  L'identificateur
   "y" est une pointeur a une adresse qui est distinct de "x".  Donc,
   l'instruction "x := 1" ne change pas la valeur locale de
   "y". Lorsque la fonction se termine, le la valeur de "y" est copiée
   au paramètre actuel "x".  Par contre, en utilisant le "passage par
   référence", "x" et "y" seraient deux pointeurs sur la même adresse
   ("aliases") et l'instruction "x := 1" changerait la valeur de "y"
   en 0 et la valeur finale de "x" serait 0.  Finalement, en utilisant
   le "passage par valeur", l'instruction "y := 1" dans le corps de
   "p" ne changerait pas la variable globale "x" et la valeur finale
   de "x" serait 0 dans ce cas aussi.

   Traduisez le fragment de programme précédent dans OCaml de manière
   qui montre explicitement les opérations sur les reférences et qui
   montre les différences entre les valeurs-L et les
   valeurs-R. Décommentez le code ci-dessous et remplissez-le avec
   votre solution.

let x = ref 0
let p (y' : int ref) : unit =
 ...
let result = p x
let _ = x

 *)

(* QUESTION 4. Fonctions à récursivité terminale *)
(* Deux versions de la fonction factorielle sont ci-dessous. la première
   fonction ("fact") n'est pas récursive et la seconde fonction
   ("fact_tr") est une fonction à récursivité terminale. Notez que "fact_tr" appel une
   fonction auxiliaire qui a un argument supplémentaire.  Cet argument enregistre le
   calcul jusqu'à présent.

   En utilisant le même style, transformez la fonction "power"
   ci-dessous en une fonction à récursivité terminale. Cette fonction
   calcul la puissance "b" de l’entrée "a" en utilisant la
   multiplication.  Employez une fonction auxiliaire qui a un
   troisième paramètre qui représente le résultat de la calcul jusqu'à
   présent. *)

let rec fact (n:int) =
  if n = 0 then 1 else n*fact(n-1)

let fact_tr (n:int) =
  let rec fact' (n:int) (a:int) =
    if n = 0 then 1 else fact' (n-1) (n*a) in
  fact' n 1

let rec power (a:int) (b:int) =
  if b = 0 then 1
  else if b = 1 then a
  else a*power a (b-1)

