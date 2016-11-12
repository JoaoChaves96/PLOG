:- use_module(library(lists)).
:- use_module(library(random)).

% Return element by index (Row,col)

  getelem(B,L,C,Elem):-
  nth1(L,B,MatrixRow),
  nth1(C, MatrixRow, Elem).
  %write(Elem).

% Checks the path of the movement

	check_path_col(B, Nl, C, Nc, Inc):-
    Fc is Nc - Inc,
		(C = Fc -> write('path_col valido\n'), true;
		Next is C + Inc,
		getelem(B, Nl, Next, Elem),
		(Elem \= 's' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

	check_path_line(B, L, Nl, Nc, Inc):-
    Fl is Nl - Inc,
		(L = Fl -> write('path_line valido\n'), true;
		Next is L + Inc,
		getelem(B, Next, Nc, Elem),
		(Elem \= 's' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).

	check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
    Fl is Nl - IncL,
    Fc is Nc - IncC,
		(L = Fl, C = Fc -> write('path_line_col valido\n'), true;
		NextL is L + IncL,
		NextC is C + IncC,
		getelem(B, NextL, NextC, Elem),
		(Elem \= 's' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).

% Convert letter to an index

letterToNumber(Letra,Numero):-
  (Letra == 'a' -> Numero is 1;
  Letra == 'b' -> Numero is 2;
  Letra == 'c' -> Numero is 3;
  Letra == 'd' -> Numero is 4).
%_______________________________________________________________

% Verifica se Input esta entre A-D
letra(X,_,_) :- X = 'a'; X = 'b'; X = 'c'; X = 'd'.
letra(_,X,L1) :- write('Letra invalida! Try Again\n'), nl.

% Verifica se Input esta entre 1-8
numero(X,_,_) :- integer(X), X >= 1,  X =< 8.
numero(_,X,L1) :- write('Valor invalido! Try Again\n'), nl.

%____________________________________________________________________
getNewLine :-
        get_code(T) , (T == 10 -> ! ; getNewLine).

getDigit(D) :-
        get_code(Dt) , D is Dt - 48 , (Dt == 10 -> ! ; getNewLine).

getChar(C) :-
        get_char(C) , char_code(C, Co) , (Co == 10 -> ! ; getNewLine).

%____________________________________________________________________


%
% replace a single cell in a list-of-lists
% - the source list-of-lists is L
% - The cell to be replaced is indicated with a row offset (X)
%   and a column offset within the row (Y)
% - The replacement value is Z
% - the transformed list-of-lists (result) is R
%
replace( L , X , Y , Z , R ) :-
  append(RowPfx,[Row|RowSfx],L),     % decompose the list-of-lists into a prefix, a list and a suffix
  length(RowPfx,X) ,                 % check the prefix length: do we have the desired list?
  append(ColPfx,[_|ColSfx],Row) ,    % decompose that row into a prefix, a column and a suffix
  length(ColPfx,Y) ,                 % check the prefix length: do we have the desired column?
  append(ColPfx,[Z|ColSfx],RowNew) , % if so, replace the column with its new value
  append(RowPfx,[RowNew|RowSfx],R) .  % and assemble the transformed list-of-lists
  					%


check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem):-
  getelem(B, Nl, Nc, Elem2),
  (
    is_par(J) -> check_jogada2(B, J, L, C, Nl, Nc, Elem2, NewElem); check_jogada1(B, J, L, C, Nl, Nc, Elem2, NewElem)
  ).


check_jogada1(B, J, L, C, Nl, Nc, Elem, NewElem):-
  getelem(B, L, C, E),
  (Elem = E, E = 'p', board_has_drones(B, J) -> NewElem = 'd', true;
  Elem = E, E = 'd', board_has_queens(B, J) -> NewElem = 'q', true;
  Elem = 's' -> NewElem = Elem, true;
  Elem \= 's', Nl < 5 -> NewElem = Elem, true;
  write('erro'), false).

check_jogada2(B, J, L, C, Nl, Nc, Elem, NewElem):-
  getelem(B, L, C, E),
  (Elem = E, E = 'p', board_has_drones(B, J) -> NewElem = 'd', true;
  Elem = E, E = 'd', board_has_queens(B, J) -> NewElem = 'q', true;
  Elem = 's' -> NewElem = Elem, true;
  Elem \= 's', Nl > 4 -> NewElem = Elem, true;
  write('erro'),false).

board_has_queens(B, J):-
  (is_par(J) -> check_queens_top(B,1,1); check_queens_bot(B,5,1)).

check_queens_top(B,X,Y):-
(X = 5 -> true;
  getelem(B, X, Y, Elem),
  (Elem = 'd' -> false;
    (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
    check_queens_top(B, X1, Y1))).

check_queens_bot(B,X,Y):-
(X = 9 -> true;
  getelem(B, X, Y, Elem),
  (Elem = 'd' -> false;
    (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
    check_queens_bot(B, X1, Y1))).

board_has_drones(B, J):-
  (is_par(J) -> (check_drones_top(B,1,1) -> true; false); (check_drones_bot(B,5,1) -> true;write('false'),false)).

check_drones_top(B,X,Y):-
(X = 5 -> true;
  getelem(B, X, Y, Elem),
  (Elem = 'd' -> false;
    (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
    check_drones_top(B, X1, Y1))).

check_drones_bot(B,X,Y):-
  (X = 9 -> true;
    getelem(B, X, Y, Elem),
    (Elem = 'd' -> false;
      (Y = 4 -> Y1 is 1, X1 is X + 1; Y1 is Y + 1, X1 is X),
      check_drones_bot(B, X1, Y1))).

pawn_can_move(B,L,C,Nl,Nc, J, Elem2, NewElem):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
  NewElem = 'd',
	DL is abs(Nl-L),
	DC is abs(Nc-C),
	(DC=1,DL=1 -> nl ; (write('Jogada invalida_pawn\n') ,false)); write('fail check jogada'), false).

drone_can_move(B,L,C,Nl,Nc, J):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
	AbsDL is abs(Nl-L),
	AbsDC is abs(Nc-C),
	DL is Nl-L,
	DC is Nc-C,
	(AbsDC=0,AbsDL=0 ->  (write('Jogada invalida_drone\n') ,false );
	((AbsDL=1 ;AbsDL=2),AbsDC=0 );((AbsDC=1;AbsDC=2),AbsDL=0) -> nl;  write('Jogada invalida_drone\n'),false),

	(
		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);
		nl
	); false).

queen_can_move(B, L, C, Nl, Nc, J):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
	DL is Nl-L,
	DC is Nc-C,
	(
		DC=0,DL=0 -> write('Jogada invalida_queen\n') , false;

		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);

	AbsL is abs(DL),
	AbsC is abs(DC),

	(AbsL \= AbsC -> write('Jogada invalida abs_queen\n'), false; nl),

	(
		DL < 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, -1);
		DL < 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, 1);
		DL > 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, -1);
		DL > 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, 1);
		nl
		)
  );false).


