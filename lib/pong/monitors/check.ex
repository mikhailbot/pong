defmodule Pong.Monitors.Check do
  @moduledoc """
  Schema and changesets for Checks
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Pong.Monitors.Check

  schema "checks" do
    field :latency, :integer
    belongs_to :host, Pong.Monitors.Host

    timestamps()
  end

  @doc false
  def changeset(%Check{} = check, attrs) do
    check
    |> cast(attrs, [:latency])
    |> validate_required([:latency])
  end
end
