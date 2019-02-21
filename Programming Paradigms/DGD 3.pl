%likes(colbert,X) :- animal(X),not(bear(X)).
%likes(colbert,X) :- toy(X),not(bear(X)).
%likes(colbert,X) :- livesInArctic(X),not(bear(X)).

bear(yogi).
cat(tom).
animal(yogi).
animal(tom).
%likes(colbert,X) :- bear(X),!,fail.
likes(colbert,X) :- bear(X) -> !,fail.
likes(colbert,X) :- animal(X).

firstElement([4,2,6],2).

lastElement([X],X).
lastElement([_|L],X) :- lastElement(L,X).


countElements([_],1).
countElements([_|T],N1) :- countElements(T,N), N1 is N+1.


occurrence([],_,0).
occurrence([X|L],X,N) :- occurrence(L,X,N1), N is N1+1.
occurrence([Y|L],X,N) :- not(X=:=Y), occurrence(L,X,N).

main :- open('fruits.txt', read, Str), read_file(Str,lines), close(Str), write(lines).
read_file(Stream,[]) :- at_end_of_stream(Stream).
read_file(Stream, [X|L]) :- not(at_end_of_stream(Stream)),read(Stream,X),read_file(Stream,L).

insertion(X,[],[X]).
insert(X,[Y|L],[X,Y|L]) :- X =< Y.
insert(X,[Y|L],[Y|L1]) :- X > Y, insertion(X,L,L1).

insertion_sort([],[]).
insertion_sort([X|L],LT) :- insertion_sort(L,L1), insertion(X,L1,LT).


