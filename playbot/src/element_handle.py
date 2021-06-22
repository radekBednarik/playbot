'''Implements Playwright's Element Handle.
'''

from playwright.sync_api import ElementHandle, Page


class PlaybotElementHandle:
    def __init__(self, page: Page, selector: str):
        self._page: Page = page
        self.element_handle = self._query_selector(selector)

    def _query_selector(self, selector: str):
        return self._page.query_selector(selector)

    @staticmethod
    def is_visible(element_handle: ElementHandle):
        return element_handle.is_visible()
