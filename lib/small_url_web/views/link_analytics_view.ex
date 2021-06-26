defmodule SmallUrlWeb.LinkAnalyticsView do
  use SmallUrlWeb, :view

  def render("analytics.json", %{link_info: link}) do
    %{
      :clicks => link.clicks,
      :last_click_date => link.last_click_date,
      :last_30_days => [Enum.map(link.last_30_days, fn click -> click end)]
    }
  end
end
