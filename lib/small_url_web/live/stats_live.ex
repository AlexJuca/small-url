defmodule SmallUrlWeb.StatsLive do
  use SmallUrlWeb, :live_view
  alias SmallUrl.Links
  import VegaLite
  alias VegaLite, as: Vl

  def mount(%{"key" => key} = params, session, socket) do
    if connected?(socket), do: :timer.send_interval(3000, self(), :update_click_frequency_graph)

    shortlink = Links.get_short_links_by_key(key)

    shortlink = SmallUrl.Repo.preload(shortlink, :clicks)
    clicks = Map.get(shortlink, :clicks)
    number_of_clicks = Enum.count(clicks)

    last_click_date =
      Enum.map(clicks, fn click -> Map.get(click, :click_date) end) |> Enum.sort() |> Enum.at(0)

    click_frequencies = get_click_frequencies_for_last_30_days(key)

    link_info = %{
      :clicks => number_of_clicks,
      :last_click_date => last_click_date,
      :last_30_days => 10
    }

    {:ok,
     assign(socket, %{
       link: shortlink,
       link_info: link_info,
       key: key,
       click_frequencies: click_frequencies
     })}
  end

  def handle_info(:update_click_frequency_graph, socket) do
    key = socket.assigns[:key]

    shortlink = Links.get_short_links_by_key(key)

    click_frequencies = get_click_frequencies_for_last_30_days(key)

    shortlink = SmallUrl.Repo.preload(shortlink, :clicks)
    clicks = Map.get(shortlink, :clicks)
    number_of_clicks = Enum.count(clicks)

    link_info = %{
      :clicks => number_of_clicks,
      :last_click_date => nil
    }

    {:noreply,
     assign(socket,
       link_info: link_info,
       click_frequencies: click_frequencies
     )}
  end

  @impl true
  def handle_info(map, socket) do
    key = socket.assigns[:key]

    shortlink = Links.get_short_links_by_key(key)

    shortlink = SmallUrl.Repo.preload(shortlink, :clicks)
    clicks = Map.get(shortlink, :clicks)
    number_of_clicks = Enum.count(clicks)

    last_click_date =
      Enum.map(clicks, fn click -> Map.get(click, :click_date) end) |> Enum.sort() |> Enum.at(0)

    link_info = %{
      :clicks => number_of_clicks,
      :last_click_date => last_click_date,
      :last_30_days => 10
    }

    click_frequencies = get_click_frequencies_for_last_30_days(key)

    {:ok,
     assign(socket, %{
       link: shortlink,
       link_info: link_info,
       key: key,
       click_frequencies: click_frequencies
     })}
  end

  defp get_click_frequencies_for_last_30_days(nil), do: [%{}]

  defp get_click_frequencies_for_last_30_days(link_key) do
    clicks_from_last_30_days =
      Links.clicks_from_last_30_days(link_key)
      |> Enum.map(fn click -> Map.get(click, :click_date) end)

    dates =
      Enum.map(clicks_from_last_30_days, fn date -> date |> Calendar.strftime("%B %-d, %Y") end)

    frequencies =
      Enum.frequencies(dates)
      |> Enum.map(fn f -> Map.put(%{:month => elem(f, 0)}, "clicks", elem(f, 1)) end)
  end

  defp render_output(_socket, {:vega_lite_static, spec}, id) do
    live_component(SmallUrlWeb.Output.VegaLiteStaticComponent, id: id, spec: spec)
  end
end
