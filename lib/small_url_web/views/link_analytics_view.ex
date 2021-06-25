defmodule SmallUrlWeb.LinkAnalyticsView do
  use SmallUrlWeb, :view

  def render("analytics.json", %{link_info: link}) do
    %{
      :clicks => link.clicks,
      :last_click_date => link.last_click_date
    }
  end
end
