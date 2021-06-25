defmodule SmallUrlWeb.UrlController do
  use SmallUrlWeb, :controller
  alias SmallUrl.Links
  alias SmallUrl.Links.Click
  alias SmallUrl.Links.ShortLinks
  alias SmallUrl.Repo

  @url %{}

  def new(conn, params) do
    id = Ksuid.generate() |> String.slice(4, 7)
    @url = Map.put_new(@url, id, params[:url])
    IO.inspect(@url)
    IO.inspect(id)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, id)
    |> halt()
  end

  def get(conn, %{"id" => id} = params) do
    url = Map.get(@url, id)
    IO.inspect(@url)

    case url do
      nil ->
        conn
        |> send_resp(404, "Not found")
        |> halt()

      id ->
        conn
        |> send_resp(200, id)
        |> halt()
    end
  end

  def redirect_to_original_url(conn, %{"key" => key} = params) do
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

  def show_link_analytics(conn, %{"key" => key} = params) do
    shortlink = Links.get_short_links_by_key(key)

    case shortlink do
      {:ok, shortlink} ->
        conn |> gather_stats(shortlink)

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

    link_info = %{
      :clicks => number_of_clicks,
      :last_click_date => last_click_date
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
  end
end
