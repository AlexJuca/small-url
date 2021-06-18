defmodule SmallUrlWeb.PageLive do
  use SmallUrlWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("validate", %{"q" => query}, socket) do
    
  end

  defp validate_url(url), do: String.match?(url, @url_regex)

  @impl true
  def handle_event("shorten_url", %{"q" => query}, socket) do
    {:noreply, assign(socket, %{})}
  end

  defp search(query) do
    if not SmallUrlWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
