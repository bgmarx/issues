defmodule Issues.Issue do
  use Issues.Web, :model

  schema "issues" do
    field :url, :string
    field :repo_url, :string
    field :issue_id, :integer
    field :issue_number, :integer
    field :title, :string
    field :state, :string
    field :locked, :boolean, default: false
    field :username, :string
    field :user_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :repo_url, :issue_id, :issue_number, :title, :state, :locked, :username, :user_id])
    |> validate_required([:url, :repo_url, :issue_id, :issue_number, :title, :state, :locked, :username, :user_id])
    |> validate_length(:username, min: 3)
  end
end
