somaDigitos(0, 0).
somaDigitos(N, S) :-
    N > 0,
    D is N mod 10,
    N1 is N // 10,
    somaDigitos(N1, S1),
    S is S1 + D.

candidato(S, P, N) :-
    N is S ** P,
    N >= 10,
    somaDigitos(N, S).

geraCandidatos(S, Pmax, L) :-
    findall(N, (between(1, Pmax, P), catch(candidato(S, P, N), _, fail)), L).

todosCandidatos(S, Max, Acc, R) :-
    S > Max, !,
    R = Acc.
todosCandidatos(S, Max, Acc, R) :-
    S =< Max,
    geraCandidatos(S, 50, L),
    append(L, Acc, NewAcc),
    S1 is S + 1,
    todosCandidatos(S1, Max, NewAcc, R).

main :-
    todosCandidatos(1, 300, [], Lista),
    sort(Lista, Ordenada),
    length(Ordenada, Len),
    (Len >= 30 ->
        nth1(30, Ordenada, Num),
        write('a_30 = '), write(Num)
    ;
        true
    ).

:- main.