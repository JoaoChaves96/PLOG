random_play(B, L, C, Nb, J, S1, Ns1, S2, Ns2):-
  random(1,8,X),
  random(1,4,Y),
  (
    (move(L, C, J, S1, Ns1, S2, Ns2) -> (move_piece_PC(B, L, C, X, Y, Nb, J, S1, Ns1, S2, Ns2) -> true;get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2)); get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2))
  ).


get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2):-
  (
    is_par(J) -> random(1,4,X); random(5,8,X)
  ),
  random(1,4,Y),
  getelem(B, X, Y, Elem),
  (
    Elem \= 's' -> random_play(B, X, Y, Nb, J, S1, Ns1, S2, Ns2); get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2)
  ).

/**process_pieces(J, X, Y, Nl, Nc, BL, BC, NBl, NBc):-
  X1 is X,
  Y1 is Y,
(
  (Y1 = 5 -> Y1 = 0, X1 is X + 1, Y1 is Y + 1),
)
  ((X = 9; Y = 5) -> true; find_best_play(J, X1, Y1, Nl, Nc, BL, BC, NBl, NBc)).*/
