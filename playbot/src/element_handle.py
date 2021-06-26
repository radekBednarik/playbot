'''Implements Playwright's Element Handle.
'''


from playwright.sync_api import ElementHandle

from playbot.src.handle import Handle


class PlaybotElementHandle(Handle):
    def __init__(self, handle: ElementHandle):
        self._handle: ElementHandle = handle
        super().__init__(self._handle)
