clockNextS(c(H,M,S),c(H,M,S1)) :- S < 59, S1 is S+1.
clockNextS(c(H,M,59),c(H,M1,0)) :- M < 59, M1 is M+1.
clockNextS(c(H,59,59),c(H1,0,0)) :- H < 23, H1 is H+1.
clockNextS(c(23,59,59),c(0,0,0)).

factorial(0,1).
factorial(N,F) :- N>0, N1 is N-1, factorial(N1,F1), F is N*F1.

ack(0,N,X) :- X is N+1.
ack(M,0,X) :- M>0, M1 is M-1, a(M1,1,X).
ack(M,N,X) :- M>0, N>0, M1 is M-1, N1 is N-1, a(M,N1,A1), a(M1,A1,X).

p(a).
p(X) :- q(X), r(X).
p(X) :- u(X).

q(X) :- s(X).

r(a).
r(b).

s(a).
s(b).
s(c).

u(d).

part(a). part(b). part(c).
red(a). black(b).
color(P,red) :- red(P),!.
color(P,black) :- black(P),!.
color(P,unknown).
