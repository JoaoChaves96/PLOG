clue_line1([5,5,-1,4,-1,4,-1]).
clue_column1([-1, 3, -1, -1, -1, 5, -1]).

clue_line2([-1,-1,-1,4,4,3,-1,-1,-1,8]).
clue_column2([7,-1,-1,5,-1,-1,5,6,-1,-1]).

clue_line3([3,3,3,3,3,3,3]).
clue_column3([3,3, 2, 4, 5, 4]).

check_lines_columns([_|Ls], Lines, N):-
  element(N, Lines, Nr),
  Nr = -1,
  N1 is N + 1,
  check_lines_columns(Ls, Lines, N1).

check_lines_columns([L|Ls], Lines, N):-
  element(N, Lines, Nr),
  count(1, L, #=, Nr),
  N1 is N + 1,
  check_lines_columns(Ls, Lines, N1).

check_lines_columns([], _, _).

%%%%%%%%%%%%%%% Solver of puzzle 1 - 7x7 %%%%%%%%%%%%%%%
solve1(L1, L2, L3, L4, L5, L6, L7, Lines, Columns):-
  L1 = [S1 , S2 , S2 , S3 , S3 , S3 , S3],
  L2 = [S1 , S1 , S2 , S4 , S4 , S3 , S5],
  L3 = [S6 , S7 , S2 , S2 , S4 , S5 , S5],
  L4 = [S6 , S7 , S7 , S2 , S8 , S8 , S5],
  L5 = [S6 , S6 , S9 , S2 , S2 , S8 , S5],
  L6 = [S6 , S10, S9 , S9 , S2 , S11, S11],
  L7 = [S10, S10, S10, S10, S2 , S2 , S11],

  C1 = [S1 , S1 , S6 , S6 , S6 , S6 , S10],
  C2 = [S2 , S1 , S7 , S7 , S6 , S10 , S10],
  C3 = [S2 , S2 , S2 , S7 , S9 , S9 , S10],
  C4 = [S3 , S4 , S2 , S2 , S2 , S9 , S10],
  C5 = [S3 , S4 , S5 , S8 , S2 , S2 , S2],
  C6 = [S3 , S3, S5 , S8 , S8 , S11, S2],
  C7 = [S3, S5, S5, S5, S5 , S11 , S11],

  domain(L1, 0, 1),
  domain(L2, 0, 1),
  domain(L3, 0, 1),
  domain(L4, 0, 1),
  domain(L5, 0, 1),
  domain(L6, 0, 1),
  domain(L7, 0, 1),

  %%%%%%%%%%Contagem das linhas%%%%%%%%%%

  check_lines_columns([L1, L2, L3, L4, L5, L6, L7], Lines, 1),

  %%%%%%%%%%Contagem das colunas%%%%%%%%%%

  check_lines_columns([C1, C2, C3, C4, C5, C6, C7], Columns, 1),

  labeling([],L1),
  labeling([],L2),
  labeling([],L3),
  labeling([],L4),
  labeling([],L5),
  labeling([],L6),
  labeling([],L7).


%%%%%%%%%%%%%%% Solver of puzzle 2 - 10x10 %%%%%%%%%%%%%%%
solve2(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, Lines, Columns):-
  L1 = [S1, S1, S1, S1, S2, S2, S2, S3, S3, S4],
  L2 = [S5, S5, S1, S1, S2, S2, S2, S3, S3, S4],
  L3 = [S6, S7, S7, S8, S8, S8, S3, S3, S3, S4],
  L4 = [S6, S7, S9, S9, S9, S8, S8, S10, S11, S4],
  L5 = [S7, S7, S9, S9, S12, S12, S8, S10, S11, S13],
  L6 = [S7, S7, S14, S14, S12, S15, S16, S16, S13, S13],
  L7 = [S17, S17, S14, S14, S14, S15, S18, S18, S18, S18],
  L8 = [S17, S17, S14, S19, S15, S15, S20, S18, S18, S18],
  L9 = [S21, S21, S14, S19, S15, S15, S20, S22, S22, S23],
  L10 = [S21, S21, S21, S19, S24, S24, S24, S24, S24, S23],

  C1 = [S1, S5, S6, S7, S7, S17, S17, S21, S21],
  C2 = [S1 , S5 , S7 , S7 , S7 , S7 , S17, S17, S21, S21],
  C3 = [S1, S1, S7, S9, S9, S14, S14, S14, S14, S21],
  C4 = [S1, S1, S8, S9, S9, S14, S14, S19, S19, S19],
  C5 = [S2, S2, S8, S9, S12, S12, S14, S15, S15, S24],
  C6 = [S2, S2, S8, S8, S12, S15, S15, S15, S15, S24],
  C7 = [S2, S2, S3, S8, S8, S16, S18, S20, S20, S24],
  C8 = [S3, S3, S3, S11, S11, S13, S18, S18, S22, S24],
  C9 = [S3, S3, S3, S11, S11, S13, S18, S18, S22, S24],
  C10 = [S4, S4, S4, S4, S13, S13, S18, S18, S23, S23],

  domain(L1, 0, 1),
  domain(L2, 0, 1),
  domain(L3, 0, 1),
  domain(L4, 0, 1),
  domain(L5, 0, 1),
  domain(L6, 0, 1),
  domain(L7, 0, 1),
  domain(L8, 0, 1),
  domain(L9, 0, 1),
  domain(L10, 0, 1),

  %%%%%%%%%%Contagem das linhas%%%%%%%%%%

  check_lines_columns([L1, L2, L3, L4, L5, L6, L7, L8, L9, L10], Lines, 1),

  %%%%%%%%%%Contagem das colunas%%%%%%%%%%

  check_lines_columns([C1, C2, C3, C4, C5, C6, C7, C8, C9, C10], Columns, 1),

  labeling([],L1),
  labeling([],L2),
  labeling([],L3),
  labeling([],L4),
  labeling([],L5),
  labeling([],L6),
  labeling([],L7),
  labeling([],L8),
  labeling([],L9),
  labeling([],L10).

  %%%%%%%%%%%%%%   puzzle 3 %%%%%%%%%%%%%%%%%%%%%%
  
  
  
  solve3(L1, L2, L3, L4, L5, L6, L7, Lines, Columns):-
  L1 = [S1 , S2 , S2 , S2 , S3 , S3 ],
  L2 = [S1 , S2 , S5 , S6 , S6 , S3 ],
  L3 = [S1 , S4 , S5 , S7 , S6 , S8 ],
  L4 = [S4 , S4 , S12, S7 , S7 , S8 ],
  L5 = [S13, S12, S12, S11, S9 , S8 ],
  L6 = [S13, S11, S11, S11, S9 , S9	],
  L7 = [S14, S14, S14, S10, S10, S10],
  
  C1=[S1 + S1 + S1 + S4 + S13 + S13 + S14],
  C2=[S2 + S2 + S4 + S4 + S12 + S11 + S14 ],
  C3=[S2 + S5 + S5 + S12 + S12 + S11 + S14 ],
  C4=[ S2 + S6 + S7 + S7 + S11 + S11 + S10],
  C5=[ S3 + S6 + S6 + S7 + S9 + S9 + S10 ],
  C6=[S3 + S3+ S8 + S8 + S8 + S9 + S10]  ,
  
  
  domain(L1, 0, 1),
  domain(L2, 0, 1),
  domain(L3, 0, 1),
  domain(L4, 0, 1),
  domain(L5, 0, 1),
  domain(L6, 0, 1),
  domain(L7, 0, 1),
  
  
   %%%%%%%%%%Contagem das linhas%%%%%%%%%%

  check_lines_columns([L1, L2, L3, L4, L5, L6, L7], Lines, 1),

  %%%%%%%%%%Contagem das colunas%%%%%%%%%%

  check_lines_columns([C1, C2, C3, C4, C5, C6], Columns, 1),
  
   labeling([],L1),
  labeling([],L2),
  labeling([],L3),
  labeling([],L4),
  labeling([],L5),
  labeling([],L6),
  labeling([],L7).
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  
  
  
  
  
  
  
  
  
  
  

solve_puzzle1:-
  clue_line1(L),
  clue_column1(C),
  solve1(L1, L2, L3, L4, L5, L6, L7, L, C),
  append([], [L1], Nb),
  append(Nb, [L2], Nb2),
  append(Nb2, [L3], Nb3),
  append(Nb3, [L4], Nb4),
  append(Nb4, [L5], Nb5),
  append(Nb5, [L6], Nb6),
  append(Nb6, [L7], Nb7),
  display_full_board1(Nb7).

solve_puzzle2:-
  clue_line2(L),
  clue_column2(C),
  solve2(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L, C),
  append([], [L1], Nb),
  append(Nb, [L2], Nb2),
  append(Nb2, [L3], Nb3),
  append(Nb3, [L4], Nb4),
  append(Nb4, [L5], Nb5),
  append(Nb5, [L6], Nb6),
  append(Nb6, [L7], Nb7),
  append(Nb7, [L8], Nb8),
  append(Nb8, [L9], Nb9),
  append(Nb9, [L10], Nb10),
  display_full_board2(Nb10).
  
  solve_puzzle3:-
  clue_line3(L),
  clue_column3(C),
  solve1(L1, L2, L3, L4, L5, L6, L7, L, C),
  append([], [L1], Nb),
  append(Nb, [L2], Nb2),
  append(Nb2, [L3], Nb3),
  append(Nb3, [L4], Nb4),
  append(Nb4, [L5], Nb5),
  append(Nb5, [L6], Nb6),
  append(Nb6, [L7], Nb7),
  display_full_board3(Nb7).
