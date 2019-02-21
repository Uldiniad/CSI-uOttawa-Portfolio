% room lighting
lit( roomA, lightA ).
lit( roomB, lightB ).
lit( roomA, lightC ).
lit( roomC, lightD ).
lit( roomC, lightE ).

% light switches
control( lightA, switch1 ).
control( lightB, switch2 ).
control( lightB, switch1 ).
control( lightC, switch3 ).
control( lightD, switch4 ).
control( lightE, switch4 ).

% wiring of lights
hardwire(lightA).
hardwire(lightB).
hardwire(lightD).
plug( lightC, socketA ).
plug( lightE, socketB ).

% fuses
fuse( lightA, fuse1 ).
fuse( lightB, fuse2 ).
fuse( socketA, fuse2 ).
fuse( lightD, fuse3 ).
fuse( socketB, fuse3 ).

% fuse ok
ok( fuse1 ).
ok( fuse2 ).
ok( fuse3 ).

% switches on
isOn( switch2 ).
isOn( switch3 ).
isOn( switch4 ).



connected(L) :- fuse(L, F),
		ok(F).

connected(L) :- plug(L,S),
		fuse(S,F),
		ok(F).

bright(X) :- lit(X, L),
	     control(L, S),
	     isOn(S),
	     connected(L).

