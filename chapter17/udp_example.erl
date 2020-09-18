-module(udp_example).

-export([server/1, loop/1, client/1]).

server(Port) ->
    {ok, Socket} = gen_udp:open(Port, [binary]),
    loop(Socket).

loop(Socket) ->
    receive
        {udp, Socket, Host, Port, Bin} -> 
            BinReply = <<hello>>,
            gen_udp:send(Socket, Host, Port, BinReply),
            loop(Socket)
    end.



client(Request) ->
    {ok, Socket} = gen_upd:open(0, [binary]),
    ok = gen_udp:send(Socket, "localhost", 4000, Request),
    Value = receive
            {udp, Socket, _, _, Bin} ->
                {ok, Bin}
            after 2000 ->
                error
            end,
    gen_udp:close(Socket),
    Value.