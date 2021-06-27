import copy from 'copy-to-clipboard';

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
    }

    return;
}

function copyURLToClipboard(hook, event) {
    const shortLinkItem = event.target;
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