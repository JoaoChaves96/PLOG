board_area1([
      [a1, a2, a2, a3, a3, a3, a3],
      [a1, a1, a2, a4, a4, a3, a5],
      [a6, a7, a2, a2, a4, a5, a5],
      [a6, a7, a7, a2, a8, a8, a5],
      [a6, a6, a9, a2, a2, a8, a5],
      [a6, a10, a9, a9, a2, a11, a11],
      [a10, a10, a10, a10, a2, a2, a11]
]).

board_area2([
      [a1, a1, a1, a1, a2, a2, a2, a3, a3, a4],
      [a5, a5, a1, a1, a2, a2, a2, a3, a3, a4],
      [a6, a7, a7, a8, a8, a8, a3, a3, a3, a4],
      [a6, a7, a9, a9, a9, a8, a8, a10, a11, a4],
      [a7, a7, a9, a9, a12, a12, a8, a10, a11, a13],
      [a7, a7, a14, a14, a12, a15, a16, a16, a13, a13],
      [a17, a17, a14, a14, a14, a15, a18, a18, a18, a18],
      [a17, a17, a14, a19, a15, a15, a20, a18, a18, a18],
      [a21, a21, a14, a19, a15, a15, a20, a22, a22, a23],
      [a21, a21, a21, a19, a24, a24, a24, a24, a24, a23]
]).

display_line([E|Es]):-
	translate(E,V),
	write(' '),
	write(V),
	write(' |'),
	display_line(Es).

display_line([]).

translate(a1,'1 ').
translate(a2,'2 ').
translate(a3,'3 ').
translate(a4,'4 ').
translate(a5,'5 ').
translate(a6,'6 ').
translate(a7,'7 ').
translate(a8,'8 ').
translate(a9,'9 ').
translate(a10,'10').
translate(a11,'11').
translate(a12,'12').
translate(a13,'13').
translate(a14,'14').
translate(a15,'15').
translate(a16,'16').
translate(a17,'17').
translate(a18,'18').
translate(a19,'19').
translate(a20,'20').
translate(a21,'21').
translate(a22,'22').
translate(a23,'23').
translate(a24,'24').
translate(1, 'X').
translate(0, ' ').


%%%%%%%%%%%%%%%Puzzle 1 display%%%%%%%%%%%%%%%
display_area_board1(B):-
  nl,
  write(' ---------------------------------- '),nl,
  display_a_board1(B).

display_full_board1(B):-
  nl,
  write(' --------------------------- '),nl,
  display_f_board1(B).

display_a_board1([L1|Ls]):-
	write('|'),
	display_line(L1),
  nl,
  write(' ---------------------------------- '),
  nl,
	display_a_board1(Ls).

display_a_board1([]).

display_f_board1([L1|Ls]):-
	write('|'),
	display_line(L1),
  nl,
  write(' --------------------------- '),
  nl,
	display_f_board1(Ls).

display_f_board1([]).

%%%%%%%%%%%%%%%Puzzle 2 display%%%%%%%%%%%%%%%
display_area_board2(B):-
  nl,
  write(' ------------------------------------------------- '),nl,
  display_a_board2(B).

display_full_board2(B):-
  nl,
  write(' --------------------------------------- '),nl,
  display_f_board2(B).

display_a_board2([L1|Ls]):-
	write('|'),
	display_line(L1),
  nl,
  write(' ------------------------------------------------- '),
  nl,
	display_a_board2(Ls).

display_a_board2([]).

display_f_board2([L1|Ls]):-
	write('|'),
	display_line(L1),
  nl,
  write(' --------------------------------------- '),
  nl,
	display_f_board2(Ls).

display_f_board2([]).
