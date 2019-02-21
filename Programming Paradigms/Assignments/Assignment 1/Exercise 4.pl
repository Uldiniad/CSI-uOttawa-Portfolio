absDiff([],[],[]).
absDiff([A|B],[C|D], L) :- absDiff(B,D,Conjunction), X is abs(A-C), push(Conjunction,X, L).

absDiffA(Rest,[],L) :- append([],Rest,L).
absDiffA([],Rest,L) :- append([],Rest,L).
absDiffA([A|B],[C|D], L) :- absDiffA(B,D,Conjunction), X is abs(A-C), push(Conjunction,X, L).

absDiffB(_,[],[]).
absDiffB([],_,[]).
absDiffB([A|B],[C|D], L) :- absDiffB(B,D,Conjunction), X is abs(A-C), push(Conjunction,X, L).

push(List,Element,[Element|List]).
