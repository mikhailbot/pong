defmodule Pong.Monitors.Host do
  @moduledoc """
  Schema and changesets for Hosts
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Pong.Monitors.Host
  alias Pong.Monitors.IPv4

  schema "hosts" do
    field :ip_address, IPv4
    field :name, :string
    has_many :checks, Pong.Monitors.Check

    timestamps()
  end

  @doc false
  def changeset(%Host{} = host, attrs) do
    host
    |> cast(attrs, [:name, :ip_address])
    |> validate_required([:name, :ip_address])
    |> unique_constraint(:ip_address)
  end
end
