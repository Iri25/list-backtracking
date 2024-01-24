% 3. Se da sirul a1,..., an.
% Se cere sa se determine toate subsirurile strict crescatoare ale sirului a.
%
% Model matematic:
%
% min(l1, ..., ln) = { l1, daca n = 1,
%		       min(l2, ..., ln), altfel }
%
% subsiruri(l1, ..., ln, m) = 1. [], daca n = 0,
%			      2. l1 (+) subsiruri(l2, ..., ln, l1), daca m < l1
%                             3. subsiruri(l2, ..., ln, m)
%
% subsiruriStrictCrescatoare(l1, ..., ln) = 1. subsiruri((l1, ..., ln), min(l1, ..., ln) - 1)
%
%
% Implementare in prolog:
%
% min(L: List, R: Integer)
% model de flux: (i, o) - nedeterminist
% L: Lista de numere
% R: Minimul listei L
%
min([H], H).
min([H | T], R) :- min(T, M),
	H < M,
	!,
	R = H.
min([ _| T], M) :- min(T, M).
%
% subsiruri(L: List, Min: Integer, Rez: List)
% model de flux: (i, o, o) - derminist
% L = Lista initiala
% Min = Un numar care se compara elementele din L (minim)
% R = Lista rezultata
%
subsiruri([], _, []).
subsiruri([H | T], Min, [H | R]) :- Min < H,
    subsiruri(T, H, R).
subsiruri([_ | T], Min, R) :- subsiruri(T, Min, R).
%
% subsiruriStrictCrescatoare(L: List, R: List)
% model de flux: (i, o) - nedeterminist
% L: Lista initiala
% R: Lista rezultata
%
subsiruriStrictCrescatoare(L, [H1, H2 | T]) :- min(L, Min),
    Min1 is Min - 1,
    subsiruri(L, Min1, [H1, H2 | T]).
