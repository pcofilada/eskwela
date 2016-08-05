defmodule Eskwela.Subject do
  use Eskwela.Web, :model

  schema "subjects" do
    field :name, :string
    belongs_to :level, Eskwela.Level

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
