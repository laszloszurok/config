
import operator, typing

from qutebrowser.api import interceptor, message

# Any return value other than a literal 'False' means we redirected
REDIRECT_MAP = {
    # "youtube.com": operator.methodcaller('setHost', 'piped.kavin.rocks'),
    # "www.youtube.com": operator.methodcaller('setHost', 'piped.kavin.rocks'),
    "reddit.com": operator.methodcaller('setHost', 'libredd.it'),
    "www.reddit.com": operator.methodcaller('setHost', 'libredd.it'),
    "instagram.com": operator.methodcaller('setHost', 'bibliogram.art'),
    "www.instagram.com": operator.methodcaller('setHost', 'bibliogram.art'),
    "twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.twitter.com": operator.methodcaller('setHost', 'nitter.net'),
} # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]

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
