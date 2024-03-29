% Prolog 2
%
% Problema 4.
% a) Sa se interclaseze fara pastrarea dublurilor doua liste
%
% Rezolvare 4.a)
%
%
% Model matematic:
%
% interclasareListe(l1,...,ln,p1,...,pm) = {p, daca n = 0
%					    l, daca m = 0
%					    p + l, altfel}
%
% nrAparitii(l1,...,ln,e) = {0, daca n = 0
%			    1 + nrAparitii(l2,...,ln,e), daca l1 = e
%			    nrAparitii(l2,...,ln,e), altfel}
%
%
% elimina(l1,...,ln,p1,...,pm) = {none, daca n = 0
%				  elimina(l2,...,ln,p1,...,pm), daca
%				  nrAparitii(p1,...,pm,l1) = 1
%				  l1 + elimina(l2,...,ln,p1,...,pm),
%				  altfel}
%
% eliminaMain(l1,...,ln) = elimina(l1,...,ln,l1,...,ln)
%
% Implementare in Prolog
%
% el = integer
% list = el*
%
% interclasareListe(L1: List, L2: List, L3: List)
% model de flux: (i, i, o), (i, o, i), (o, i, i) - determinist
% model de flux: (o, o, i) - nedeterminist
% L1 - Prima lista
% L2 - A doua lista
% L3 - Lista rezultata prin interclasarea celor doua liste

interclasareListe([], L, L).
interclasareListe(L, [], L).
interclasareListe([H|L1], L2, [H|L3]):-
	interclasareListe(L1, L2, L3).

% nrAparitii(L: List, E: element, R: integer)
% model de flux: (i, i, o) sau (i, i, i) - determinist
% L - Lista în care numărăm aparitiile
% E - Elementul ale cărui apariții numărăm
% R - Rezultatul, numărul de apariții ale lui E in lista L

nrAparitii([], _, 0).
nrAparitii([H|T], E, R):-
	H = E,
	nrAparitii(T, E, R1),
	R is R1 + 1.
nrAparitii([H|T], E, R):-
	H \= E,
	nrAparitii(T, E, R).

% elimina(L: List, C:List, R:List)
% model de flux: (i, i, o) sau (i, i, i)
% L - Lista din care eliminam elementele care se repeta
% C - O copie a listei originare, folosita pentru numărarea aparițiilor
% R - lista rezultat
%
elimina([], _, []).
elimina([H|T], C, R):-
	nrAparitii(C, H, S),
	S = 1,
	elimina(T, C, R).
elimina([H|T], C, [H|R]):-
	nrAparitii(C, H,S),
	S > 1,
	elimina(T, C, R).

% eliminaMain(L: List, R:List)
% model de flux: (i, o) sau (i, i)
% L - lista originala din care eliminam elementele care se repeta
% R - lista rezultat
%
eliminaMain(L, R):-elimina(L,L,R).
