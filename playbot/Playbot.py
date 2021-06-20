"""Playbot provides very basic operations/keywords
by playwright/python library to the robotframework.
"""

from typing import Union

from playwright.sync_api import Browser, BrowserContext, sync_playwright
from robot.api.deco import keyword, library

from playbot.src.context import PlaybotContext


@library
class Playbot:
    """Represents the library for robot framework.

    Import is done like this:

    >>> ***Settings***
    >>> Library    ${EXECDIR}${/}playbot${/}Playbot.py     browser=<chromium|firefox|webkit>

    Playwright under the hood accepts a lot of `kwargs` to keywords. In case some of the values
    are booleans, you have to explicitly convert them using RF `Convert to boolean` keyword.
    You can do it like this:

    >>> ***Variables***
    >>> ${TRUE}     Convert to boolean=True
    >>> ${FALSE}    Convert to boolean=False


    """

    ROBOT_LIBRARY_SCOPE = "SUITE"

    def __init__(self, browser: str = "chromium"):
        """Instantiates the class.

        Args:
            browser (str, optional): Which browser should playwright start. Defaults to "chromium".
        """
        self._selected_browser: str = browser
        self._browser: Union[None, Browser] = None

    def _start_browser(self, browser: str, **kwargs):
        if browser == "chromium":
            self._browser = sync_playwright().start().chromium.launch(**kwargs)

        elif browser == "firefox":
            self._browser = sync_playwright().start().firefox.launch(**kwargs)

        elif browser == "webkit":
            self._browser = sync_playwright().start().webkit.launch(**kwargs)

        else:
            raise RuntimeError(
                "You have to select either 'chromium', 'firefox', or 'webkit' as browser."
            )

    def _close_browser(self):
        self._browser.close()

    def _start_context(self, **kwargs):
        return PlaybotContext(self._browser, **kwargs)

    # public

    @keyword
    def start_browser(self, **kwargs):
        """Starts the browser. Type of the browser is provided
        when importing the library.
        """
        self._start_browser(self._selected_browser, **kwargs)

    @keyword
    def new_context(self, **kwargs) -> BrowserContext:
        """Starts new context of the browser.

        Returns:
            BrowserContext (object): Instance of the browser context.
        """
        return self._start_context(**kwargs)

    @keyword
    def close_browser(self):
        """Closes all the pages, contexts of the browser and
        the browser itself.
        """
        self._close_browser()
