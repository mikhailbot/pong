defmodule Pong.Repo.Migrations.CreateHosts do
  use Ecto.Migration

  def change do
    create table(:hosts) do
      add :name, :string
      add :ip_address, :string
      add :status, :string
      add :latency, :integer
      add :check_frequency, :integer

      timestamps()
    end

    create unique_index(:hosts, [:ip_address])
  end
end
