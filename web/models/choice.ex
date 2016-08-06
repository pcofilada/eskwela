defmodule Eskwela.Choice do
  use Eskwela.Web, :model

  schema "choices" do
    field :item, :string
    field :correct_answer, :boolean, default: false
    belongs_to :question, Eskwela.Question

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:item, :correct_answer])
    |> validate_required([:item, :correct_answer])
  end
end
