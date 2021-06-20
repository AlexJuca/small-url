defmodule SmallUrl.Repo.Migrations.CreateShortlinks do
  use Ecto.Migration

  def change do
    create table(:shortlinks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :key, :string
      add :expiration_date, :naive_datetime
      add :ip, :string

      timestamps()
    end

  end
end
