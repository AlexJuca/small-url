defmodule SmallUrl.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias SmallUrl.Repo

  alias SmallUrl.Links.ShortLinks

  @doc """
  Returns the list of shortlinks.

  ## Examples

      iex> list_shortlinks()
      [%ShortLinks{}, ...]

  """
  def list_shortlinks do
    Repo.all(ShortLinks)
  end

  @doc """
  Gets a single short_links.

  Raises `Ecto.NoResultsError` if the Short links does not exist.

  ## Examples

      iex> get_short_links!(123)
      %ShortLinks{}

      iex> get_short_links!(456)
      ** (Ecto.NoResultsError)

  """
  def get_short_links!(id), do: Repo.get!(ShortLinks, id)

  def get_short_links_by_key(key) do
    query = from s in ShortLinks, where: s.key == ^key
    Repo.one(query)
  end

  @doc """
  Creates a short_links.

  ## Examples

      iex> create_short_links(%{field: value})
      {:ok, %ShortLinks{}}

      iex> create_short_links(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_short_links(attrs \\ %{}) do
    %ShortLinks{}
    |> ShortLinks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a short_links.

  ## Examples

      iex> update_short_links(short_links, %{field: new_value})
      {:ok, %ShortLinks{}}

      iex> update_short_links(short_links, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_short_links(%ShortLinks{} = short_links, attrs) do
    short_links
    |> ShortLinks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a short_links.

  ## Examples

      iex> delete_short_links(short_links)
      {:ok, %ShortLinks{}}

      iex> delete_short_links(short_links)
      {:error, %Ecto.Changeset{}}

  """
  def delete_short_links(%ShortLinks{} = short_links) do
    Repo.delete(short_links)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking short_links changes.

  ## Examples

      iex> change_short_links(short_links)
      %Ecto.Changeset{data: %ShortLinks{}}

  """
  def change_short_links(%ShortLinks{} = short_links, attrs \\ %{}) do
    ShortLinks.changeset(short_links, attrs)
  end
end
