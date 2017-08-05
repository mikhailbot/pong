defmodule Pong.Repo.Migrations.CreateHosts do
  @moduledoc """
  Create Hosts Migration
  """

  use Ecto.Migration

  def change do
    create table(:hosts) do
      add :name, :string
      add :ip_address, :string

      timestamps()
    end

    create unique_index(:hosts, [:ip_address])
  end
end
