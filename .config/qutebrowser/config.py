import redirectors

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Allow websites to read canvas elements. Note this is needed for some
# websites to work properly.
# Type: Bool
c.content.canvas_reading = False

# Custom stylesheet
c.content.user_stylesheets = ['user.css']

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
c.content.cookies.accept = 'never'

# Editor
c.editor.command = [ 'st', '-e', 'nvr', '{}' ]

config.set('content.cookies.accept', 'all', '*://piped.kavin.rocks/*')
config.set('content.cookies.accept', 'all', '*://www.youtube.com/*')
config.set('content.cookies.accept', 'all', '*://libredd.it/*')
config.set('content.cookies.accept', 'all', '*://odysee.com/*')
config.set('content.cookies.accept', 'all', '*://rarbg.to/*')
config.set('content.cookies.accept', 'all', '*://searx.envs.net/*')
config.set('content.cookies.accept', 'all', '*://github.com/*')
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
c.content.javascript.enabled = False
config.set('content.javascript.enabled', True, '*://www.youtube.com/*')
config.set('content.javascript.enabled', True, '*://odysee.com/*')
config.set('content.javascript.enabled', True, '*://rarbg.to/*')
config.set('content.javascript.enabled', True, '*://searx.envs.net/*')
config.set('content.javascript.enabled', True, '*://github.com/*')
config.set('content.javascript.enabled', True, '*.wikipedia.org/*')
config.set('content.javascript.enabled', True, '*://*.en.wikipedia.org/*')
config.set('content.javascript.enabled', True, 'https://fontawesome.com/v5/cheatsheet')
config.set('content.javascript.enabled', True, '*://piped.kavin.rocks/*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications.enabled', False, 'https://www.reddit.com')

# Allow websites to register protocol handlers via
# `navigator.registerProtocolHandler`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.register_protocol_handler', False, 'https://mail.google.com?extsrc=mailto&url=%25s')

# Enable WebGL.
# Type: Bool
c.content.webgl = True

# Which interfaces to expose via WebRTC.
# Type: String
# Valid values:
#   - all-interfaces: WebRTC has the right to enumerate all interfaces and bind them to discover public interfaces.
#   - default-public-and-private-interfaces: WebRTC should only use the default route used by http. This also exposes the associated default private address. Default route is the route chosen by the OS on a multi-homed endpoint.
#   - default-public-interface-only: WebRTC should only use the default route used by http. This doesn't expose any local addresses.
#   - disable-non-proxied-udp: WebRTC should only use TCP to contact peers or servers unless the proxy server supports UDP. This doesn't expose any local addresses either.
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'

# When to show the scrollbar
c.scrolling.bar = 'always'

# Padding (in pixels) for the statusbar.
# Type: Padding
c.statusbar.padding = {'bottom': 5, 'left': 0, 'right': 5, 'top': 5}

# When to show favicons in the tab bar.
# Type: String
# Valid values:
#   - always: Always show favicons.
#   - never: Always hide favicons.
#   - pinned: Show favicons only on pinned tabs.
c.tabs.favicons.show = 'never'

# Padding (in pixels) around text for tabs.
# Type: Padding
c.tabs.padding = {'bottom': 5, 'left': 5, 'right': 5, 'top': 5}

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

# Padding (in pixels) for tab indicators.
# Type: Padding
c.tabs.indicator.padding = {'bottom': 2, 'left': 0, 'right': 4, 'top': 2}

# Focus the tab on the left when the active tab is closed
c.tabs.select_on_remove = 'prev'

# Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
# for a blank page.
# Type: FuzzyUrl
c.url.default_page = 'searx.envs.net'

# Search engines which can be used via the address bar.  Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` braces.  The following further
# placeholds are defined to configure how special characters in the
# search terms are replaced by safe characters (called 'quoting'):  *
# `{}` and `{semiquoted}` quote everything except slashes; this is the
# most   sensible choice for almost all search engines (for the search
# term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
# * `{quoted}` quotes all characters (for `slash/and&amp` this
# placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
# nothing (for `slash/and&amp` this placeholder   expands to
# `slash/and&amp`). * `{0}` means the same as `{}`, but can be used
# multiple times.  The search engine named `DEFAULT` is used when
# `url.auto_search` is turned on and something else than a URL was
# entered to be opened. Other search engines can be used by prepending
# the search engine name to the search term, e.g. `:open google
# qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': ' https://searx.envs.net/search?q={}'}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = 'https://searx.envs.net'

# Colors
c.colors.completion.odd.bg = '#191b28'
c.colors.completion.even.bg = '#191b28'
c.colors.completion.category.bg = 'black'
c.colors.completion.category.border.top = 'black'
c.colors.completion.item.selected.fg = '#e0dbd2'
c.colors.completion.item.selected.bg = '#563d7c'
c.colors.completion.item.selected.border.top = '#563d7c'
c.colors.completion.item.selected.border.bottom = '#563d7c'
c.colors.statusbar.private.bg = 'darkslategray'
c.colors.statusbar.command.private.bg = 'darkslategray'
c.colors.tabs.bar.bg = '#444444'
c.colors.tabs.odd.bg = '#444444'
c.colors.tabs.even.fg = 'white'
c.colors.tabs.even.bg = '#555555'
c.colors.tabs.selected.odd.bg = '#563d7c'
c.colors.tabs.selected.even.bg = '#563d7c'
c.colors.webpage.bg = 'white' # Background color for webpages if unset (or empty to use the theme's color)


# height of the completion window
c.completion.height = '40%'

# Scrollbar with in the completion window
c.completion.scrollbar.width = 8

# Render all web contents using a dark theme.
# Type: Bool
c.colors.webpage.darkmode.enabled = True

# Default font size to use. Whenever "default_size" is used in a font
# setting, it's replaced with the size listed here. Valid values are
# either a float value with a "pt" suffix, or an integer value with a
# "px" suffix.
# Type: String
c.fonts.default_size = '10.5pt'

# Bindings for normal mode
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('tj', 'config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload')
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('zz', 'zoom')
config.bind('j', 'scroll-px 0 30')
config.bind('k', 'scroll-px 0 -30')

c.aliases = {
    "mpv": "spawn --userscript open-in-mpv",
}
