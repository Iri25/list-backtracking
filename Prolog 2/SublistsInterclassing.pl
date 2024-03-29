% Prolog 2
%
% Problema 4.
% b) Se da o lista eterogena, formata din numere intregi si liste de numere
% sortate. Sa se interclaseze fara pastrarea dublurilor toate sublistele.
% De exemplu:
% [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
% [1, 2, 3, 4, 6, 7, 9, 10, 11].
%
% Rezolvare 4.b)
%
% Model matematic:
%
% interclasareSubliste(l1,...,ln) = {none, daca n = 0
%				     interclasareSubliste(l2,...,ln)
%				     l1+interclasareSubliste(l2,...,ln),
%				     altfel}
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
% interclasareSubliste(L: List, S: List)
% model de flux: (i, o) - nedeterminist
% L - Lista
% S - Sublista

interclasareSubliste([],[]).
interclasareSubliste([_|T], S):-
	interclasareSubliste(T, S).
interclasareSubliste([H|T], [H|S]):-
	interclasareListe(T, S).

% interclasareSubliste(L: Lis, S: List)
% model de flux: (i, o) - determinist
% L - Lista
% S - Lista de liste

% interclasareSubliste(L, S):-
%	findall(X, interclasareSubliste(L, X), S).

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
