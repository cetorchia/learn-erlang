%% Sandbox for learning Erlang.
-module(sandbox).
-export([myfun/2]).

-define(mydef(X), (X /= 1)).

%% Function written to convince myself that I actually need
%% to put a ? before a macro.
myfun(X,Y) when ?mydef(X), ?mydef(Y) ->
    1;
myfun(X,Y) when not ?mydef(X) or not ?mydef(Y) ->
    0.
