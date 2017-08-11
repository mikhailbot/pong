defmodule Pong.Repo.Migrations.AddStatusToHosts do
  use Ecto.Migration

  def change do
    alter table(:hosts) do
      add :status, :string, default: "unknown"
    end
  end
end
