defmodule Pong.Monitors.Host do
  @moduledoc """
  Schema and changesets for Hosts
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Pong.Monitors.Host
  alias Pong.Monitors.IPv4

  schema "hosts" do
    field :check_frequency, :integer
    field :ip_address, IPv4
    field :latency, :integer
    field :name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Host{} = host, attrs) do
    host
    |> cast(attrs, [:name, :ip_address, :check_frequency])
    |> validate_required([:name, :ip_address])
    |> unique_constraint(:ip_address)
  end

  @doc false
  def status_changeset(%Host{} = host, attrs) do
    host
    |> cast(attrs, [:latency, :status])
  end
end
