from typing import Callable
from playwright.sync_api import sync_playwright
from robot.api.deco import keyword, library


@library
class Playbot:
    ROBOT_LIBRARY_SCOPE = "SUITE"

    def __init__(self, browser: str = "chromium", **kwargs):
        self._start_browser(browser, **kwargs)
        self.context = None
        self.page = None

    # browser instance is started when library is imported
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
    def new_context(self, **kwargs):
        self._start_context(**kwargs)

    @keyword
    def new_page(self, **kwargs):
        self._start_page(**kwargs)

    @keyword
    def close(self):
        self._close_browser()
