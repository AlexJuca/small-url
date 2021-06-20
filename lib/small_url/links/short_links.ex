defmodule SmallUrl.Links.ShortLinks do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shortlinks" do
    field :expiration_date, :naive_datetime
    field :ip, :string
    field :key, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(short_links, attrs) do
    short_links
    |> cast(attrs, [:url, :key, :expiration_date, :ip])
    |> validate_required([:url, :key, :expiration_date])
  end
end
