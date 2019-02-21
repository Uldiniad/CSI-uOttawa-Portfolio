permitted(robert,fishing).
permitted(jochen,driving).
permitted(paul,fishing).
permitted(jean,weapons).
permitted(jean,driving).
permitted(sam,weapons).
permitted(sam,fishing).

p(X) :- b(X), c(Y).
p(X) :- a(X).
c(X) :- d(X).
a(1).
a(2) :- !.
a(3).
b(4).
b(5).
d(6).
d(7).

prerequisite(csi2520,csi2510).
prerequisite(csi2520,csi2610).
prerequisite(csi2510,iti1521).
prerequisite(csi2510,mat1748).
prerequisite(csi2510,csi2772).
