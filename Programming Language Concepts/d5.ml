(*** CSI 3520 Devoir 5 ***)
(*** Il n'y a pas de programmation OCaml pour ce devoir.  Donc vous
     vous n'êtes pas obligé d'utiliser ce fichier.  Par exemple, vous
     pouvez soumettre un fichier Word ou vous pouvez cr\'eer un document
     manuscrit, puis le convertir en pdf \`a l'aide d'un scanner.  ***)
(*** Vous devez inclure VOTRE NOM et VOTRE No ETUDIANT ***)

(* QUESTION 1. Portée dynamique *)
(* Considérons le programme suivant (le même que le programme de la
   question 2 du laboratoire 5).  Cette question est similaire mais
   considère différentes séquences d'appels de fonction.

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

   Supposons une portée dynamique comme dans la question 2 du
   laboratoire 5. Considérez les séquences suivantes d'appels de
   fonction.  Quelles variables sont visibles lors de l'exécution du
   dernier appel de fonction dans chaque séquence? Donnez le nom de
   chaque variable visible et le nom du bloc où elle est déclarée
   (main, f, g ou h).

   (a) main appel h; h appelle f.
   (b) main appel f; f appelle h; h appelle g.
   (c) main appel h; h appelle g; g appelle f.

   Dessinez la pile d'activation complète. Dans chaque enregistrement
   d'activation, incluez les variables locales et le lien dynamique
   uniquement. *)

(* QUESTION 2. Parameter Passing *)
(* Considérez le pseudo-code Algol suivant:

   begin
     procedure pass(x, y);
       begin
         x := x + 1;
         y := x + 1;
         x := y;
       end

     var i : integer;
     i := 1;
     pass(i, i);
     print i;
   end

   Écrivez le numéro imprimé à la fin de l'exécution de ce programme
   pour chacun des mécanismes de passage de paramètres considérés
   ci-dessous. "Passage par valeur-résultat" est expliqué à la question 3
   du laboratoire 5.

   (a) passage par valeur
   (b) passage par référence
   (c) passage par valeur-résultat
 *)

(* QUESTION 3. Fonctions à récursivité terminale *)
(* Considérez la fonction à récursivité terminale en OCaml ci-dessous. *)

let mult_tr (a:int) (b:int) =
  let rec mult' (a:int) (b:int) (result:int) =
    if a = 0 then 0
    else if a = 1 then b + result
    else mult' (a-1) b (result+b)
  in
  mult' a b 0

(* Convertissez ce programme en un programme équivalent qui contient
   une boucle "while" au lieu de la récursion. (Voir page 34 des notes
   de cours pour le chapitre 7 du manuel du cours Mitchell.)  Votre
   programme doit être écrit dans le langage de programmation défini
   dans les notes de cours sur la sémantique axiomatique qui contient
   un instruction d'affection, un instructions conditionnelle, une
   boucle "while" et des séquences d'instructions séparés par un
   point-virgule). Soit P le nom de votre programme.  Le triplet de
   Hoare suivant devrait être vrai.

   { a >= 0 } P { n = a * b }.

   (Vous n'êtes pas obligé de le prouver. Assurez-vous simplement que
   votre programme est correct et se termine si la précondition est
   vraie.)  *)

(* QUESTION 4. Enregistrement d'activation et appels de fonctions récursives *)
(* Considérez l'expression en OCaml ci-dessous. Ignorez la première
   ligne et tracez le pile d'activation pour l'exécution de ce code en
   commençant par la déclaration de la première fonction f et se
   terminant par l'enregistrement d'activation créé au moment où
   l'appel (f 1 1) est exécuté.

   Dans vos enregistrements d’activation, incluez les liens statiques,
   les paramètres, et les variables locales.

   S'il y a des enregistrements d'activation qui doivent être dépiler,
   ne les effacez pas.  Indiquez clairement qu'ils auraient dû être
   dépilés, et continuez de montrez le reste de la pile d'activaction
   en dessous d'eux. *)

let _ = 
  let f (x:int) (y:int) = x*y in
  let rec g (n:int) =
    if n = 0 then 1
    else (let z = g (n-1) in f n z) in
  let f (x:int) (y:int) = x+y in
  g 1
  
(* QUESTION 5. Enregistrements d'activation et fonctions en tant qu'arguments *)
(* Considérez l'expression en OCaml ci-dessous. Ignorez la première
   ligne et tracez le pile d'activation pour l'exécution de ce code en
   commençant par la première déclaration de la variable x et se
   terminant par l'enregistrement d'activation créé au moment de
   l'appel à la fonction h dans le corps de la fonction
   g. Rappelez-vous que les valeurs de fonction sont représentés par
   des fermetures, et rappelez-vous qu'une fermeture est une paire
   composée d'un environnement (pointeur sur un enregistrement
   d'activation) et le code compilé.

   Comme dans la question précédente, incluez les liens statiques, les
   paramètres, et les variables locales dans vos enregistrements
   d’activation. *)

let _ =
  let x = 5 in
  let f (y:int) = (x+y)-2 in
  let g (h:int->int) =
    let x = 7 in h x in
  let x = 10 in
  g f
