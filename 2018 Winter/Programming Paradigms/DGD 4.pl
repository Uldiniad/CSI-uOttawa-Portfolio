sup_k(X,[X|Xs],1,Xs).
sup_k(X,[Y|Xs],K,[Y|Ys]) :- K>1, K1 is K-1, sup_k(X,Xs,K1,Ys).

deleteDup([],Result).
deleteDup(List,Result) :- sort(List,Result).

equalList(X,Y) :- check(X,Y), check(Y,X).
check([],List).
check([A|B],List) :- member(A,List), check(B,List).

