defmodule SmallUrlWeb.PageLive do
  use SmallUrlWeb, :live_view
  alias SmallUrl.Links
  alias SmallUrlWeb.LinkHelpers

  @impl true
  def mount(_params, _session, socket) do
    # TODO: Store session key for each client, than load 10 shortlinks by client_key
    short_links = Links.list_shortlinks

    {:ok, assign(socket, query: "", results: %{}, short_links: short_links)}
  end

  @impl true
  def handle_event("validate", %{"q" => query}, socket) do
    {:noreply, socket}
  end

  defp validate_url(url), do: String.match?(url, @url_regex)

  @impl true
  def handle_event("shorten_url", %{"q" => query}, socket) do
    key = LinkHelpers.generate_key()
    expiration_date = LinkHelpers.generate_expiration_date()

    short_links = socket.assigns[:short_links]
  
    url = query
    map = %{:url => url, :key => key, :expiration_date => expiration_date, :ip => nil}

    case Links.create_short_links(map) do
      {:ok, shortened_link} -> {:noreply, assign(socket, :short_links, [shortened_link | short_links])}
      {:error, %Ecto.Changeset{}} -> {:noreply, put_flash(socket, :error, "Error")}
    end
  end

  def handle_params(_params, _url, socket), do: {:noreply, socket}
end
