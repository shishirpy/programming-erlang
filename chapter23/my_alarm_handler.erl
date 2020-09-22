-module(my_alarm_handler).
-behavior(gen_event).

%% gen event callbacks
-export([init/1, code_change/3, handle_event/2, handle_call/2,
         handle_inf/2, terminate/2]).


%% init(Args) must return {ok State}
init(Args) ->
    io:format("** my_alarm_handler init: ~p~n", [Args]),
    {ok, 0}.


handle_event({set_alarm, tooHot}, N) ->
    error_logger:error_msg(" *** Tell the engineer to turn on the fan ~n"),
    {ok, N};
handle_event({clear_alarm, tooHot}, N) ->
    error_logger:error_msg("*** Danger over. Turn off the fan ~n"),
    {ok, N};
handle_event(Event, N) ->
    io:format("*** unmatched event: ~p~n", [Event]),
    {ok, N}.