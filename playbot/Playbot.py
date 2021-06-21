"""Playbot provides very basic operations/keywords
by playwright/python library to the robotframework.
"""

from typing import Union

from playwright.sync_api import Browser
from robot.api.deco import keyword, library

from playbot.src.browser import PlaybotBrowser
from playbot.src.context import PlaybotContext
from playbot.src.page import PlaybotPage


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
        self._selected_browser: str = browser
        self._playbot_browser: Union[None, Browser] = None

    @keyword
    def start_browser(self, **kwargs):
        self._playbot_browser = PlaybotBrowser(self._selected_browser, **kwargs)

    @keyword
    def new_context(self, **kwargs):
        return PlaybotContext(self._playbot_browser.browser, **kwargs)

    @keyword
    def new_page(self, playbot_context: PlaybotContext, **kwargs):
        return PlaybotPage(playbot_context.context, **kwargs)

    @keyword
    def go_to(self, browser_page: PlaybotPage, url: str, **kwargs):
        return browser_page.go_to(browser_page.page, url, **kwargs)

    @keyword
    def close_browser(self):
        self._playbot_browser.close_browser(self._playbot_browser.browser)
