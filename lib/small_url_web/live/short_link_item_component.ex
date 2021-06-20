defmodule SmallUrlWeb.ShortLinkItemComponent do
    use SmallUrlWeb, :live_component

    @impl true
    def render(assigns) do
        ~L"""
        <div class="space-y-4">
            <%= for link <- @short_links do %>
                <div class="h-14 w-full block">
                    <span class="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
                    <span class="w-8 ml-6 inline-flex"><p class=""><%= "#{String.slice(link.url, 0, 30)}..." %></p></span>
                    <span class="w-20 ml-80 inline-flex"><p class="font-bold text-indigo-500"><%= link(link.key, to: "#{SmallUrlWeb.Endpoint.url()}/#{link.key}") %></p></span>
                    <span class="ml-4 inline-flex"><button class="focus:outline-none p-2 rounded-md bg-gray-200 text-indigo hover:shadow-md" type="submit">Copy</button></span>
                    <span class="ml-4 inline-flex"><i class="ri-qr-code-line cursor-pointer"></i></span>
                    <div class="w-full mt-2 h-0.5 bg-gray-100"></div>
                </div>
            <% end %>
        </div>
        """
    end
end