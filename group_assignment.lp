% People
person(X) :- pref(X,Y,Z).
person(Y) :- pref(X,Y,Z).

#const group_size=3.
group(1..N/group_size) :- N = #count{P:person(P)}.

% Each person is in exactly 1 group.
1 {in(P,G) : group(G)} 1 :- person(P).

% Each group has exactly three people in it.
3 {in(P,G) : person(P)} 3 :- group(G).

% Person A can't be paired with person B if they veto them.
:- peer(A,B), vetos(A,B).

% Two people are peers if they are in the same group.
% Read A is a peer of B.
peer(A,B) :- in(A,G), in(B,G).

% A person's least preference score is the smallest preference score
% they give their peers.
least_pref(A, S) :-
	person(A),
	S != #sup,
	S = #min{SAB:peer(A,B),pref(A,B,SAB)}.

score_sum(A, S) :-
	person(A),
	S = #sum{SAB:peer(A,B),pref(A,B,SAB)}.

% % Minimize the number of people who have to put up with people they don't like.
#minimize { 1@-S,P : least_pref(P,S) }.

% Maximize the total preference of everyone for their peers.
% #maximize { S,A,B : peer(A,B),pref(A,B,S) }.

#show in/2.
#show least_pref/2.
