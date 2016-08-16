defmodule Eskwela.QuizTest do
  use Eskwela.ModelCase

  alias Eskwela.Quiz

  @valid_attrs %{status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Quiz.changeset(%Quiz{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quiz.changeset(%Quiz{}, @invalid_attrs)
    refute changeset.valid?
  end
end
