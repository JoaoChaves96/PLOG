:- use_module(library(lists)).
:- use_module(library(clpfd)).

board([
      S1 , S2 , S2 , S3 , S3 , S3 , S3 ,
      S1 , S1 , S2 , S4 , S4 , S3 , S5 ,
      S6 , S7 , S2 , S2 , S4 , S5 , S5 ,
      S6 , S7 , S7 , S2 , S8 , S8 , S5 ,
      S6 , S6 , S9 , S2 , S2 , S8 , S5 ,
      S6 , S10, S9 , S9 , S2 , S11, S11,
      S10, S10, S10, S10, S2 , S2 , S11
]).

display_board([L1|Ls]):-
	write('|'),
	display_line(L1),
  nl,
  write(' --------------------------- '),
  nl,
	display_board(Ls).

display_board([],_,_,_).

display_line([E|Es]):-
	translate(E,V),
	write(' '),
	write(V),
	write(' |'),
	display_line(Es).

display_line([]).

clue_line([5,5,-1,4,-1,4,-1]).
clue_column([-1, 3, -1, -1, -1, 5, -1]).

/*myfunc(Board, Lines, N):-
    element(N, Lines, -1).
    /*,
    N1 is N+1,
    myfunc(Board, Lines, N1).

myfunc(Board, Lines, N):-
  element(N, Lines, NrPintados),
  NrPintados #\= -1,
  count(1, Board, #=, NrPintados).
  /*N1 is N + 1,
  myfunc(Board, Lines, N1).

myfunc([L1|Ls], Lines, N):-
    element(N, Lines, -1),
    N1 is N+1,
    myfunc(Ls, Lines, N1).

myfunc([L1|Ls], Lines, N):-
  element(N, Lines, NrPintados),
  NrPintados #\= -1,
  element(N, L1, Line),
  count(1, Line, #=, NrPintados),
  N1 is N + 1,
  myfunc(Ls, Lines, N1).

myfunc(_,_,_).

getsum(Line, N, Lines):-
  element(N, Lines, NrPintados),
  NrPintados #= -1.

getsum(Line, N, Lines):-
  element(N, Lines, NrPintados),
  NrPintados #\= - 1,
  count(1, Line, #=, NrPintados).*/

solve(L1, L2, L3, L4, L5, L6, L7, Lines, Columns):-
  L1 = [S1 , S2 , S2 , S3 , S3 , S3 , S3],
  L2 = [S1 , S1 , S2 , S4 , S4 , S3 , S5],
  L3 = [S6 , S7 , S2 , S2 , S4 , S5 , S5],
  L4 = [S6 , S7 , S7 , S2 , S8 , S8 , S5],
  L5 = [S6 , S6 , S9 , S2 , S2 , S8 , S5],
  L6 = [S6 , S10, S9 , S9 , S2 , S11, S11],
  L7 = [S10, S10, S10, S10, S2 , S2 , S11],
  domain(L1, 0, 1),
  domain(L2, 0, 1),
  domain(L3, 0, 1),
  domain(L4, 0, 1),
  domain(L5, 0, 1),
  domain(L6, 0, 1),
  domain(L7, 0, 1),

  %%%%%%%%%%Contagem das linhas%%%%%%%%%%
  element(1, Lines, NL1),
  element(2, Lines, NL2),
  element(4, Lines, NL4),
  element(6, Lines, NL6),
  S1 + S2 + S2 + S3 + S3 + S3 + S3 #= NL1,
  S1 + S1 + S2 + S4 + S4 + S3 + S5 #= NL2,
  S6 + S7 + S7 + S2 + S8 + S8 + S5 #= NL4,
  S6 + S10 + S9 + S9 + S2 + S11 + S11 #= NL6,
  /*count(1, L1, #=, 5),
  count(1, L2, #=, 5),
  count(1, L4, #=, 4),       ---->Nao percebo porque nao funciona com o count...
  count(1, L6, #=, 4)*/

  %%%%%%%%%%Contagem das colunas%%%%%%%%%%
  element(2, Columns, NC2),
  element(6, Columns, NC6),
  S2 + S1 + S7 + S7 + S6 + S10 + S10 #= NC2,
  S3 + S3+ S5 + S8 + S8 + S11+ S2 #= NC6,

  labeling([],L1),
  labeling([],L2),
  labeling([],L3),
  labeling([],L4),
  labeling([],L5),
  labeling([],L6),
  labeling([],L7).


translate(s1,'1 ').
translate(s2,'2 ').
translate(s3,'3 ').
translate(s4,'4 ').
translate(s5,'5 ').
translate(s6,'6 ').
translate(s7,'7 ').
translate(s8,'8 ').
translate(s9,'9 ').
translate(s10,'10').
translate(s11,'11').
translate(1, 'X').
translate(0, ' ').

display_full_board(B):-
  nl,
  write(' --------------------------- '),nl,
  display_board(B).

main:-
  clue_line(L),
  clue_column(C),
  solve(L1, L2, L3, L4, L5, L6, L7, L, C),
  append([], [L1], Nb),
  append(Nb, [L2], Nb2),
  append(Nb2, [L3], Nb3),
  append(Nb3, [L4], Nb4),
  append(Nb4, [L5], Nb5),
  append(Nb5, [L6], Nb6),
  append(Nb6, [L7], Nb7),
  display_full_board(Nb7).
