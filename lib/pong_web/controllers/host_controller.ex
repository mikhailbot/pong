defmodule PongWeb.HostController do
  use PongWeb, :controller

  alias Pong.Monitors
  alias Pong.Monitors.Host

  def index(conn, _params) do
    hosts = Monitors.list_hosts()
    render(conn, "index.html", hosts: hosts)
  end

  def new(conn, _params) do
    changeset = Monitors.change_host(%Host{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"host" => host_params}) do
    case Monitors.create_host(host_params) do
      {:ok, host} ->
        conn
        |> put_flash(:info, "Host created successfully.")
        |> redirect(to: host_path(conn, :show, host))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    host = Monitors.get_host!(id)
    render(conn, "show.html", host: host)
  end

  def edit(conn, %{"id" => id}) do
    host = Monitors.get_host!(id)
    changeset = Monitors.change_host(host)
    render(conn, "edit.html", host: host, changeset: changeset)
  end

  def update(conn, %{"id" => id, "host" => host_params}) do
    host = Monitors.get_host!(id)

    case Monitors.update_host(host, host_params) do
      {:ok, host} ->
        conn
        |> put_flash(:info, "Host updated successfully.")
        |> redirect(to: host_path(conn, :show, host))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", host: host, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    host = Monitors.get_host!(id)
    {:ok, _host} = Monitors.delete_host(host)

    conn
    |> put_flash(:info, "Host deleted successfully.")
    |> redirect(to: host_path(conn, :index))
  end
end
