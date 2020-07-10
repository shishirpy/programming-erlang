-module(kvs).
-export([start/0, store/2, lookup/1]).

% -spec kvs:start() -> true
% -spec kvs:store(Key, Value) -> true
% -spec kvs:lookup(Key) -> {ok, Value} | undefined

start () -> 
    register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) ->
    io:format("Store PID ~p~n", [self()]),
    rpc({store, Key, Value}).

lookup(Key) ->
    io:format("Lookup PID ~p~n", [self()]),
    rpc({lookup, Key}).

rpc(Q) ->
    io:format("rpc PID ~p~n", [self()]),
    kvs ! {self(), Q},
    receive
        {kvs, Reply} ->
            Reply
    end.


loop() ->
    io:format("loop PID ~p~n", [self()]),
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, true},
            loop();
        {From, {lookup, Key}} ->
            From ! {kvs, get(Key)},
            loop()
    end.