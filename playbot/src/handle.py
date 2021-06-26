'''Implements methods shared by Page and ElementHandle classes.
'''


class Handle:
    def __init__(self) -> None:
        pass

    def query_selector(self, selector: str):
        pass

    def wait_for_selector(self, selector: str, **kwargs):
        pass
