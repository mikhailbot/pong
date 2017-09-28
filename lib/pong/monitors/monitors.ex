defmodule Pong.Monitors do
  @moduledoc """
  Monitors Context
  """

  import Ecto.Query, warn: false

  alias Pong.{Repo, Monitors, Reports, Redis}
  alias Pong.Monitors.{Host, Ping}

  @doc """
  Returns the list of hosts.

  ## Examples

      iex> list_hosts()
      [%Host{}, ...]

  """
  def list_hosts do
    Repo.all(Host)
  end

  @doc """
  Returns the list of hosts, with their latest latency
  """

  def list_hosts_with_latency do
    query = from h in Host,
      order_by: [asc: :id],
      select: map(h, [:id, :name, :ip_address, :status])

    Repo.all(query)
    |> Reports.check_latest_status
  end

  @doc """
  Gets a single host.

  Raises `Ecto.NoResultsError` if the Host does not exist.

  ## Examples

      iex> get_host!(123)
      %Host{}

      iex> get_host!(456)
      ** (Ecto.NoResultsError)

  """
  def get_host!(id), do: Repo.get!(Host, id)

  @doc """
  Creates a host.

  ## Examples

      iex> create_host(%{field: value})
      {:ok, %Host{}}

      iex> create_host(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_host(attrs \\ %{}) do
    %Host{}
    |> Host.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a host.

  ## Examples

      iex> update_host(host, %{field: new_value})
      {:ok, %Host{}}

      iex> update_host(host, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_host(%Host{} = host, attrs) do
    host
    |> Host.changeset(attrs)
    |> Repo.update()
  end

  def update_host_status(%Host{} = host, attrs) do
    host
    |> Host.update_status_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Host.

  ## Examples

      iex> delete_host(host)
      {:ok, %Host{}}

      iex> delete_host(host)
      {:error, %Ecto.Changeset{}}

  """
  def delete_host(%Host{} = host) do
    Repo.delete(host)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking host changes.

  ## Examples

      iex> change_host(host)
      %Ecto.Changeset{source: %Host{}}

  """
  def change_host(%Host{} = host) do
    Host.changeset(host, %{})
  end

  def check_hosts do
    Monitors.list_hosts
    |> Enum.map(fn (host) -> Ping.check_host(host.ip_address) end)
    |> Redis.create_checks
  end
end