end_game_p1(B, C):-
		C = 5 -> true;
		nth1(C, B, Elem),
		(
			Elem \= ['s', 's', 's', 's'] -> false;

    	C1 is C + 1,
    	end_game_p1(B, C1)).

end_game_p2(B, C):-
		C = 9 -> true;
		nth1(C, B, Elem),
		(
			Elem \= ['s', 's', 's', 's'] -> false;

    	C1 is C + 1,
    	end_game_p2(B, C1)).


update_score(Elem2, Os1, Ns1, Os2, Ns2, J):-
  (
    Elem2 = 'p' -> P is 1;
    Elem2 = 'd' -> P is 2;
    Elem2 = 'q' -> P is 3;
    P is 0
  ),
  (is_par(J) -> Ns2 is (Os2 + P); Ns1 is (Os1 + P)).

move_piece(B,L,C,Nl,Nc,Nr, J, Os1, Ns1, Os2, Ns2):-
	getelem(B,L,C,Elem),
  write('prev: '), write(Elem),
  nl,
  getelem(B, Nl, Nc, Elem21),
  write('next: '), write(Elem21),
  nl,
	(
		Elem = 's' -> write('peca invalida\n'), false;
		Elem = 'p' -> F is 0;
		Elem = 'd' -> F is 1;
		Elem = 'q' -> F is 2
	),

		Li is L - 1,
		Ci is C - 1,

		NLi is Nl - 1,
		NCi is Nc - 1,

	(
		F = 0 -> (pawn_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false);
		F = 1 -> (drone_can_move(B, L, C, Nl, Nc, J) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,Elem, Nr); false);
		F = 2 -> (queen_can_move(B, L, C, Nl, Nc, J) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,Elem, Nr); false)
	).

move_piece_PC(B,L,C,Nl,Nc,Nr, J, Os1, Ns1, Os2, Ns2):-
	getelem(B,L,C,Elem),
	(
		Elem = 's' -> write('peça invalida\n');
		Elem = 'p' -> F is 0;
		Elem = 'd' -> F is 1;
		Elem = 'q' -> F is 2
	),

		Li is L - 1,
		Ci is C - 1,

		NLi is Nl - 1,
		NCi is Nc - 1,

	(
		F = 0 -> (pawn_can_move(B, L, C, Nl, Nc, J) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,Elem, Nr); false);
		F = 1 -> (drone_can_move(B, L, C, Nl, Nc, J) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,Elem, Nr); false);
		F = 2 -> (queen_can_move(B, L, C, Nl, Nc, J) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,Elem, Nr); false)
	).
