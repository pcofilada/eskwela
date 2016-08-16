defmodule Eskwela.Repo.Migrations.CreateQuizQuestion do
  use Ecto.Migration

  def change do
    create table(:quiz_questions) do
      add :subject_id, :integer
      add :question_id, :integer
      add :user_choice, :string
      add :correct, :boolean, default: false, null: false
      add :quiz_id, references(:quizzes, on_delete: :nothing)

      timestamps()
    end
    create index(:quiz_questions, [:quiz_id])

  end
end
