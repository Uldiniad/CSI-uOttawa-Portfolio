(*** CSI 3120 Assignment 6 ***)
(*** YOUR NAME HERE ***)
(*** YOUR STUDENT ID HERE ***)
(*** OCAML VERSION USED FOR THIS ASSIGNMENT HERE ***)
(* If you use the version available from the lab machines via VCL, the
   version is 4.05.0 ***)

(*************)
(* PROBLEM 1 *)
(*************)

(* Problem 1(a). Write a function "sublist_starting_at_index" that
   takes two arguments, an integer "n" and a list "l".  This function
   must return the sublist of "l" starting at position "n".  Assume
   that the first position in a list is 1.  If there is no such
   position, then the function should raise an exception.  You can
   assume that the function will always be called with a positive
   number.  (You don't have to handle the case when it is not.)

   Your function should have the following behaviour on the sample
   tests below. *)

(*
# sublist_starting_at_index 1 [1;2;3;4;5;6];;
- : int list = [1; 2; 3; 4; 5; 6]
# sublist_starting_at_index 4 [1;2;3;4;5;6];;
- : int list = [4; 5; 6]
# sublist_starting_at_index 6 [1;2;3;4;5;6];;
- : int list = [6]
# sublist_starting_at_index 7 [1;2;3;4;5;6];;
Exception: NoSuchSublist.
# sublist_starting_at_index 2 [true;false];;
- : bool list = [false]
 *)

(* Problem 1(b). Now consider the definition of the recursive function
   "find" below and consider a call to the function with 1 as the
   value of "n".  If there are recursive calls, the value of "n" is
   increased by 1 each time.  If (Found n) is raised in some call (the
   original call or a later recursive call), then the "n" that is
   passed to the exception handler represents the position in the
   original list "l" where the first element satisfying predicate "p"
   occurs.  This function never terminates normally.  If there is no
   element satisfying "p", then it raises an exception "NotFound".  If
   it finds an element satisfying "p", it raises an exception "Found"
   and includes "n" as the data to be passed to a handler.  We assume
   that this function will always be called with a positive value for
   "n". (It does not handle the case when it is not. *)

exception Found of int
exception NotFound

let rec find (p:'a->bool) (n:int) (l:'a list) : int =
  match l with
  | [] -> raise NotFound
  | (h::t) -> if (p h) then raise (Found n)
              else find p (n+1) t

(* Fill in the definition of the following function which also takes 3
   arguments with the same types as "find".  This function must return
   the index of the first occurrence of an element satisfying "p" in
   the sublist of "l" starting at position "n", if there is one.  Use
   the function "find" above, and your function
   "sublist_starting_at_index" from 1(a).  Your function should
   handle the exception Found by returning the data that is passed to
   the handler.  Also, handle the exception NotFound by returning 0,
   and handle the exception NoSuchSublist by returning the value (-1).
   Also add a new exception that is raised when the input "n" is not a
   positive number, and handle it by returning (-2).

let find_starting_at p n l = *)


(*************)
(* PROBLEM 2 *)
(*************)

(* Problem 2(a). Write a new version of "find" above called "find2",
   which takes two additional arguments, one for a normal continuation
   and one for an errror continuation (see the example on page 24 of
   the course notes for Chapter 8 of the Mitchell textbook). Instead
   of raising exceptions, call the appropriate continuation.  *)

(* Problem 2(b). Fill in the definition of the function
   "find_and_continue" below.  Your function should call "find2" with
   a normal continuation that multiplies its input by 2, and an error
   continuation that prints the string "NotFound" and then returns
   0.

let find_and_continue p n l =
 *)
                                                      

(*************)
(* PROBLEM 3 *)
(*************)

(* Below is the OCaml code used for Force and Delay as described in
   Chapter 8 of the Mitchell textbook. *)
      
type 'a delay =
  | EV of 'a
  | UN of (unit -> 'a)

let ev (d:'a delay) : 'a =
  match d with
  | EV x -> x
  | UN f -> f()

let force (d:'a delay ref) : 'a =
  let v = ev !d in
  (d := EV v; v)

(* Problem 3(a). Write a new version of "find" above called "find3"
   that uses the above implementation of "Force" and "Delay".  In this
   version, the third argument will have type 'a delay ref list, and
   your function must use "force" to evaluate each element. *)

(* Problem 3(b). Give an example input list with at least 3 elements by
   filling in the missing parts of the definition of "delay_list"
   below.  Each element must be a reference to an unevaluated
   arithmetic expression (using the "UN" constructor of the 'a delay
   data type).  Use the code at the end to test your answer.

let delay_list = [ref (UN (fun () -> *** Insert your code here. ***]

let test3b = find3 (fun x -> x = 6) 1 delay_list
let _ = delay_list
 *)


(*************)
(* PROBLEM 4 *)
(*************)

(* Consider the data type below for expressions given by the simple
   grammar in the last lab.

   e ::= num | e + e *)

type exp =
  | Number of int
  | Sum of exp * exp

(* Problem 4(a). Create expressions similar to the examples in the
   lab, but this time as expressions having type "exp":
   - An expression "a_exp" representing the number 3
   - An expression "b_exp" representing the number 0
   - An expression "c_exp" representing the number 5
   - An expression "d_exp" representing the sum of "a" and "b"
   - An expression "e_exp" representing the sum of "d" and "c"

let a_exp : exp = 
let b_exp : exp = 
let c_exp : exp = 
let d_exp : exp = 
let e_exp : exp = 
*)

(* Problem 4(b).  Some of the code for the class hierarchy from the
   lab is given below.  It includes the parent class "expression", and
   the subclasses "number_exp" and "sum_exp". *)

class virtual expression = object
  method virtual is_atomic : bool
  method virtual left_sub : expression option
  method virtual right_sub : expression option
  method virtual value : int
end

class number_exp (n:int) = object
  inherit expression as super
  val mutable number_val = n
  method is_atomic = true
  method left_sub = None
  method right_sub = None
  method value = number_val
end               

class sum_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value + right_exp#value
end

(* Write a function that translates an expression of type "exp" (the
   data type defined in 4(a)) to an object belonging to the
   appropriate class by filling in the following function definition.
   Test your function definition by translating "e_exp" as defined in
   part 4(a) and then sending the "value" message to the result of this
   translation.

let exp2expression (e:exp) : expression =
 *)
