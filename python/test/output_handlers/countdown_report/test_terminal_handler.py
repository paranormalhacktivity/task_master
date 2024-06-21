import pytest

class TaskMaster:
    def foo():
        "hello world"

    def __bool__(self):
        return True


def test_foo():
    assert not TaskMaster()
