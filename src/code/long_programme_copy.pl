% Source path: src/code/long_programme.pl
% Simply Logical, Chapter 1

connected(bond_street, oxford_circus, central).
connected(oxford_circus, tottenham_court_road, central).
connected(bond_street, green_park, jubilee).
connected(green_park, charing_cross, jubilee).
connected(green_park, piccadilly_circus, piccadilly).
connected(piccadilly_circus, leicester_square, piccadilly).
connected(green_park, oxford_circus, victoria).
connected(oxford_circus, piccadilly_circus, bakerloo).
connected(piccadilly_circus, charing_cross, bakerloo).
connected(tottenham_court_road, leicester_square, northern).
connected(leicester_square, charing_cross, northern).

% copy
connected(bond_street, oxford_circus, central).
connected(oxford_circus, tottenham_court_road, central).
connected(bond_street, green_park, jubilee).
connected(green_park, charing_cross, jubilee).
connected(green_park, piccadilly_circus, piccadilly).
connected(piccadilly_circus, leicester_square, piccadilly).
connected(green_park, oxford_circus, victoria).
connected(oxford_circus, piccadilly_circus, bakerloo).
connected(piccadilly_circus, charing_cross, bakerloo).
connected(tottenham_court_road, leicester_square, northern).
connected(leicester_square, charing_cross, northern).

/*
nearby(bond_street, oxford_circus).
nearby(oxford_circus, tottenham_court_road).
nearby(bond_street, tottenham_court_road).
nearby(bond_street, green_park).
nearby(green_park, charing_cross).
nearby(bond_street, charing_cross).
nearby(green_park, piccadilly_circus).
nearby(piccadilly_circus, leicester_square).
nearby(green_park, leicester_square).
nearby(green_park, oxford_circus).
nearby(oxford_circus, piccadilly_circus).
nearby(piccadilly_circus, charing_cross).
nearby(oxford_circus, charing_cross).
nearby(tottenham_court_road, leicester_square).
nearby(leicester_square, charing_cross).
nearby(tottenham_court_road, charing_cross).
*/

/*
% copy
nearby(bond_street, oxford_circus).
nearby(oxford_circus, tottenham_court_road).
nearby(bond_street, tottenham_court_road).
nearby(bond_street, green_park).
nearby(green_park, charing_cross).
nearby(bond_street, charing_cross).
nearby(green_park, piccadilly_circus).
nearby(piccadilly_circus, leicester_square).
nearby(green_park, leicester_square).
nearby(green_park, oxford_circus).
nearby(oxford_circus, piccadilly_circus).
nearby(piccadilly_circus, charing_cross).
nearby(oxford_circus, charing_cross).
nearby(tottenham_court_road, leicester_square).
nearby(leicester_square, charing_cross).
nearby(tottenham_court_road, charing_cross).
*/

/*
reachable(bond_street, charing_cross).
reachable(bond_street, green_park).
reachable(bond_street, leicester_square).
reachable(bond_street, oxford_circus).
reachable(bond_street, piccadilly_circus).
reachable(bond_street, tottenham_court_road).
reachable(green_park, charing_cross).
reachable(green_park, leicester_square).
reachable(green_park, oxford_circus).
reachable(green_park, piccadilly_circus).
reachable(green_park, tottenham_court_road).
reachable(leicester_square, charing_cross).
reachable(oxford_circus, charing_cross).
reachable(oxford_circus, leicester_square).
reachable(oxford_circus, piccadilly_circus).
reachable(oxford_circus, tottenham_court_road).
reachable(piccadilly_circus, charing_cross).
reachable(piccadilly_circus, leicester_square).
reachable(tottenham_court_road, charing_cross).
reachable(tottenham_court_road, leicester_square).
*/

/*
% copy
reachable(bond_street, charing_cross).
reachable(bond_street, green_park).
reachable(bond_street, leicester_square).
reachable(bond_street, oxford_circus).
reachable(bond_street, piccadilly_circus).
reachable(bond_street, tottenham_court_road).
reachable(green_park, charing_cross).
reachable(green_park, leicester_square).
reachable(green_park, oxford_circus).
reachable(green_park, piccadilly_circus).
reachable(green_park, tottenham_court_road).
reachable(leicester_square, charing_cross).
reachable(oxford_circus, charing_cross).
reachable(oxford_circus, leicester_square).
reachable(oxford_circus, piccadilly_circus).
reachable(oxford_circus, tottenham_court_road).
reachable(piccadilly_circus, charing_cross).
reachable(piccadilly_circus, leicester_square).
reachable(tottenham_court_road, charing_cross).
reachable(tottenham_court_road, leicester_square).
*/

nearby(X, Y) :-
  connected(X, Y, L).
nearby(X, Y) :-
  connected(X, Z, L),
  connected(Z, Y, L).

% non-recursive version
reachable(X, Y) :-
  connected(X, Y, L).
reachable(X, Y) :-
  connected(X, Z, L1),
  connected(Z, Y, L2).
reachable(X, Y) :-
  connected(X, Z1, L1),
  connected(Z1, Z2, L2),
  connected(Z2, Y, L3).

% recursive version
reachable_r(X, Y) :-
  connected(X, Y, L).
reachable_r(X, Y) :-
  connected(X, Z, L),
  reachable_r(Z, Y).

/** <examples>
?- nearby(oxford_circus, Nearby).
?- nearby(bond_street, Nearby).
?- nearby(oxford_circus, Nearby).

?- reachable(oxford_circus, Reachable).
?- reachable(bond_street, Reachable).
?- reachable(oxford_circus, Reachable).
*/