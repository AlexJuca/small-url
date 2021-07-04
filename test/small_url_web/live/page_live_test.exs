defmodule SmallUrlWeb.PageLiveTest do
  use SmallUrlWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, _disconnected_html} = live(conn, "/")
    assert render(page_live) != nil
  end
end
