'''Implements Playwright's Page.
'''

from playwright.sync_api import BrowserContext, Page


class PlaybotPage:
    def __init__(self, browser_context: BrowserContext, **kwargs):
        self._browser_context: BrowserContext = browser_context
        self.page = self._start_page(**kwargs)

    def _start_page(self, **kwargs):
        return self._browser_context.new_page(**kwargs)

    @staticmethod
    def go_to(page: Page, url: str, **kwargs):
        return page.goto(url, **kwargs)

    @staticmethod
    def wait_for_timeout(page: Page, timeout: float):
        page.wait_for_timeout(timeout)
