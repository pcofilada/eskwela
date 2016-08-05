defmodule Eskwela.Repo.Migrations.CreateSubject do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      add :level_id, references(:levels, on_delete: :nothing)

      timestamps()
    end
    create index(:subjects, [:level_id])

  end
end
