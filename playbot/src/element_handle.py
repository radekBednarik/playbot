'''Implements Playwright's Element Handle.
'''

from typing import Union

from playwright.sync_api import ElementHandle, Page

from playbot.src.handle import Handle


class PlaybotElementHandle(Handle):
    def __init__(self, handle: Union[Page, ElementHandle]):
        self._handle: Union[Page, ElementHandle] = handle
        super().__init__(self._handle)
