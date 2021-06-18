defmodule SmallUrlWeb.ShortLinkItemComponent do
    use SmallUrlWeb, :live_component

    @impl true
    def render(assigns) do
        ~L"""
        <div class="space-y-4">
            <div class="h-14 w-full block">
                <span class="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
                <span class="ml-6 inline-flex"><p class="">https://www.google.com</p></span>
                <span class="ml-40 inline-flex"><p class="font-bold text-indigo-500">https://www.sm.ly/Hr4818</p></span>
                <span class="ml-4 inline-flex"><button class="focus:outline-none p-2 rounded-md bg-gray-200 text-indigo hover:shadow-md" type="submit">Copy</button></span>
                <div class="w-full mt-2 h-0.5 bg-gray-100"></div>
            </div>
        </div>
        """
    end
end