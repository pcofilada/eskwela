defmodule Eskwela.Repo.Migrations.CreateQuiz do
  use Ecto.Migration

  def change do
    create table(:quizzes) do
      add :status, :string
      add :level_id, references(:levels, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:quizzes, [:level_id])
    create index(:quizzes, [:user_id])

  end
end
