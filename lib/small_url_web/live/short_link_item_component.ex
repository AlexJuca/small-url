defmodule SmallUrlWeb.ShortLinkItemComponent do
  use SmallUrlWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="space-y-4">
        <%= for link <- @short_links do %>
            <div class="h-14 w-full block">
                <span class="relative inline-flex rounded-full h-2 w-2 bg-indigo-400"></span>
                <span class="w-8 ml-6 inline-flex"><p class="text-gray-500"><%= slice_original_url(link.url) %></p></span>
                <span class="w-20 ml-80 inline-flex"><p class="text-blue-500"><%= create_link(@socket, link) %></p></span>
                <span aria-label="Copy URL to clipboard" class="tooltip top ml-4 inline-flex"><button data-element="copy-url-to-clipboard" data-element-id='<%= show_encoded_link(@socket, link) %>' class="rounded-md border border-solid shadow-sm px-4 py-2 bg-white text-base font-medium text-blue-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm" type="submit">Copy</button></span>
                <span class="ml-4 inline-flex"><button class="rounded-md border border-solid shadow-sm px-4 py-2 bg-white text-base font-medium text-blue-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm" type="submit">View Stats</button></span>
                <span class="ml-4 inline-flex">
                    <%= live_patch to: Routes.page_path(@socket, :qr),
                        class: "button button-outlined-gray whitespace-nowrap"
                    do %>
                        <i class="ri-qr-code-line cursor-pointer"></i>
                    <% end %>
                </span>
                <div class="w-full mt-2 h-0.5 bg-gray-100"></div>
            </div>
        <% end %>
    </div>

    <%= if @live_action == :qr do %>
    <%= live_modal SmallUrlWeb.QrUrlComponent,
            id: :close_session_modal,
            modal_class: "w-full max-w-xl",
            return_to: Routes.page_path(@socket, :index)
            %>
    <% end %>

    """
  end
end
