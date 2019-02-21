leftNodes(T,L) :- leftNodes(T,[],L).

leftNodes(nil,LA,LA) :- !.

leftNodes(t(Root,Left,nil),LA,L) :- (Left \== nil),!,leftNodes(Left,LA,LL),append(LL,[Root],L).

leftNodes(t(_,Left,Right),LA,L) :-
    leftNodes(Left,LA,LL),
    leftNodes(Right,LA,LR),
    append(LL,LR,L).
