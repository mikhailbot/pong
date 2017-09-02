defmodule Pong.Reports.Status do
  @moduledoc """
  Module to check the status of a host
  """
  alias Pong.{Monitors, Redis}

  def is_up?(host) do
    checks =
      host.ip_address
      |> Redis.get_latest_checks

    case Enum.count(checks) do
      3 -> Enum.all?(checks, fn (check) -> check != "0" end)
      _ -> false
    end
  end

  def is_down?(host) do
    checks =
      host.ip_address
      |> Redis.get_latest_checks

    case Enum.count(checks) do
      3 -> Enum.all?(checks, fn(check) -> check == "0" end)
      _ -> false
    end
  end
end
