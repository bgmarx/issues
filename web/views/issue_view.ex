defmodule Issues.IssueView do
  use Issues.Web, :view

  def render("index.json", %{issues: issues}) do
    %{data: render_many(issues, Issues.IssueView, "issue.json")}
  end
  def render("show.json", %{issue: issue}) do
    %{data: render_one(issue, Issues.IssueView, "issue.json")}
  end
  def render("project_issues.json", %{issues: issues}), do: %{issues: issues}
  def render("project_issue.json", %{issue: issue}), do: %{issue: issue}
  def render("issue.json", %{issue: issue}) do
    %{id: issue.id,
      url: issue.url,
      repo_url: issue.repo_url,
      issue_id: issue.issue_id,
      issue_number: issue.issue_number,
      title: issue.title,
      state: issue.state,
      locked: issue.locked,
      username: issue.username,
      user_id: issue.user_id}
  end
end
