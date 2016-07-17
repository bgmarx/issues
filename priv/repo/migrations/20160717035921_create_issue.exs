defmodule Issues.Repo.Migrations.CreateIssue do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :project_id,   :integer
      add :project_name, :string
      add :url,          :string
      add :repo_url,     :string
      add :issue_id,     :integer
      add :issue_number, :integer
      add :title,        :string
      add :state,        :string
      add :locked,       :boolean, default: false, null: false
      add :username,     :string
      add :user_id,      :integer

      timestamps()
    end

  end
end
