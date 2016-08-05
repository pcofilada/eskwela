defmodule Eskwela.SubjectControllerTest do
  use Eskwela.ConnCase

  alias Eskwela.Subject
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, subject_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing subjects"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, subject_path(conn, :new)
    assert html_response(conn, 200) =~ "New subject"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, subject_path(conn, :create), subject: @valid_attrs
    assert redirected_to(conn) == subject_path(conn, :index)
    assert Repo.get_by(Subject, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, subject_path(conn, :create), subject: @invalid_attrs
    assert html_response(conn, 200) =~ "New subject"
  end

  test "shows chosen resource", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = get conn, subject_path(conn, :show, subject)
    assert html_response(conn, 200) =~ "Show subject"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, subject_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = get conn, subject_path(conn, :edit, subject)
    assert html_response(conn, 200) =~ "Edit subject"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = put conn, subject_path(conn, :update, subject), subject: @valid_attrs
    assert redirected_to(conn) == subject_path(conn, :show, subject)
    assert Repo.get_by(Subject, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = put conn, subject_path(conn, :update, subject), subject: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit subject"
  end

  test "deletes chosen resource", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = delete conn, subject_path(conn, :delete, subject)
    assert redirected_to(conn) == subject_path(conn, :index)
    refute Repo.get(Subject, subject.id)
  end
end
