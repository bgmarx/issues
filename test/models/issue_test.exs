defmodule Issues.IssueTest do
  use Issues.ModelCase

  alias Issues.Issue

  @valid_attrs %{issue_id: 42, issue_number: 42, locked: true, repo_url: "some content", state: "some content", title: "some content", url: "some content", user_id: 42, username: "some content"}
  @invalid_attrs %{username: "a",}

  test "changeset with valid attributes" do
    changeset = Issue.changeset(%Issue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Issue.changeset(%Issue{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset username length validation" do
    changeset = Issue.changeset(%Issue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
