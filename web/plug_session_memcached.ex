defmodule Plug.Session.MEMCACHED do
  @moduledoc """
  Stores the session in a memcached table.

  A created ETS table is required for this store to work.

  This store does not create the ETS table, it is expected
  that an existing named table is given as argument with
  public properties.

  ## Options

  * `:table` - ETS table name (required);

  ## Examples

      # Create table during application start
      :ets.new(:session, [:named_table, :public, read_concurrency: true])

      # Use the session plug with the table name
      plug Plug.Session, store: :ets, key: "sid", table: :session

  http://www.erlang.org/doc/man/ets.html
  """

  @behaviour Plug.Session.Store

  @max_tries 100

  def init(opts) do
    Keyword.fetch!(opts, :table)
  end

  def get(sid, table) do
    case :mcd.get( table, sid ) do
      {:error, :noproc}   -> raise "cannot find memcached proc"
      {:error, :notfound} -> {nil, %{}}
      {:ok, data }        -> {sid, data}
    end
  end

  def put(nil, data, table) do
    put_new(data, table)
  end

  def put(sid, data, table) do
    :mcd.set( table, sid, data )
    sid
  end

  def delete(sid, table) do
    :mcd.delete(table, sid)
    :ok
  end

  defp put_new(data, table, counter \\ 0)
      when counter < @max_tries do
    sid = :crypto.strong_rand_bytes(96) |> Base.encode64

    put( sid, data, table )
    
  end
end
