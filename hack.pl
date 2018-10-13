% Hackathon Project for Hack UMass 2018

% this creates a new => operator to have the same priority as +
% seems to make it behave as you would expect.
:- op(200, xfx, =>).
=>(_,_).

getOp(less, <).
getOp(greater,>).
getOp(equal,==).

eOT(else).
eOT(than).

splittingOp(then).

definition([defines,X,as,Y], X, Y).
definition([sets,X,to,Y],X,Y).
definition([define,X,as,Y], X, Y).
definition([set,X,to,Y],X,Y).

conditional([if,X,is,Operator, than, Z,SO], Return) :- 
	splittingOp(SO),Operator\=equal,getOp(Operator,Symbol),Return = [if,X,Symbol,Z,\n],!.
conditional([if,X,is,equal,to,Z,then],Return) :- Return = [if,X,==,Z,\n],!.


cond_statement(A,Return) :- append(X,Y,A), conditional(X,Ret1),!, append(I,J,Y), parse(I,Ret2), cond_ending(J,Ret3), append(Ret1,Ret2,RR), append(RR, Ret3, Return),!.

cond_ending([and|A], Return) :- parse(A,Return),!.

% "that takes in" to add vars
function(A,Z) :- X = [define,a,function,FuncName], append(X,RestofStart,A), append(X2,End,RestofStart), functionVars(X2, Ret1), parse(End,Ret2), append([def,FuncName], Ret1, Almost), append(Almost, [\n], Almost1), append(Ret2, [end,\n],Almost2), append(Almost1, Almost2, Z).

functionVars([that,takes,in|X], Z) :- get_variables(X,Vars), B = ['(',Vars,')'], flatten(B,Z).
functionVars([], []).


get_variables([X,and|Y], Z) :- get_variables(Y, Rest), append([X], Rest, Z).
get_variables([X],Y) :- Y = [X].
get_variables([], []).



parse(A,Z) :- splittingOp(H), append(X, [H|Y], A), parse(X,Ret1), parse(Y,Ret2), append(Ret1,Ret2,Z),!.

% parse(A,Z) :- cond_statement(A,Z),!.

parse(A,Z) :- conditional(A,Z),!.

parse(A,Z) :- function(A,Z),!.

parse(X,Z) :- definition(X,A,B), Z = [A,=,B,\n], !.

parse(A,Z) :- append(X,Y,A), X \= [], Y \= [], parse(X,NewX), parse(Y, NewY), append(NewX,NewY,Z),!.

printParse(A) :- parse(A,Z), print(Z).
