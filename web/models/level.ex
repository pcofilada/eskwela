defmodule Eskwela.Level do
  use Eskwela.Web, :model

  schema "levels" do
    field :name, :string
    has_many :subjects, Eskwela.Subject
    has_many :quizzes, Eskwela.Quiz

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
