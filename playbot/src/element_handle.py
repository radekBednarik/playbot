'''Implements Playwright's Element Handle.
'''

from typing import Union

from playwright.sync_api import ElementHandle, Page


class PlaybotElementHandle:
    def __init__(self, handle: Union[Page, ElementHandle], selector: str):
        self._handle: Union[Page, ElementHandle] = handle
        self.element_handle = self._query_self(selector)

    def _query_self(self, selector: str):
        return self._handle.query_selector(selector)

    @staticmethod
    def is_visible(element_handle: ElementHandle):
        return element_handle.is_visible()

    @staticmethod
    def is_hidden(element_handle: ElementHandle):
        return element_handle.is_hidden()
