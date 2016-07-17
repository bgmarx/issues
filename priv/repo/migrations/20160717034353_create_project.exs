defmodule Issues.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name,       :string
      add :project_id, :integer

      timestamps()
    end
  end
end
