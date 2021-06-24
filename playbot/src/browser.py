'''Implements Playwright's Browser.
'''

from playwright.sync_api import Browser, sync_playwright


class PlaybotBrowser:
    def __init__(self, browser: str = "chromium", **kwargs):
        self.browser = self._start_browser(browser, **kwargs)

    def _start_browser(self, browser: str, **kwargs):
        if browser == "chromium":
            return sync_playwright().start().chromium.launch(**kwargs)

        elif browser == "firefox":
            return sync_playwright().start().firefox.launch(**kwargs)

        elif browser == "webkit":
            return sync_playwright().start().webkit.launch(**kwargs)

        else:
            raise RuntimeError(
                "You have to select either 'chromium', 'firefox', or 'webkit' as browser."
            )

    @staticmethod
    def close_browser(browser: Browser):
        return browser.close()
