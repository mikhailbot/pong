defmodule Pong.Reports.Status do
  @moduledoc """
  Module to check the status of a host
  """

  alias Pong.Redis

  def is_up?(host) do
    case get_checks(host) do
      {:ok, checks} -> Enum.all?(checks, fn(check) -> check != "0" end)
      {:error} -> false
    end
  end

  def is_down?(host) do
    case get_checks(host) do
      {:ok, checks} -> Enum.all?(checks, fn(check) -> check == "0" end)
      {:error} -> false
    end
  end

  defp get_checks(host) do
    checks =
      host.ip_address
      |> Redis.get_latest_checks
      |> Enum.map(fn(check) -> String.split(check, ":") end)
      |> Enum.map(fn(check) -> List.last(check) end)

    case Enum.count(checks) do
      3 -> {:ok, checks}
      _ -> {:error}
    end
  end
end
