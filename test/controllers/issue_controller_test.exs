defmodule Issues.IssueControllerTest do
  use Issues.ConnCase

  alias Issues.Issue
  @valid_attrs %{id: 42, issue_number: 42, locked: true, repo_url: "some content", state: "some content", title: "some content", url: "some content", user_id: 42, username: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, issue_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = get conn, issue_path(conn, :show, issue)
    assert json_response(conn, 200)["data"] == %{"id" => issue.id,
      "url" => issue.url,
      "repo_url" => issue.repo_url,
      "id" => issue.id,
      "issue_number" => issue.issue_number,
      "title" => issue.title,
      "state" => issue.state,
      "locked" => issue.locked,
      "username" => issue.username,
      "user_id" => issue.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, issue_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, issue_path(conn, :create), issue: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Issue, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, issue_path(conn, :create), issue: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = put conn, issue_path(conn, :update, issue), issue: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Issue, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = put conn, issue_path(conn, :update, issue), issue: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = delete conn, issue_path(conn, :delete, issue)
    assert response(conn, 204)
    refute Repo.get(Issue, issue.id)
  end
end
