defmodule Pong.Monitors.Scheduler do
  use GenServer

  # Client API

  def start_link(_options \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def schedule_ping(host) do
    GenServer.cast(__MODULE__, {:schedule, host})
  end

  # Server API
  def init(_args) do
    Pong.Monitors.schedule_all_hosts()
    {:ok, []}
  end

  def handle_cast({:schedule, host}, state) do
    {:noreply, [host | state]}
  end
end
