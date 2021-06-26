'''Implements methods shared by Page and ElementHandle classes.
'''


from typing import Union
from playwright.sync_api import Page, ElementHandle


class Handle:
    def __init__(self, handle: Union[Page, ElementHandle]) -> None:
        self.handle: Union[Page, ElementHandle] = handle

    def is_visible(
        self, selector: Union[str, None] = None, timeout: Union[float, None] = None
    ):
        if isinstance(self.handle, Page) and selector is not None:
            return self.handle.is_visible(selector, timeout=timeout)

        if (
            isinstance(self.handle, ElementHandle)
            and selector is None
            and timeout is None
        ):
            return self.handle.is_visible()

    def query_selector(self, selector: str):
        return self.handle.query_selector(selector)

    def wait_for_selector(self, selector: str, **kwargs):
        return self.handle.wait_for_selector(selector, **kwargs)
