"""Utility keywords for RF tests.
"""

from typing import Any, Literal

from playwbot.src.context import PlaywbotContext
from playwbot.src.page import PlaywbotPage
from playwright.sync_api import Request
from robot.api.deco import keyword, library


@library(scope="GLOBAL")
class TestUtils:
    """Test utils keyword library."""

    def __init__(self):
        pass

    @keyword
    def is_type(
        self,
        obj: Any,
        type_: Literal[
            "str",
            "int",
            "float",
            "list",
            "dict",
            "tuple",
            "set",
            "frozenset",
            "None",
            "request",
            "playwbotPage",
            "playwbotContext",
        ],
    ):
        """Checks, if `obj` is of given `type`.

        Args:
            obj (Any): object to check
            type_ (Literal): literal of type to check against, e.g. "str", "int", "float", ...

        Raises:
            Exception: "Invalid type" , if `type_` is not one of the supported types

        Returns:
            bool: `true` if `obj` is of given `type`, else `false`.
        """
        if type_ == "None":
            return obj is None
        if type_ == "str":
            return isinstance(obj, str)
        if type_ == "int":
            return isinstance(obj, int)
        if type_ == "float":
            return isinstance(obj, float)
        if type_ == "list":
            return isinstance(obj, list)
        if type_ == "dict":
            return isinstance(obj, dict)
        if type_ == "tuple":
            return isinstance(obj, tuple)
        if type_ == "set":
            return isinstance(obj, set)
        if type_ == "frozenset":
            return isinstance(obj, frozenset)
        if type_ == "request":
            return isinstance(obj, Request)
        if type_ == "playwbotPage":
            return isinstance(obj, PlaywbotPage)
        if type_ == "playwbotContext":
            return isinstance(obj, PlaywbotContext)

        raise Exception("Invalid type")
