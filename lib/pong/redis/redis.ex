defmodule Pong.Redis do
  @moduledoc """
  The Redis context
  """

  alias Pong.Monitors
  alias Pong.Monitors.Host

  def create_checks(checks) do
    redis_data =
      checks
      |> Enum.map(fn (check) -> generate_redis_check_input(check) end)

    {:ok, conn} = Redix.start_link()
    Redix.pipeline!(conn, redis_data)
    Redix.stop(conn)
  end

  defp generate_redis_check_input(check) do
    ["ZADD", "checks:#{check.ip_address}", check.time, "#{check.time}:#{check.latency}"]
  end

  def get_latest_checks(host) do
    {:ok, conn} = Redix.start_link()
    results = Redix.command!(conn, ["ZREVRANGE", "checks:#{host}", 0, 2])
    Redix.stop(conn)

    results
  end

  def delete_old_checks do
    redis_data =
      Monitors.list_hosts
      |> Enum.map(fn (host) -> generate_redis_remove_input(host) end)

    {:ok, conn} = Redix.start_link()
    Redix.pipeline!(conn, redis_data)
    Redix.stop(conn)
  end

  defp generate_redis_remove_input(%Host{} = host) do
    fourteen_days_ago = :os.system_time(:seconds) - 1_209_600
    ["ZREMRANGEBYSCORE", "checks:#{host.ip_address}", 0, fourteen_days_ago]
  end

  def get_latest_check(hosts) do
    {:ok, conn} = Redix.start_link()

    updated_hosts =
      hosts
      |> Enum.map(fn(host) ->
        latency =
          Redix.command!(conn, ["ZREVRANGE", "checks:#{host.ip_address}", 0, 0])
          |> Enum.map(fn(check) -> String.split(check, ":") end)
          |> Enum.map(fn(check) -> List.last(check) end)
          |> Enum.at(0)

        Map.put(host, :latency, latency)
      end)

    Redix.stop(conn)

    updated_hosts
  end
end
