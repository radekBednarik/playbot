'''Implements Playwright's Element Handle.
'''

from typing import Union

from playwright.sync_api import ElementHandle, Page


class PlaybotElementHandle:
    def __init__(self, handle: Union[Page, ElementHandle]):
        self._handle: Union[Page, ElementHandle] = handle
