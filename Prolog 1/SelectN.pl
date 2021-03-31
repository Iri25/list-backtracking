% Rezolvare b.
%
% Model matematic:
% selectN(l1,...,ln,k,elem) = {none, daca n = 0 si k > 0
%			      elem, daca n != 0 si k > 0
%			      select(l2,...,ln,k-1,elem), altfel}
%
% Implementare in Prolog:
% selectN(L: List, N: integer, E: element)
% model de flux: (i, i, o)
% L - Lista din care se selecteaza
% N - Al n-lea element al listei
% E - Elementul care se selecteaza

selectN([], _, _):-!.
selectN([_|T], N, E):-
	N > 0,
	N1 is N-1,
	selectN(T, N1, E).
