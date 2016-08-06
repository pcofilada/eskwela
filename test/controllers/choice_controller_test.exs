defmodule Eskwela.ChoiceControllerTest do
  use Eskwela.ConnCase

  alias Eskwela.Choice
  @valid_attrs %{correct_answer: true, item: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, choice_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing choices"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, choice_path(conn, :new)
    assert html_response(conn, 200) =~ "New choice"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, choice_path(conn, :create), choice: @valid_attrs
    assert redirected_to(conn) == choice_path(conn, :index)
    assert Repo.get_by(Choice, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, choice_path(conn, :create), choice: @invalid_attrs
    assert html_response(conn, 200) =~ "New choice"
  end

  test "shows chosen resource", %{conn: conn} do
    choice = Repo.insert! %Choice{}
    conn = get conn, choice_path(conn, :show, choice)
    assert html_response(conn, 200) =~ "Show choice"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, choice_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    choice = Repo.insert! %Choice{}
    conn = get conn, choice_path(conn, :edit, choice)
    assert html_response(conn, 200) =~ "Edit choice"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    choice = Repo.insert! %Choice{}
    conn = put conn, choice_path(conn, :update, choice), choice: @valid_attrs
    assert redirected_to(conn) == choice_path(conn, :show, choice)
    assert Repo.get_by(Choice, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    choice = Repo.insert! %Choice{}
    conn = put conn, choice_path(conn, :update, choice), choice: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit choice"
  end

  test "deletes chosen resource", %{conn: conn} do
    choice = Repo.insert! %Choice{}
    conn = delete conn, choice_path(conn, :delete, choice)
    assert redirected_to(conn) == choice_path(conn, :index)
    refute Repo.get(Choice, choice.id)
  end
end
