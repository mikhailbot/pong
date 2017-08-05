defmodule Pong.Monitors.Scheduler do
  @moduledoc """
  GenServer to schedule checking hosts
  """

  use GenServer

  alias Pong.Monitors
  alias Pong.Monitors.Ping

  # Client API

  def start_link(_options \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def schedule_ping(host) do
    GenServer.cast(__MODULE__, {:schedule, host})
  end

  # Server API
  def init(_args) do
    schedule_work()
    {:ok, []}
  end

  def handle_info(:ping, state) do
    hosts = Monitors.list_hosts

    for host <- hosts do
      case Ping.check_host(host.ip_address) do
        {:ok, {true, latency}} -> Monitors.update_status(host, %{latency: latency, status: "up"})
        {:ok, {false, latency}} -> Monitors.update_status(host, %{latency: latency, status: "down"})
        {:error, e} -> IO.puts "ERROR #{e.message}"
      end
    end

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :ping, 10 * 1000) # In 10 seconds
  end
end
