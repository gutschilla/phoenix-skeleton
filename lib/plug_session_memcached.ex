defmodule Plug.Session.MEMCACHED do
    @moduledoc """
    Stores the session in a memcached table.

    ## Vserion 0.2

    * 0.2 - change arities of delete, get, put to match phoenix 0.5.0

    An established MEMCACHED connection instance via mcd is required for this
    store to work.

    This store does not create the MEMCACHED connection, it is expected that an
    existing named connection is given as argument with  public properties.

    ## Options

    * `:table` - memcached connection process name (required);

    ## Examples

    # Creatememcached connection on application start, we'll call this process
    # memcached_sessions (use what you like)
    :mcd.start_link(:memcached_sessions, [] )

    # Use the session plug with the connection process name
    key = "myapp_session_id"
    plug Plug.Session,  store: :memcached, key: key, table: :memcached_sessions


    See:
    https://github.com/EchoTeam/mcd

    ## Acknowledgements
    This module is based on Plug.Session.Store.ETS
    Most parts are just copied from there and adapted to :mcd instead of :ets.
    """

    @behaviour Plug.Session.Store

    @max_tries 100

    def init(opts) do
        Keyword.fetch!(opts, :table)
    end

    def get( _conn, sid, table) do
        case :mcd.get( table, sid ) do
          {:error, :noproc}   -> raise "cannot find memcached proc"
          {:error, :notfound} -> {nil, %{}}
          {:ok, data }        -> {sid, data}
        end
    end

    def put( _conn, nil, data, table) do
        put_new(data, table)
    end

    def put( _conn, sid, data, table) do
        :mcd.set( table, sid, data )
    sid
    end

    def delete( _conn, sid, table) do
        :mcd.delete(table, sid)
        :ok
    end

    defp put_new(data, table, counter \\ 0)
        when counter < @max_tries do
            sid = :crypto.strong_rand_bytes(96) |> Base.encode64
        put( nil, sid, data, table )
    end
end
