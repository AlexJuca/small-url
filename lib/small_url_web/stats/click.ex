defmodule SmallUrl.Stats.Click do
  alias SmallUrl.Links

  def gather_stats(key) do
    shortlink = Links.get_short_link_by_key_and_preload_clicks(key)

    number_of_clicks =
      shortlink
      |> get_number_of_clicks()

    last_click_date =
      shortlink
      |> get_last_click_date()

    %{
      :clicks => number_of_clicks,
      :last_click_date => last_click_date,
      :last_30_days => 0
    }
  end

  def get_last_click_date(shortlink) do
    clicks = Map.get(shortlink, :clicks)
    Enum.map(clicks, fn click -> Map.get(click, :click_date) end) |> Enum.sort(:desc) |> Enum.at(0)
  end

  def get_number_of_clicks(shortlink) do
    Map.get(shortlink, :clicks)
      |> Enum.count()
  end

  def get_click_frequencies_for_last_30_days(link_key) do
    clicks_from_last_30_days =
      Links.clicks_from_last_30_days(link_key)
      |> Enum.map(fn click -> Map.get(click, :click_date) end)

    dates =
      Enum.map(clicks_from_last_30_days, fn date -> date |> Calendar.strftime("%B %-d, %Y") end)

    frequencies =
      Enum.frequencies(dates)
      |> Enum.map(fn f -> Map.put(%{:month => elem(f, 0)}, "clicks", elem(f, 1)) end)
  end
end
