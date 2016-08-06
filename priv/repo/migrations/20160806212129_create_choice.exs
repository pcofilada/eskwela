defmodule Eskwela.Repo.Migrations.CreateChoice do
  use Ecto.Migration

  def change do
    create table(:choices) do
      add :item, :string
      add :correct_answer, :boolean, default: false, null: false
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end
    create index(:choices, [:question_id])

  end
end
