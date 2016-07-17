defmodule Issues.IssueController do
  use Issues.Web, :controller

  alias Issues.Issue

  def index(conn, _params) do
    issues = Repo.all(Issue)
    render(conn, "index.json", issues: issues)
  end

  def create(conn, %{"issue" => issue_params}) do
    changeset = Issue.changeset(%Issue{}, issue_params)

    case Repo.insert(changeset) do
      {:ok, issue} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", issue_path(conn, :show, issue))
        |> render("show.json", issue: issue)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Issues.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Repo.get!(Issue, id)
    render(conn, "show.json", issue: issue)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Repo.get!(Issue, id)
    changeset = Issue.changeset(issue, issue_params)

    case Repo.update(changeset) do
      {:ok, issue} ->
        render(conn, "show.json", issue: issue)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Issues.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Repo.get!(Issue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(issue)

    send_resp(conn, :no_content, "")
  end
end
