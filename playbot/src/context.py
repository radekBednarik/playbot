'''Implements Playwright's browser's Context.
'''

from playbot.src.page import PlaybotPage
from playwright.sync_api import Browser, BrowserContext, Page
from robot.api.deco import keyword


class PlaybotContext:
    def __init__(self, browser_type_instance: Browser, **kwargs):
        self._browser_type_instance = browser_type_instance
        self.context = self._start_context(**kwargs)

    def _start_context(self, **kwargs):
        return self._browser_type_instance.new_context(**kwargs)

    def _start_page(self, context: BrowserContext, **kwargs):
        return PlaybotPage(context, **kwargs)

    @keyword
    def new_page(self, context: BrowserContext, **kwargs) -> Page:
        """Starts new page of the context.

        Returns:
            Page (object): Instance of the browser context page.
        """
        return self._start_page(context, **kwargs)
