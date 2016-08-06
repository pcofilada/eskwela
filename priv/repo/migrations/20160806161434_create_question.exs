defmodule Eskwela.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :item, :text
      add :subject_id, references(:subjects, on_delete: :nothing)

      timestamps()
    end
    create index(:questions, [:subject_id])

  end
end
