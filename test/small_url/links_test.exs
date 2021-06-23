defmodule SmallUrl.LinksTest do
  use SmallUrl.DataCase

  alias SmallUrl.Links

  describe "shortlinks" do
    alias SmallUrl.Links.ShortLinks

    @valid_attrs %{
      expiration_date: ~N[2010-04-17 14:00:00],
      ip: "some ip",
      key: "some key",
      url: "some url"
    }
    @update_attrs %{
      expiration_date: ~N[2011-05-18 15:01:01],
      ip: "some updated ip",
      key: "some updated key",
      url: "some updated url"
    }
    @invalid_attrs %{expiration_date: nil, ip: nil, key: nil, url: nil}

    def short_links_fixture(attrs \\ %{}) do
      {:ok, short_links} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_short_links()

      short_links
    end

    test "list_shortlinks/0 returns all shortlinks" do
      short_links = short_links_fixture()
      assert Links.list_shortlinks() == [short_links]
    end

    test "get_short_links!/1 returns the short_links with given id" do
      short_links = short_links_fixture()
      assert Links.get_short_links!(short_links.id) == short_links
    end

    test "create_short_links/1 with valid data creates a short_links" do
      assert {:ok, %ShortLinks{} = short_links} = Links.create_short_links(@valid_attrs)
      assert short_links.expiration_date == ~N[2010-04-17 14:00:00]
      assert short_links.ip == "some ip"
      assert short_links.key == "some key"
      assert short_links.url == "some url"
    end

    test "create_short_links/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_short_links(@invalid_attrs)
    end

    test "update_short_links/2 with valid data updates the short_links" do
      short_links = short_links_fixture()

      assert {:ok, %ShortLinks{} = short_links} =
               Links.update_short_links(short_links, @update_attrs)

      assert short_links.expiration_date == ~N[2011-05-18 15:01:01]
      assert short_links.ip == "some updated ip"
      assert short_links.key == "some updated key"
      assert short_links.url == "some updated url"
    end

    test "update_short_links/2 with invalid data returns error changeset" do
      short_links = short_links_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_short_links(short_links, @invalid_attrs)
      assert short_links == Links.get_short_links!(short_links.id)
    end

    test "delete_short_links/1 deletes the short_links" do
      short_links = short_links_fixture()
      assert {:ok, %ShortLinks{}} = Links.delete_short_links(short_links)
      assert_raise Ecto.NoResultsError, fn -> Links.get_short_links!(short_links.id) end
    end

    test "change_short_links/1 returns a short_links changeset" do
      short_links = short_links_fixture()
      assert %Ecto.Changeset{} = Links.change_short_links(short_links)
    end
  end
end
