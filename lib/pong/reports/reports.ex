defmodule Pong.Reports do
  @moduledoc """
  Reports Context
  """

  alias Pong.Repo
  alias Pong.{Monitors, Reports, Mailer}
  alias Pong.Reports.{Status, Event}

  def check_status(host) do
    case host.status do
      "up" -> check_still_up(host)
      "down" -> check_still_down(host)
      "unknown" -> check_status_changed(host)
      _ -> IO.puts "ERROR with #{host.name}"
    end
  end

  def get_status do
    hosts = Monitors.list_hosts

    for host <- hosts do
      Reports.check_status(host)
    end
  end

  defp check_still_up(host) do
    case Status.is_up?(host) do
      false -> Monitors.update_host(host, %{status: "unknown"})
      _ -> IO.puts "#{host.name} is still up"
    end
  end

  defp check_still_down(host) do
    case Status.is_down?(host) do
      false -> Monitors.update_host(host, %{status: "unknown"})
      _ -> IO.puts "#{host.name} is still down"
    end
  end

  defp check_status_changed(host) do
    with true <- Status.is_up?(host) do
      Monitors.update_host(host, %{status: "up"})
      IO.puts "#{host.name} IS NOW UP!"
      Reports.create_event(%{host_id: host.id, status: "up"})
      Mailer.send_up_notice(host)
    else
      false ->
        with true <- Status.is_down?(host) do
          Monitors.update_host(host, %{status: "down"})
          IO.puts "#{host.name} IS NOW DOWN!"
          Reports.create_event(%{host_id: host.id, status: "down"})
          Mailer.send_down_notice(host)
        end
    end
  end

  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end
end
