const ShortLink = {
    mounted() {
        console.log("has been mounted");
        this.state = {

        };

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
    // If clock targets a clickable element that awaits mouse up, keep the focus as is
    if (event.target.closest(`a, button`)) {
        // if the Copy button is clocked, copy URL to clipboard
        if (event.target.closest(`[data-element="copy-url-to-clipboard"]`)) {
            copyURLToClipboard(hook, event);
        }
    }

    return;
}

function copyURLToClipboard(hook, event) {
    const shortLinkItem = event.target;
    if (shortLinkItem) {
        const URL = shortLinkItem.getAttribute("data-element-id");
        console.log(URL);
    }
    
}

function cancelEvent(event) {
    // Cancel any default browser behavior.
    event.preventDefault();
    // Stop event propagation (e.g. so it doesn't reach the editor).
    event.stopPropagation();
}

export default ShortLink;