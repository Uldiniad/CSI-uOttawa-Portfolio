student(name(blake,[ann]),33333,['CSI2120']).
student(name(carp,[tony,a]),76543,[]).
student(name(doe,[jane,j]),88345,['CSI2120']).

evaluation('CSI2120',assignment(1),['Prolog',database],5).
evaluation('CSI2120',labQuiz(1),['Prolog',queries],1).
evaluation('CSI2120',midterm(1),['Prolog'],26).

mark('CSI2120',33333,assignment(1),3.5).

addStudent :- write('Student Last Name: '),read(LN),write('Student First Name: '),read(FN),write('Student ID: '),read(ID),not(student(_,ID,_)),not(student(name(LN,[FN]),_,_)),assertz(student(name(LN,[FN]),ID,[])).

add(Course,Student) :- student(_,Student,L),member(Course,L),!.
add(Course,Student) :- student(Name,Student,L),retract(student(Name,Student,L),assertz(student(Name,Student,[Course|L]))).

addAllMarks(Course,Evaluation) :- student(Name,ID,Courses),member(Course,Courses),evaluation(Course,Evaluation,_,Mark),not(mark(Course,ID,Evaluation,_)),enterMark(Name,Mark,MS),assertz(mark(Course,Student,Evaluation,MS)),addAllMarks(Course,Evaluation).

listAllMarks(Course,Evaluation,List) :- setof([Student,Mark],mark(Course,Student,Evaluation,Mark),List).

cleanList(L,LL) :- cleanListDCG(LL,L,[]),!.

cleanListDCG([A|B]) --> [A],{number(A)},cleanListDCG(B).
cleanListDCG(L) --> [A],{not(number(A))},cleanListDCG(L).
cleanListDCG([A]) --> [A],{number(A)} .
cleanListDCG([]) --> [A],{not(number(A))}.
