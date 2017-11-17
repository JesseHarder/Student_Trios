% People are anyone who prefers or has been prefered by someone.
person(FirestPerson) :- pref(FirestPerson,FirestPerson,Score).
person(SecondPerson) :- pref(FirestPerson,SecondPerson,Score).

% There is one group for every three people.
#const group_size=3.
group(1..N/group_size) :- N = #count{P:person(P)}.

% Each person is in exactly 1 group.
1 {in(Person,Group) : group(Group)} 1 :- person(Person).

% Each group has exactly three people in it.
3 {in(Person,Group) : person(Person)} 3 :- group(Group).

% Person A can't be paired with person B if they veto them.
:- peer(PersonA,PersonB), vetos(PersonA,PersonB).

% Two people are peers if they are in the same group.
% Read A is a peer of B.
peer(PersonA,PersonB) :- in(PersonA,Group), in(PersonB,Group).

% A person's least preference score is the smallest preference score
% they give their peers.
least_pref(PersonA, Score) :-
	person(PersonA),
	Score != #sup,
	Score = #min{SAB:peer(PersonA,PersonB),pref(PersonA,PersonB,SAB)}.

score_sum(PersonA, Score) :-
	person(PersonA),
	Score = #sum{SAB:peer(PersonA,B),pref(PersonA,B,SAB)}.

% Minimize the number of people who have to put up with people they don't
% like the most.
#minimize { 1@-LeastScore,Person : least_pref(Person,LeastScore) }.

% Maximize the total preference of everyone for their peers.
% #maximize { Score,A,B : peer(A,B),pref(A,B,Score) }.

#show in/2.
% #show least_pref/2.
