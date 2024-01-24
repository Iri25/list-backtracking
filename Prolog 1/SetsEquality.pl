% Prolog 1
%
% Problema 14.
% a. Sa se scrie un predicat care testeaza egalitatea a doua multimi, fara sa se faca apel la diferenta a doua multimi.
% b. Definiti un predicat care selecteaza al n-lea element al unei liste.


% Rezolvare a.
%
% Model matematic:
% egalitateMultimi(l1,...,ln,p1,...,pn) = {true, daca l vida si p vida
%                                             false, l1 != p1
%					      egalitateMultimi(l2,...,ln,p1,...,pn),altfel}
%
% Implementare in Prolog:
% el = integerlist = el*
% egalitateMultimi(L: List, P: List)
% model de flux: (i, i)
% L - Prima lista
% P - A doua lista

egalitateMultimi([],[]).
egalitateMultimi([_|T1], [_|T2]):-
	T1 = L,
	T2 = P,
	egalitateMultimi(L, P).


% Rezolvare b.
%
% Model matematic:
% selectN(l1,...,ln,k,elem) = {elem, daca n = 0 si k = 1
%			      none, daca n = 0 si k > 1
%			      elem, daca n != 0 si k > 1
%			      select(l2,...,ln,k-1,elem), altfel}
%
% Implementare in Prolog:
% selectN(L: List, K: integer, E: element)
% model de flux: (i, i, o)
% L - Lista din care se selecteaza
% K - Al n-lea element al listei
% E - Elementul care se selecteaza

selectN([H|_], 1, E):-
	H=E,
	!.
selectN([], _, _):-!.
selectN([_|T], N, E):-
	N1 is N-1,
	selectN(T, N1, E).


