defmodule SmallUrlWeb.QrUrlComponent do
    use SmallUrlWeb, :live_component

    @impl true
    def render(assigns) do
        # TODO: Generate QR and display inside modal
        ~L"""
        <div class="p-6 flex flex-col space-y-3">
            <div class="content-center place-content-center">
                <img id="qr-image" class="w-80 m-auto" src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png">
                <span><p class="text-center">https://www.orginal.url.com</p></span>
                <div class="content-center place-content-center px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                    <button type="button" class="w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-blue-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Download
                    </button>
                    <%= live_patch to: @return_to do %>
                        <button type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                        Cancel
                        </button>
                    <%= end %>
                </div>
            </div>
        </div>
        """
    end
end