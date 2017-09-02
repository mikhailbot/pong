defmodule Pong.Reports.Status do
  @moduledoc """
  Module to check the status of a host
  """
  alias Pong.{Monitors, Redis}

  def is_up?(host) do
    host.ip_address
    |> Redis.get_latest_checks
    |> Enum.all?(fn(check) -> check != "0" end)
  end

  def is_down?(host) do
    host.ip_address
    |> Redis.get_latest_checks
    |> Enum.all?(fn(check) -> check == "0" end)
  end
end
