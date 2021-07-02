"""Utility keywords for RF tests.
"""

from typing import Any, Literal
from robot.api.deco import library, keyword


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
            "str", "int", "float", "list", "dict", "tuple", "set", "frozenset", "None"
        ],
    ):
        """Check if an object is an instance of a built-in type.

        Arguments:
        obj -- object to check
        type_ -- class to check against
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

        raise Exception("Invalid type")
