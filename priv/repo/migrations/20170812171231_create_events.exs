defmodule Pong.Repo.Migrations.CreateEvents do
  @moduledoc """
  Create Events migration
  """

  use Ecto.Migration

  def change do
    create table(:events) do
      add :host_id, references(:hosts)
      add :status, :string

      timestamps()
    end
  end
end
