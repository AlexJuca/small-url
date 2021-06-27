import copy from 'copy-to-clipboard';
import shareFacebook from 'share-facebook';
import shareTwitter from 'share-twitter';

const ShortLink = {
    mounted() {
        this.handleDocumentMouseDown = (event) => {
            handleDocumentMouseDown(this, event);
        }

        document.addEventListener("mousedown", this.handleDocumentMouseDown);
    },
    destroyed() {
        document.removeEventListener("mousedown", this.handleDocumentMouseDown);
    },
};

// DOM event handlers

function handleDocumentMouseDown(hook, event) {
    // If click targets a clickable element that awaits mouse up, keep the focus as is
    if (event.target.closest(`a, button`)) {
        // if the Copy button is clocked, copy URL to clipboard
        if (event.target.closest(`[data-element="copy-url-to-clipboard"]`)) {
            copyURLToClipboard(hook, event);
        }

        if (event.target.closest(`[data-element="share-on-facebook"]`)) {
            shareOnFacebook(hook, event);
        }

        if (event.target.closest(`[data-element="share-on-twitter"]`)) {
            shareOnTwitter(hook, event);
        }
    }

    return;
}

function shareOnTwitter(hook, event) {
    const item = event.target;

    if (item) {
        const url = item.getAttribute("data-element-id");
        console.log(url);
        if (url) {
            const twitterShareLink = shareTwitter({
                text: 'Checkout my awesome shortlink',
                url: url,
              })
            const newTab = window.open(twitterShareLink);
        }
    }
}

function shareOnFacebook(hook, event) {
    const item = event.target;

    if (item) {
        const url = item.getAttribute("data-element-id");
        console.log(url);
        if (url) {
            const facebookShareLink = shareFacebook({
                quote: 'Checkout my awesome shortlink',
                href: url,
                redirect_uri: url,
                app_id: '163966962458513'
            });
            const newTab = window.open(facebookShareLink);
        }
    }
}

function showToast(message) {
    const copyAlert = document.getElementById("copy-toast");
    copyAlert.innerHTML = `<div class="z-40 md:z-50 p-2 bg-indigo-800 items-center text-indigo-100 shadow-xl leading-none lg:rounded-full flex lg:inline-flex" role="alert">
        <span class="flex rounded-full bg-green-500 uppercase px-2 py-1 text-xs font-bold mr-3"><i class="text-white ri-check-line"></i></span>
        <span class="text-white font-semibold mr-2 text-left flex-auto">${message}</span>
    </div>`;
    copyAlert.classList.remove("invisible");
    copyAlert.classList.add("transition", "duration-2000", "ease-in-out", "opacity-0");

    window.setTimeout(function () {
        copyAlert.innerHTML = "";
        copyAlert.classList.add("invisible");
        copyAlert.classList.remove("transition", "duration-2000", "ease-in-out", "opacity-0");
    }, 2000);
}

function copyURLToClipboard(hook, event) {
    const shortLinkItem = event.target;

    if (document.getElementById("copy-toast")) {
        showToast("Copied to clipboard");
    }

    if (shortLinkItem) {
        var URL = shortLinkItem.getAttribute("data-element-id");
        if (URL) {
            copy(URL);
        }
    }
}

function cancelEvent(event) {
    // Cancel any default browser behavior.
    event.preventDefault();
    // Stop event propagation (e.g. so it doesn't reach the editor).
    event.stopPropagation();
}

export default ShortLink;