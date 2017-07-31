defmodule Pong.Monitors.Host do
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
end
