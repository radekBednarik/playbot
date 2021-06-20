'''Implements Playwright's Page.
'''

from typing import Optional

from playwright.sync_api import BrowserContext, Page, Response
from robot.api.deco import keyword


class PlaybotPage:
    def __init__(self, browser_context: BrowserContext, **kwargs):
        self._browser_context: BrowserContext = browser_context
        self._start_page(**kwargs)

    def _start_page(self, **kwargs):
        return self._browser_context.new_page(**kwargs)

    def _goto(self, page: Page, url: str, **kwargs):
        return page.goto(url, **kwargs)

    @keyword
    def go_to(self, page: Page, url: str, **kwargs) -> Optional[Response]:
        """Navigates to given url. Returns the response.

        Args:
            page (Page): instance of the Context Page
            url (str): url to navigate to

        Returns:
            Optional[Response]: Response object of the last redirect of the navigation
        """
        return self._goto(page, url, **kwargs)
