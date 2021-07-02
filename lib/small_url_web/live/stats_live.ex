defmodule SmallUrlWeb.StatsLive do
  use SmallUrlWeb, :live_view
  alias SmallUrl.Links
  alias VegaLite, as: Vl

  @impl true
  def mount(%{"key" => key} = _params, _session, socket) do
    if connected?(socket), do: SmallUrlWeb.ShortLinkController.subscribe()

    shortlink = Links.get_short_link_by_key(key)

    stats = SmallUrl.Stats.Click.gather_stats(key)

    click_frequencies = SmallUrl.Stats.Click.get_click_frequencies_for_last_30_days(key)

    {:ok,
     assign(socket, %{
       link: shortlink,
       link_info: stats,
       key: key,
       click_frequencies: click_frequencies
     })}
  end

  @impl true
  def handle_info(_, socket) do
    key = socket.assigns[:key]

    stats = SmallUrl.Stats.Click.gather_stats(key)

    click_frequencies = SmallUrl.Stats.Click.get_click_frequencies_for_last_30_days(key)

    {:noreply,
     assign(socket, %{
       link_info: stats,
       key: key,
       click_frequencies: click_frequencies
     })}
  end
end
