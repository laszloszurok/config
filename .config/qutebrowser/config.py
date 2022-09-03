import operator

from qutebrowser.api import interceptor, message

# general settings
config.load_autoconfig(False)
c.auto_save.session = True
c.completion.height = '40%'
c.completion.scrollbar.width = 8
c.content.autoplay = False
c.content.user_stylesheets = ['user.css']
c.content.notifications.enabled = False
c.downloads.position = 'bottom'
c.downloads.remove_finished = 3000
c.editor.command = [ 'st', '-e', 'nvr', '{}' ]
c.fonts.default_size = '10.5pt'
c.input.insert_mode.auto_load = False
c.url.default_page = 'about:blank'
c.url.start_pages = 'about:blank'
c.scrolling.bar = 'always'
c.statusbar.padding = {'bottom': 5, 'left': 0, 'right': 5, 'top': 5}
c.tabs.padding = {'bottom': 5, 'left': 5, 'right': 5, 'top': 5}
c.tabs.indicator.padding = {'bottom': 2, 'left': 0, 'right': 4, 'top': 2}
c.tabs.indicator.width = 0
c.tabs.favicons.show = 'never'
c.tabs.select_on_remove = 'prev'
c.content.blocking.method = "both"

# fingerprinting
c.content.webgl = False
c.content.canvas_reading = False
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'

# bindings
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('zz', 'zoom')
config.bind('j', 'scroll-px 0 30')
config.bind('k', 'scroll-px 0 -30')
config.bind('<Ctrl-r>', 'config-source ;; message-info "configuration reloaded"')
config.bind('<Ctrl-Shift-r>', 'restart')
config.bind('<Ctrl-Right>', 'tab-move +')
config.bind('<Ctrl-Left>', 'tab-move -')

# unbind keys
config.unbind('m')
config.unbind('M')
config.unbind('b')
config.unbind('B')
config.unbind('wb')
config.unbind('gb')
config.unbind('gB')
config.unbind('wB')

# aliases
c.aliases = {
    "mpv": "spawn --userscript open-in-mpv",
    "bookmark": "spawn --userscript bookmark-page"
}

# search engines
c.url.searchengines = { 
        #'DEFAULT': 'https://paulgo.io/search?q={}',
        'DEFAULT': 'http://localhost:8080/search?q={}',
        'searxng': 'http://localhost:8080/search?q={}',
        'duckduckgo': 'https://duckduckgo.com/?q={}',
        'google': 'https://www.google.com/search?hl=en&q={}',
        'archwiki': 'https://wiki.archlinux.org/?search={}',
        'aur': 'https://aur.archlinux.org/packages?K={}',
        'github': 'https://github.com/search?q={}',
        'wikipedia': 'https://wikiless.org/?search={}',
}

# cookies
c.content.cookies.accept = 'no-3rdparty'

# colors
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.bg = 'black'
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

# redirect given sites to other urls
REDIRECT_MAP = {
    "wikipedia.org": operator.methodcaller('setHost', 'wikiless.org'),
    "en.wikipedia.org": operator.methodcaller('setHost', 'wikiless.org'),
    "www.wikipedia.org": operator.methodcaller('setHost', 'wikiless.org'),
    "medium.com": operator.methodcaller('setHost', 'scribe.rip'),
    "youtube.com": operator.methodcaller('setHost', 'piped.kavin.rocks'),
    "www.youtube.com": operator.methodcaller('setHost', 'piped.kavin.rocks'),
    "youtu.be": operator.methodcaller('setHost', 'piped.kavin.rocks'),
    "reddit.com": operator.methodcaller('setHost', 'libreddit.kavin.rocks'),
    "www.reddit.com": operator.methodcaller('setHost', 'libreddit.kavin.rocks'),
    "instagram.com": operator.methodcaller('setHost', 'bibliogram.art'),
    "www.instagram.com": operator.methodcaller('setHost', 'bibliogram.art'),
    "twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.imgur.com": operator.methodcaller('setHost', 'rimgo.pussthecat.org'),
    "imgur.com": operator.methodcaller('setHost', 'rimgo.pussthecat.org'),
    "i.imgur.com": operator.methodcaller('setHost', 'rimgo.pussthecat.org'),
    # "www.odysee.com": operator.methodcaller('setHost', 'librarian.pussthecat.org'),
    # "odysee.com": operator.methodcaller('setHost', 'librarian.pussthecat.org'),
}

def int_fn(info: interceptor.Request):
    """Block the given request if necessary."""
    if (info.resource_type != interceptor.ResourceType.main_frame or
            info.request_url.scheme() in {"data", "blob"}):
        return
    url = info.request_url
    redir = REDIRECT_MAP.get(url.host())
    if redir is not None and redir(url) is not False:
        message.info("Redirecting to " + url.toString())
        info.redirect(url)


interceptor.register(int_fn)
