defmodule Eskwela.User do
  use Eskwela.Web, :model

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :first_name, :last_name, :password])
    |> validate_required([:username, :first_name, :last_name, :password])
  end
end
