(*  FizzBuzz Program:  Specification modified from:

http://fsharpforfunandprofit.com/posts/railway-oriented-programming-carbonated/

Write a program that prints the numbers from 0 to 100, one per line. 
* For multiples of three print "Fizz" instead of the number.
* For multiples of five print "Buzz". 
* For numbers which are multiples of both three and five print "FizzBuzz".
*)

for i = 0 to 100 do
	if i mod 3 <> 0 && i mod 5 <> 0
		then print_int i
	else
	if i mod 3 = 0
	then
		print_string "Fizz";
	if i mod 5 = 0
	then
		print_string "Buzz";
print_newline()
done;;