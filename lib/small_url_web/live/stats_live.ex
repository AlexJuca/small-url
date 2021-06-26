defmodule SmallUrlWeb.StatsLive do
  use SmallUrlWeb, :live_view
  alias SmallUrl.Links

  def mount(%{"key" => key} = params, session, socket) do

    if connected?(socket), do: SmallUrlWeb.UrlController.subscribe()
    
    link = Links.get_short_links_by_key(key)

    shortlink = SmallUrl.Repo.preload(link, :clicks)
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

    {:ok, assign(socket, %{link: link, link_info: link_info})}
  end

  @impl true
  def handle_info({:click_created, click}, %{"key" => key} = params, socket) do

    link = Links.get_short_links_by_key(key)

    shortlink = SmallUrl.Repo.preload(link, :clicks)
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

    {:noreply, assign(socket, %{link: link, link_info: link_info})}
  end
end
