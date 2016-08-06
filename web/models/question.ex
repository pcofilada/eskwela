defmodule Eskwela.Question do
  use Eskwela.Web, :model

  schema "questions" do
    field :item, :string
    belongs_to :subject, Eskwela.Subject

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:item, :subject_id])
    |> validate_required([:item, :subject_id])
  end
end
