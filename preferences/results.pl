% pref(Student1, Student2, Preference) - High preference is better.
% Read "Student1 ranks Student2 with preference Preference,
%       where higher Preference is better."

pref("Tim", "Tim", X).
pref("Tim", "Paul", 4).
pref("Tim", "Bill", 5).
pref("Tim", "Mary", 3).
pref("Tim", "Julia", 2).
pref("Paul", "Tim", 5).
pref("Paul", "Paul", X).
pref("Paul", "Bill", 2).
pref("Paul", "Mary", 3).
pref("Paul", "Julia", 1).
pref("Bill", "Tim", 4).
pref("Bill", "Paul", 2).
pref("Bill", "Bill", X).
pref("Bill", "Mary", 5).
pref("Bill", "Julia", 1).
pref("Mary", "Tim", 1).
pref("Mary", "Paul", 4).
pref("Mary", "Bill", 2).
pref("Mary", "Mary", X).
pref("Mary", "Julia", 3).
pref("Julia", "Tim", 4).
pref("Julia", "Paul", 5).
pref("Julia", "Bill", 3).
pref("Julia", "Mary", 2).
pref("Julia", "Julia", X).
