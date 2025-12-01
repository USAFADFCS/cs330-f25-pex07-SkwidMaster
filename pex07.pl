% pex5.pl
% USAFA UFO Sightings 2024
%
% name: C2C Will Kozma
%
% Documentation: No external resources were used on this assignment
%

% The query to get the answer(s) or that there is no answer
% ?- solve.

% The cadets fourth class who saw the phenomena
c4c(chen).
c4c(garcia).
c4c(jones).
c4c(smith).

% The days
day(tuesday).
day(wednesday).
day(thursday).
day(friday).

% The objects
object(balloon).
object(cloud).
object(fighter).
object(kite).

% solve the puzzle
solve :-
	% Permute the days amongst the cadets fourth class
	day(ChenDay), day(GarciaDay), day(JonesDay), day(SmithDay),
	all_different([ChenDay, GarciaDay, JonesDay, SmithDay]),

	% Permute the objects amongst the cadets fourth class
	object(ChenObject), object(GarciaObject),
	object(JonesObject), object(SmithObject),
	all_different([ChenObject, GarciaObject, JonesObject, SmithObject]),

	% Assign the objects and days to their cadets fourth class
	Triples = [ [chen, ChenObject, ChenDay],
	            [garcia, GarciaObject, GarciaDay],
	            [jones, JonesObject, JonesDay],
	            [smith, SmithObject, SmithDay] ],

	% 1. C4C Smith did not see a weather balloon, nor kite.
	\+ member([smith, balloon, _], Triples),
	\+ member([smith, kite, _], Triples),

	% 2. The one who saw the kite isn’t C4C Garcia.
	\+ member([garcia, kite, _], Triples),

	% 3. Friday’s sighting was made by either C4C Chen or the one who saw
	% the fighter aircraft.
	(member([chen, _, friday], Triples);
	member([_, fighter, friday], Triples)),

	% 4. The kite was not sighted on Tuesday.
	\+ member([_, kite, tuesday], Triples),

	% 5. Neither C4C Garcia nor C4C Jones saw the weather balloon.
	\+ member([garcia, balloon, _], Triples),
	\+ member([jones, balloon, _], Triples),

	% 6. C4C Jones did not make their sighting on Tuesday.
	\+ member([jones, _, tuesday], Triples),

	% 7. C4C Smith saw an object that turned out to be a cloud.
	member([smith, cloud, _], Triples),

	% 8. The fighter aircraft was spotted on Friday.
	member([_, fighter, friday], Triples),

	% 9. The weather balloon was not spotted on Wednesday.
	\+ member([_, balloon, wednesday], Triples),

	% Print solutions
	tell(chen, ChenObject, ChenDay),
	tell(garcia, GarciaObject, GarciaDay),
	tell(jones, JonesObject, JonesDay),
	tell(smith, SmithObject, SmithDay).

% determines if all members of the passed list are different
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
	write("C4C "), write(X), write(" saw the "), write(Y), write(" on "),
	write(Z), write("."), nl.
