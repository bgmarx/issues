defmodule Issues.IssueFetcher do
  @url "https://api.github.com/repos/"
  def fetch_issues(project_name, repo_name) do
    @url <> project_name <> "/" <> repo_name <> "/issues"
    |> fetch
  end

  def fetch_issue(project_name, repo_name, issue_id ) do
    @url <> project_name <> "/" <> repo_name <> "/issues/" <> issue_id
    |> fetch
  end
  def fetch_issue(url), do: fetch(url)

  def fetch(url) do
    {:ok, response} = HTTPoison.get(url)
    response
  end
end
