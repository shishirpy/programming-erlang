-module(motor_controller).
-export([add_event_handler/0]).

add_event_handler()->
    event_handler:add_handler(errors, fun controller/1).

controller(too_hot) ->
    io:format("Turn off the motor~n");
controller(X) ->
    io:fomrat("~w ignored even: ~p~n", [?MODULE, X]).