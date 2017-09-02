defmodule Pong.Monitors do
  @moduledoc """
  Monitors Context
  """

  import Ecto.Query, warn: false

  alias Pong.{Repo, Monitors, Redis}
  alias Pong.Monitors.{Host, Check, Ping}

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
    |> Host.update_changeset(attrs)
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

  @doc """
  Creates a Check.

  ## Examples

      iex> create_check(%{field: value})
      {:ok, %Check{}}

      iex> create_host(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_check(%Host{} = host, attrs \\ %{}) do
    attrs =
      attrs
      |> Map.put(:host_id, host.id)

    with changeset <- Check.changeset(%Check{}, attrs),
        {:ok, check} <- Repo.insert(changeset) do
        {:ok, check}
    end
  end

  def get_latest_checks(%Host{} = host, count) do
    checks_query = from c in Check, order_by: [desc: c.id], limit: ^count

    Repo.one from h in Host,
      where: h.id == ^host.id,
      preload: [checks: ^checks_query]
  end

  def check_hosts do
    Monitors.list_hosts
    |> Enum.map(fn (host) -> Ping.check_host(host.ip_address) end)
    |> Redis.create_checks
  end
end
