defmodule Eskwela.Quiz do
  use Eskwela.Web, :model


  schema "quizzes" do
    field :status, :string
    belongs_to :level, Eskwela.Level
    belongs_to :user, Eskwela.User
    has_many :quiz_questions, Eskwela.QuizQuestion

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status, :user_id, :level_id])
    |> validate_required([:status, :user_id])
  end

  def create_quiz_questions do

  end
end
