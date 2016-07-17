defmodule Issues.IssuesMonitor do
  use GenServer
  alias Issues.Repo
  import Ecto.Query

  def monitor_issues do
    GenServer.cast(__MODULE__, :update_issue_status)
  end

  def handle_cast(:update_issue_status, state) do
    update_issue_status
    {:noreply, state}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [{:name, __MODULE__} | opts])
  end

  def init(:ok) do
    t_ref = :timer.apply_interval(100_000, __MODULE__, :monitor_issues, [])
    {:ok, t_ref}
  end

  def terminate(_reason, _channel), do: {:ok}

  def update_issue_status do
    [issue] = Issues.Repo.all(from i in Issues.Issue, limit: 1)
    fetched_issue = Poison.decode!(Issues.IssueFetcher.fetch_issue(issue.url).body)
    case issue.state == fetched_issue["state"] do
      true -> :ok
      false ->
        changeset = Issues.Issue.changeset(issue, fetched_issue)
        case Repo.update(changeset) do
          {:ok, _issue} ->
            :ok
          {:error, changeset} ->
            IO.inspect changeset.errors
        end
    end
  end
end
