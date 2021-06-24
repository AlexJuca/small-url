defmodule SmallUrl.Links.ShortLinks do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmallUrl.Links.Click

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "short_links" do
    field :expiration_date, :naive_datetime
    field :ip, :string
    field :key, :string
    field :url, :string
    has_many :clicks, Click

    timestamps()
  end

  @doc false
  def changeset(short_links, attrs) do
    short_links
    |> cast(attrs, [:url, :key, :expiration_date, :ip])
    |> validate_required([:url, :key, :expiration_date])
  end
end
