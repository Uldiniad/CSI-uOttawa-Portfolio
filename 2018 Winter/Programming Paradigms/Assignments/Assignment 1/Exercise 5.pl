flower(rose,red).
flower(marigold,yellow).
flower(tulip,red).
flower(daffodil,yellow).
flower(rose,yellow).
flower(maigold,red).
flower(rose,white).
flower(cornflower,purple).

bouquet(Flowers) :- write("Case 1"),bagof(Flower,(flower(Flower,red)), AllReds),bagof(Flower,Colour^(flower(Flower,Colour)),AllFlowers),permutation(AllReds,RedsPermutation),last(RedsPermutation,Last),delete(RedsPermutation,Last,RedPair),member(Other,AllFlowers),not(member(Other,RedPair)),append(RedPair,[Other],Flowers).

bouquet(Flowers) :- write("Case 2"),flower(Flower1,Colour1),flower(Flower2,Colour2),flower(Flower3,Colour3),Flower1 \== Flower2, Flower2 \== Flower3, Flower1 \== Flower3,Colour1 \== Colour2,Colour2 \== Colour3,Colour1 \== Colour3,append([Flower1,Flower2,Flower3],[],Flowers).
