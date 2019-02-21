countDown(N):- writeln(N), NN is N-1, NN > -1, countDown(NN).

element(chlorine,'Cl').
element(helium,'He').
element(hydrogen,'H').
element(nitrogen,'N').
element(oxygen,'O').

find :- repeat, read(X), element(E,X) -> writeln(E); break.

canalOpen( saturday ).
canalOpen( monday ).
canalOpen( tuesday ).

raining( saturday ).

melting( saturday ).
melting( sunday ).
melting( monday ).

secondLast(H,[H|[_|[]]]) :- !.
secondLast(X,[_|T]) :- secondLast(X,T), !.
