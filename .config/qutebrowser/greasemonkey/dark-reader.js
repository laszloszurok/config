// ==UserScript==
// @name          Dark Reader (Unofficial)
// @icon          https://darkreader.org/images/darkreader-icon-256x256.png
// @namespace     DarkReader
// @description	  Inverts the brightness of pages to reduce eye strain
// @version       4.7.15
// @author        https://github.com/darkreader/darkreader#contributors
// @homepageURL   https://darkreader.org/ | https://github.com/darkreader/darkreader
// @run-at        document-end
// @grant         none
// @include       http*
// @require       https://cdn.jsdelivr.net/npm/darkreader/darkreader.min.js
// @noframes
// ==/UserScript==

/**
 * Creates a RegExp from the given string, converting asterisks to .* expressions,
 * and escaping all other characters.
 */
function wildcardToRegExp(s) {
    return new RegExp('^' + s.split(/\*+/).map(regExpEscape).join('.*') + '$');
}

/**
 * RegExp-escapes all characters in the given string.
 */
function regExpEscape(s) {
    return s.replace(/[|\\{}()[\]^$+*?.]/g, '\\$&');
}

DarkReader.enable({
    brightness: 100,
    contrast: 100,
    sepia: 0
});

url = window.location.href

if (url.match(wildcardToRegExp("*://odysee.com/*"))
    || url.match(wildcardToRegExp("*://github.com/*"))
    || url.match(wildcardToRegExp("*://searx.envs.net/*"))
    || url.match(wildcardToRegExp("*://libredd.it/*"))
    || url.match(wildcardToRegExp("*://www.youtube.com/*"))
) {
    DarkReader.disable();
}
