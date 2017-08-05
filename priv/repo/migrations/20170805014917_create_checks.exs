defmodule Pong.Repo.Migrations.CreateChecks do
  @moduledoc """
  Create Checks Migration
  """

  use Ecto.Migration

  def change do
    create table(:check) do
      add :host_id, references(:hosts)
      add :latency, :integer

      timestamps()
    end
  end
end
