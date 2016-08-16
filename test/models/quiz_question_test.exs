defmodule Eskwela.QuizQuestionTest do
  use Eskwela.ModelCase

  alias Eskwela.QuizQuestion

  @valid_attrs %{correct: true, question_id: 42, subject_id: 42, user_choice: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = QuizQuestion.changeset(%QuizQuestion{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = QuizQuestion.changeset(%QuizQuestion{}, @invalid_attrs)
    refute changeset.valid?
  end
end
