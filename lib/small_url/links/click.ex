defmodule SmallUrl.Links.Click do
  use Ecto.Schema
  import Ecto.Changeset
  alias SmallUrl.Links.ShortLinks

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clicks" do
    field :click_date, :utc_datetime
    field :key, :string
    belongs_to :short_links, ShortLinks, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(click, attrs) do
    click
    |> cast(attrs, [:key, :click_date])
    |> validate_required([:key, :click_date])
  end
end
