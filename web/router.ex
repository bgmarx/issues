defmodule Issues.Router do
  use Issues.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Issues do
    pipe_through :browser # Use the default browser stack

  end

  #Other scopes may use custom stacks.
  scope "/api", Issues do
    pipe_through :api
    resources "/issues", IssueController, except: [:new, :edit]

    get "/project_issues/:project_name/:repo_name", IssueController, :project_issues

    get "/project_issues/:project_name/:repo_name/issues/:issue_id", IssueController, :project_issue
  end
end
