"""Playbot provides very basic operations/keywords
by playwright/python library to the robotframework.
"""
from typing import Union

from playwright.sync_api import Browser, BrowserContext, Page, sync_playwright
from robot.api.deco import keyword, library


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
        self.selected_browser = browser
        self.browser = Union[None, Browser]
        self.context = Union[None, BrowserContext]
        self.page = Union[None, Page]

    def _start_browser(self, browser: str, **kwargs):
        if browser == "chromium":
            self.browser = sync_playwright().start().chromium.launch(**kwargs)

        elif browser == "firefox":
            self.browser = sync_playwright().start().firefox.launch(**kwargs)

        elif browser == "webkit":
            self.browser = sync_playwright().start().webkit.launch(**kwargs)

        else:
            raise RuntimeError(
                "You have to select either 'chromium', 'firefox', or 'webkit' as browser."
            )

    def _close_browser(self):
        self.browser.close()

    def _start_context(self, **kwargs):
        self.context = self.browser.new_context(**kwargs)
        return self.context

    def _start_page(self, **kwargs):
        self.page = self.context.new_page(**kwargs)
        return self.page

    # public

    @keyword
    def start_browser(self, **kwargs):
        """Starts the browser. Type of the browser is provided
        when importing the library.
        """
        self._start_browser(self.selected_browser, **kwargs)

    @keyword
    def new_context(self, **kwargs):
        """Starts new context of the browser."""
        self._start_context(**kwargs)

    @keyword
    def new_page(self, **kwargs):
        """Starts new page of the context."""
        self._start_page(**kwargs)

    @keyword
    def close(self):
        """Closes all the pages, contexts of the browser and
        the browser itself.
        """
        self._close_browser()
