defmodule Eskwela.ChoiceTest do
  use Eskwela.ModelCase

  alias Eskwela.Choice

  @valid_attrs %{correct_answer: true, item: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Choice.changeset(%Choice{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Choice.changeset(%Choice{}, @invalid_attrs)
    refute changeset.valid?
  end
end
