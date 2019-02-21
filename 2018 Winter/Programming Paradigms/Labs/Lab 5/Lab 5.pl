color(red).
color(green).
color(blue).

leafNodes(t(Root,nil,nil),Root).
leafNodes(t(_,Left,Right),List) :- (Left \== nil,leafNodes(Left,List));(Right \== nil,leafNodes(Right,List)).

bunkbeds(L):- L=[[N1,C1],[N2,C2],[kayla,C3],[N4,C4],[N5,C5],[N6,C6]],((N1=reeva,N2=haley);(N2=reeva,N1=haley)),.
