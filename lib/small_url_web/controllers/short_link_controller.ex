defmodule SmallUrlWeb.ShortLinkController do
  use SmallUrlWeb, :controller
  alias SmallUrl.Links
  alias SmallUrl.Links.ShortLinks
  alias SmallUrl.Repo

  def redirect_to_original_url(conn, %{"key" => key}) do
    shortlink = Links.get_short_links_by_key(key)

    case shortlink do
      nil ->
        conn
        |> put_view(SmallUrlWeb.ErrorView)
        |> render("404.html")

      shortlink ->
        IO.inspect(shortlink)

        shortlink
        |> register_click

        conn
        |> redirect(external: Map.get(shortlink, :url))
    end
  end

  def show_link_analytics(conn, %{"key" => key}) do
    case Links.get_short_links_by_key(key) do
      %ShortLinks{} = shortlink ->
        conn
        |> gather_stats(shortlink)

      nil ->
        conn
        |> resp(404, "Not found")
    end
  end

  def gather_stats(conn, shortlink) do
    shortlink = SmallUrl.Repo.preload(shortlink, :clicks)
    clicks = Map.get(shortlink, :clicks)
    number_of_clicks = Enum.count(clicks)

    last_click_date =
      Enum.map(clicks, fn click -> Map.get(click, :click_date) end) |> Enum.sort() |> Enum.at(0)

    clicks_from_last_30_days =
      Links.clicks_from_last_30_days(shortlink.key)
      |> Enum.map(fn click -> Map.get(click, :click_date) end)

    link_info = %{
      :clicks => number_of_clicks,
      :last_click_date => last_click_date,
      :last_30_days => clicks_from_last_30_days
    }

    conn
    |> put_view(SmallUrlWeb.LinkAnalyticsView)
    |> render("analytics.json", link_info: link_info)
  end

  defp register_click(%ShortLinks{} = link) do
    attrs = %{
      :key => link.key,
      :click_date => DateTime.utc_now() |> DateTime.truncate(:second),
      :shortlinks_id => link.id
    }

    click = Ecto.build_assoc(link, :clicks, attrs)

    Repo.insert!(click)
    |> broadcast(:click_created)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(SmallUrl.PubSub, "click")
  end

  def broadcast({:error, _reason} = error, _event), do: error

  def broadcast(click, _) do
    Phoenix.PubSub.broadcast(SmallUrl.PubSub, "click", %{event: click})
    {:ok, click}
  end
end
