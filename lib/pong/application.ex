defmodule Pong.Application do
  @moduledoc """
  Pong Application
  """

  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Pong.Repo, []),
      # Start the endpoint when the application starts
      supervisor(PongWeb.Endpoint, []),
      # Start your own worker by calling: Pong.Worker.start_link(arg1, arg2, arg3)
      # worker(Pong.Worker, [arg1, arg2, arg3]),
      worker(Pong.Monitors.Scheduler, [[name: :scheduler]]),
      worker(Pong.Reports.ReportScheduler, [[name: :report_scheduler]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pong.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PongWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
