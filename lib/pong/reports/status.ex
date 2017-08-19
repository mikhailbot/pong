defmodule Pong.Reports.Status do
  @moduledoc """
  Module to check the status of a host
  """
  alias Pong.Monitors

  def is_up?(host) do
    host
    |> Monitors.get_latest_checks(3)
    |> get_checks
    |> Enum.all?(fn(check) -> check.latency > 0 end)
  end

  def is_down?(host) do
    host
    |> Monitors.get_latest_checks(3)
    |> get_checks
    |> Enum.all?(fn(check) -> check.latency == 0 end)
  end

  defp get_checks (host_with_checks) do
    host_with_checks.checks
  end
end