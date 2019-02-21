color(snow,white).
size(mountains, tall).
weight(snow, light).
color(mountains, grey).
color(grass, green).
color(trees, green).
grow(grass, mountains).
grow(trees, mountains).
size(trees, tall).
size(grass, low).
color(plains, brown).
grow(wheat, plains).
color(wheat, yellow).
size(wheat, low).

native2BC(A) :- grow(A,mountains),color(A,green).
likedByCows(A) :- grow(A,_),size(A,low).
likedByGoats(A) :- grow(A,mountains).
feed4Animals(A) :- likedByGoats(A),likedByCows(A).


parent(marie,robert).
parent(paul,robert).
parent(paul,emma).
parent(robert,vickie).
parent(robert,anne).
parent(robert,gail).
parent(robert,stan).
parent(stan,jack).
female(marie).
female(emma).
female(gail).
female(anne).
female(vickie).

sister(X,Y) :- parent(Z,X), parent(Z,Y), female(X).


combat(paul,pierre).
combat(jean,simon).
combat(jean,pierre).

allies(X,Y) :- combat(X,Z),combat(Y,Z).
