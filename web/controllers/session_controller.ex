defmodule Eskwela.SessionController do
  use Eskwela.Web, :controller

  plug :put_layout, "authentication.html"
  plug :check_if_logged_in when not action in [:delete]

  def new(conn, __params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Eskwela.Auth.sign_in(session_params, Repo) do
      {:ok, user} ->
        check_role(conn, user)
      :error ->
        conn
        |> put_flash(:error, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Signed Out")
    |> redirect(to: "/")
  end

  defp check_role(conn, user) do
    case user.role do
      "users" ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Signed In")
        |> redirect(to: quiz_path(conn, :index))
      "admin" ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Signed In")
        |> redirect(to: level_path(conn, :index))
    end
  end
end
