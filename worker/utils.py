"""
Misc utils.
"""

from wrapper import RunConfig

FAST_METHODS = (
    "nerfacto",
    "instant-ngp",
)
MAX_ITERS = 10000


def verify_config(config: RunConfig) -> None | str:
    """
    Verify that the config is valid.

    If invalid, return a string describing the error.
    Otherwise, return None.
    """
    # Make sure method is fast; don't want to clog resources.
    if config.method not in FAST_METHODS:
        return f"method {config.method} is not fast enough."

    # Sane number of iterations.
    if config.iters > MAX_ITERS:
        return f"iters {config.iters} is too high."

    return None
