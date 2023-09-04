"""
Celery app declaration.
"""

import argparse

from celery import Celery

app = Celery("worker", broker="pyamqp://guest@localhost//")
