%% Learn about higher order functions.
-module(temp).
-export([print_temps/1, convert_temps_to_c/1, convert_temp_to_c/1]).

%% Print temperatures of cities
print_temps(Cities) ->
    Print_Temp = fun (#{name := Name, temp := {Unit, Value}}) ->
                         io:format("~-15w ~-3w ~w~n", [Name, Unit, Value])
                 end,
    Temp_Is_Less = fun (#{temp := {Unit, Value1}}, #{temp := {Unit, Value2}}) ->
                           Value1 < Value2
                   end,
    lists:foreach(Print_Temp, lists:sort(Temp_Is_Less, Cities)).

%% Convert cities temperatures to Celsius
convert_temps_to_c(Cities) ->
    lists:map(fun convert_temp_to_c/1, Cities).

convert_temp_to_c(City) ->
    #{temp := {Unit, Value}} = City,
    case Unit of
        c -> City;
        f -> City#{temp := {c, (Value - 32) * 5 / 9}}
    end.
