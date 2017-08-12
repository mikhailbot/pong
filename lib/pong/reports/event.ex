defmodule Pong.Reports.Event do
  @moduledoc """
  Schema and changesets for Events
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Pong.Reports.Event

  schema "events" do
    field :status, :string
    belongs_to :host, Pong.Monitors.Host

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:host_id, :status])
    |> validate_required([:host_id, :status])
  end
end
