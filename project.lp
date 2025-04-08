
% Author : Edoardo Diana


% Please note that puzzles are always rectangular, but not necessarily square. 
% Requests : 

%   1) No symbol should appear more than once in a row or a column (crossed-out occurrences do not count) .

%   2) Crossed-out symbols must not occur next to each other horizontally or vertically.

%   3) All symbols that are not crossed out should form a contiguous area (horizontal and vertical connections). 
%   That means that each non-crossed-out symbol must be reached from all other non-crossed-out symbols 
%   by moving only horizontally or vertically over non-crossed-out symbols.

% To run the code use : 

% clingo project.lp input.lp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)

% Choice rule that decides grid cell symbols to keep and ones that needs to be cancelled.
1 { keep(X, Y, S); crossedout(X, Y, S) } 1 :- cell(X, Y, S).

% No duplicate symbol in a row 
:- cell(X, Y, S), cell(X, Z, S), Y != Z, keep(X, Y, S), keep(X, Z, S).

% No duplicate symbol in a column
:- cell(X, Y, S), cell(Z, Y, S), X != Z, keep(X, Y, S), keep(Z, Y, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)

% Definition of the adjacency predicate to identify is two cells of the grid are close to each other.
adjacent(X1, Y1, X2, Y2) :- cell(X1, Y1, _), cell(X2, Y2, _), X1 = X2, Y2 = Y1 + 1.
adjacent(X1, Y1, X2, Y2) :- cell(X1, Y1, _), cell(X2, Y2, _), Y1 = Y2, X2 = X1 + 1.
adjacent(X1, Y1, X2, Y2) :- adjacent(X2, Y2, X1, Y1).

% Forbid crossedout cells to be adjacent
:- crossedout(X1, Y1, _), crossedout(X2, Y2, _), adjacent(X1, Y1, X2, Y2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3)

% This rule verifies whether there is a direct link between two tiles on the grid
reachable(X1, Y1, X2, Y2) :- keep(X1, Y1, _), keep(X2, Y2, _), X1 != X2, 
    adjacent(X1, Y1, X2, Y2).

reachable(X1, Y1, X2, Y2) :- keep(X1, Y1, _), keep(X2, Y2, _), Y1 != Y2, 
    adjacent(X1, Y1, X2, Y2).

% Here I manage the symmetry between the two pair of coordinates
reachable(X2, Y2, X1, Y1) :- reachable(X1, Y1, X2, Y2).

% Something not crossedout must be reachable
:- reachable(X1, Y1, X2, Y2), crossedout(X1, Y1, S), cell(X1, Y1, S).

% I check that each kept cell has at least one other kept cell adjacent to it 
is_valid_keeped_cell(X1, Y1, S) :- keep(X1, Y1, S), keep(X2, Y2, _), adjacent(X1, Y1, X2, Y2).
:- not is_valid_keeped_cell(X, Y, S), keep(X, Y, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#show crossedout/3.
%#show is_valid_keeped_cell/3.



