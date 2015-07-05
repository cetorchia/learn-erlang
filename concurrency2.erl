%% Another module for learning about concurrency in Erlang.
%% Here we experiment with messaging passing between processes.
%% We'll spawn multiple processes for each ping'er, and one process for a pong'er.

-module(concurrency2).
-export([spawn_ping_pong/1,pong/1,ping_single/1]).

%% Spawn a pong'er and spawn the given number of ping'ers

spawn_ping_pong(Number_of_Pings) when Number_of_Pings >= 0 ->
    register(pong, spawn(concurrency2, pong, [Number_of_Pings])),
    ping_multiple(Number_of_Pings).

%% Ping'ers
%% Spawn the given number of pings.

ping_multiple(Number_of_Pings) ->
    Spawn_Ping_Single = fun (Number) -> spawn(concurrency2, ping_single, [Number]) end,
    lists:foreach(Spawn_Ping_Single, lists:seq(1, Number_of_Pings)).

ping_single(Ping_Number) ->
    pong ! {ping, Ping_Number, self()},
    receive
        {pong, Pong_Number} ->
            io:format("Ping ~w: Received pong ~w~n", [Ping_Number, Pong_Number])
    end.

%% Pong'er
%% Expect only the given number of pings

pong(Number_of_Pings) ->
    pong(Number_of_Pings, 1).

pong(Number_of_Pings, Pong_Number) when Number_of_Pings < Pong_Number ->
    ok;

pong(Number_of_Pings, Pong_Number) ->
    receive
        {ping, Ping_Number, Ping_ID} ->
            io:format("Pong ~w: Received ping ~w~n", [Pong_Number, Ping_Number]),
            Ping_ID ! {pong, Pong_Number}
    end,
    pong(Number_of_Pings, Pong_Number + 1).
