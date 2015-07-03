%% Module for learning about concurrency.
-module(concurrency).
-export([echo/2,spawn_echos/2]).

%% Example about spawning processes
%% Spawn multiple processes that output information a number of times.
spawn_echos(Things, Times) ->
    lists:foreach(fun (Thing) -> spawn(concurrency, echo, [Thing, Times]) end, Things).

echo(Thing, Times) ->
    lists:foreach(fun (_) -> io:format("~w~n", [Thing]) end, lists:seq(1, Times)).
