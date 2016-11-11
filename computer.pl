random_play(B, L, C, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2):-
  random(1,8,X),
  random(1,4,Y),
  nl, nl,  write(L), write(C), write('  '), write(X), write(Y), nl,
  (
    move_piece_PC(B, L, C, X, Y, Nb, J, S1, Ns1, S2, Ns2) -> true; get_rand_piece(B, L1, C1, Nl1, Nc1, Nb, J, S1, Ns1, S2, Ns2)
  ).


get_rand_piece(B, L, C, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2):-
  (
    is_par(J) -> random(1,4,X); random(5,8,X)
  ),
  random(1,4,Y),
  X1 is 4,
  getelem(B, X, Y, Elem),
  nl, nl,
  write(Elem),
  nl, nl,
  (
    Elem \= 's' -> random_play(B, X1, Y, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2); get_rand_piece(B, L1, C1, Nl1, Nc1, Nb, J, S1, Ns1, S2, Ns2)
  ).
