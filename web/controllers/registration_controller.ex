defmodule Eskwela.RegistrationController do
  use Eskwela.Web, :controller
  alias Eskwela.User

  plug :scrub_params, "user" when action in [:create]

  def new(conn, __params) do
    changeset = User.changeset(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{role: "users"}, user_params)

    case Eskwela.Auth.sign_up(changeset, Repo) do
      {:ok, changeset} ->
        conn
        |> put_flash(:info, "Account created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
