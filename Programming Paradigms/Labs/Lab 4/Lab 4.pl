maxmin(List,Max,Min) :- sort(List,Sorted), min(Sorted,Min), last(Sorted,Max).

min([H|_],H).
