defmodule Pong.Reports.ReportScheduler do
  @moduledoc """
  GenServer to schedule checking reports
  """

  use GenServer

  alias Pong.Monitors
  alias Pong.Reports
  alias Pong.Reports.Status

  # Client API

  def start_link(_options \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Server API
  def init(_args) do
    schedule_work()
    {:ok, []}
  end

  def handle_info(:get_status, state) do
    hosts = Monitors.list_hosts

    for host <- hosts do
      Reports.check_status(host)
    end

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :get_status, 10 * 1000) # In 10 seconds
  end
end
