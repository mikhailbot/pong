defmodule Pong.Redis do
  @moduledoc """
  The Redis context
  """

  def create_checks(checks) do
    redis_data =
      checks
      |> Enum.filter(fn {k, _} -> :ok == k end)
      |> Enum.map(fn {_, v} -> v end)
      |> Enum.map(fn (check) -> generate_redis_check_input(check) end)

    {:ok, conn} = Redix.start_link()
    Redix.pipeline!(conn, redis_data)
    Redix.stop(conn)
  end

  defp generate_redis_check_input(check) do
    { ip, time, latency } = check
    ["ZADD", "checks:#{ip}", time, latency]
  end

  def get_latest_checks(host) do
    {:ok, conn} = Redix.start_link()
    results = Redix.command!(conn, ["ZREVRANGE", "checks:#{host}", 0, 2])
    Redix.stop(conn)

    results
  end
end
