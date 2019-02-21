(* Hello CSI 3120 in OCaml

   To compile and run this file:

   At your prompt ($), compile this file using the following (don't type "$"):

   $ ocamlbuild hello.d.byte

   The termination ".d.byte" means compile in debug mode for the 
   OCaml bytecode interpreter.  You should see a _build directory
   appear in the current directory as well as a file named hello.d.byte
   Execute the file by next typing:

   $ ./hello.d.byte

   In general, to compile a file named "foo.ml", use

   $ ocamlbuild foo.d.byte

   For more on using ocamlbuild, see:

   http://caml.inria.fr/pub/docs/manual-ocaml/manual032.html
*)

print_string "Bonjour CSI 3520!!\n";;
