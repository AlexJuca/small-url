defmodule SmallUrlWeb.QrUrlComponent do
    use SmallUrlWeb, :live_component

    @impl true
    def render(assigns) do
        ~L"""
        <div class="p-6 flex flex-col space-y-3">
            <div class="content-center place-content-center"> 
                <span class=""><h1 class="text-center">Generated QR Code</h1></span>
                <span class=""><p class="text-center">https://www.orginal.url.com</p></span>
                <img class="w-80 m-auto" src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png">
            </div>
        </div>
        """
    end
end