defmodule SmallUrlWeb.ShortLinkController do
  use SmallUrlWeb, :controller
  alias SmallUrl.Links
  alias SmallUrl.Links.ShortLinks
  alias SmallUrl.Repo

  def redirect_to_original_url(conn, %{"key" => key}) do
    shortlink = Links.get_short_link_by_key(key)

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
    case Links.get_short_link_by_key(key) do
      %ShortLinks{} = _ ->
        conn
        |> gather_stats(key)

      nil ->
        conn
        |> resp(404, "Not found")
    end
  end

  def gather_stats(conn, key) do
    stats = SmallUrl.Stats.Click.gather_stats(key)
    conn
    |> put_view(SmallUrlWeb.LinkAnalyticsView)
    |> render("analytics.json", link_info: stats)
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

  def broadcast(click, event) do
    Phoenix.PubSub.broadcast(SmallUrl.PubSub, "click", %{event: click})
    {:ok, click}
  end
end
