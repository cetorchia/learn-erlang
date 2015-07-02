% Simple function for computing factorial of integer.
-module(fac).
-export([factorial/1]).

% Computes factorial
factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).
