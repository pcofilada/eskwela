defmodule Eskwela.QuizQuestion do
  use Eskwela.Web, :model

  schema "quiz_questions" do
    #field :subject_id, :integer
    #field :question_id, :integer
    field :user_choice, :string
    field :correct, :boolean, default: false
    belongs_to :question, Eskwela.Question
    belongs_to :quiz, Eskwela.Quiz
    belongs_to :subject, Eskwela.Subject

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:subject_id, :question_id, :user_choice, :correct])
    |> validate_required([:subject_id, :question_id])
  end
end
