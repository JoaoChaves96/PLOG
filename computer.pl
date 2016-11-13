%%%%%%%%%%%%%%%Tries a random move to the piece given%%%%%%%%%%%%%%%
random_play(B, L, C, Nb, J, S1, Ns1, S2, Ns2):-
  random(1,8,X),
  random(1,4,Y),
  nl,write('From: '), write(L), write(' '), write(C), write('; To: '), write(X), write(' '), write(Y), nl,
  (
    (move(L, C, J, S1, Ns1, S2, Ns2) -> (move_piece_PC(B, L, C, X, Y, Nb, J, S1, Ns1, S2, Ns2) -> true;get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2)); get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2))
  ).


%%%%%%%%%%%%%%%Gets a random piece from mthe board%%%%%%%%%%%%%%%
get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2):-
  write('entrou'),
  (
    is_par(J) -> random(1,4,X); random(5,8,X)
  ),
  random(1,4,Y),
  getelem(B, X, Y, Elem),
  (
    Elem \= 's' -> random_play(B, X, Y, Nb, J, S1, Ns1, S2, Ns2); get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2)
  ).



%%%%%%%%%%%%%%%Generates a play in which the PC captures a piece and if it isn't possible, makes a random move%%%%%%%%%%%%%%%
best_play(B, Nb, J, S1, Ns1, S2, Ns2):-
  process_pieces(B, J, Nb, S1, Ns1, S2, Ns2).

process_pieces(B, J, Nb, S1, Ns1, S2, Ns2):-
  (is_par(J) -> process_pieces_top(B, 1, 1, J, Nb, S1, Ns1, S2, Ns2); process_pieces_bot(B, 5, 1, J, Nb, S1, Ns1, S2, Ns2)).

process_pieces_top(B, X, Y, J, Nb, S1, Ns1, S2, Ns2):-
  (X = 5 -> get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2), false;
    getelem(B, X, Y, Elem),
    (Elem \= 's', find_next_board_bot(B, X, Y, 5, 1, J, Nb, S1, Ns1, S2, Ns2);
      (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
      process_pieces_top(B, X1, Y1, J, Nb, S1, Ns1, S2, Ns2))).

process_pieces_bot(B, X, Y, J, Nb, S1, Ns1, S2, Ns2):-
  (X = 9 -> get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2), false;
    getelem(B, X, Y, Elem),
    (Elem \= 's' -> find_next_board_top(B, X, Y, 1, 1, J, Nb, S1, Ns1, S2, Ns2);
      (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
      process_pieces_bot(B, X1, Y1, J, Nb, S1, Ns1, S2, Ns2))).

find_next_board_bot(B, L, C, X, Y, J, Nb, S1, Ns1, S2, Ns2):-
  (X = 9 -> false;
    getelem(B, X, Y, Elem),
    nl,write(L), write(C), write(X), write(Y),nl,
    (Elem \= 's', move_piece(B, L, C, X, Y, Nb, J, S1, Ns1, S2, Ns2) -> true;
    (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
    find_next_board_bot(B, L, C, X1, Y1, J, Nb, S1, Ns1, S2, Ns2))).

find_next_board_top(B, L, C, X, Y, J, Nb, S1, Ns1, S2, Ns2):-
  (X = 5 -> false;
    getelem(B, X, Y, Elem),
    nl,write(L), write(C), write(X), write(Y),nl,
    (Elem \= 's', move_piece(B, L, C, X, Y, Nb, J, S1, Ns1, S2, Ns2) -> true;
    (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
    find_next_board_top(B, L, C, X1, Y1, J, Nb, S1, Ns1, S2, Ns2))).
