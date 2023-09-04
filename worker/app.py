"""
Celery app declaration.

Update from Sept 4 meeting: considerations for using dramatiq over celeryq. 
Documentation here https://dramatiq.io, supports a GUI that is also very helpful https://github.com/Bogdanp/dramatiq_dashboard. 
Basically a more updated version of celeryq that also supports task prioritization.
"""

import argparse

from celery import Celery

app = Celery("worker", broker="pyamqp://guest@localhost//")
