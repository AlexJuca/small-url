defmodule SmallUrl.Repo.Migrations.CreateClicks do
  use Ecto.Migration

  def change do
    create table(:clicks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :key, :string
      add :click_date, :utc_datetime
      add :short_links_id, references(:short_links, type: :binary_id)
      timestamps()
    end
  end
end
