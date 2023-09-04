"""
NerfNet State Machine class, developed as part of GSoC 2023 with OpenCV.

This state machine class is responsible for managing the state of a singular
job submitted to NeRFNet. It is responsible for managing the state of the
job, and for communicating with the user through the Firebase API.
"""


import os
import warnings
import json
from wandb.sdk.lib.runid import generate_id
from pathlib import Path
from comms import FirebaseComms


_SUBMITTED_JOBS = []


class NerfNetStateMachine():
    def __init__(self):
        self._init_job_id()
        self.state = "queued"

    def _init_job_id(self):
        """Assign a unique job ID to this job."""
        while True:
            self.job_id = generate_id(length=8)
            if self.job_id not in _SUBMITTED_JOBS:
                _SUBMITTED_JOBS.append(self.job_id)
                break

    def extract_metadata(self, file: str, _format: str = "nerfstudio"):
        file = Path(os.path.abspath(file))
        if _format == "nerfstudio":
            # nerfstudio's ns-process-data command outputs a transforms.json file in the
            # same directory level as the images folders
            data = json.loads(file)
            cam_metadata = {
                # image dimensions in pixels
                "width": data["w"],
                "height": data["h"],

                # intrinsic parameters - focal length and principal point
                "fx": data["fl_x"],
                "fy": data["fl_y"],
                "cx": data["cx"],
                "cy": data["cy"],

                # distortion parameters
                "k1": data["k1"],
                "k2": data["k2"],
                "p1": data["p1"],
                "p2": data["p2"],
            }
            return cam_metadata

    def get_state(self):
        return self.state

    def set_state(self, state: str):
        if state not in ["queued", "running", "stopped", "error"]:
            warnings.warn(f"Invalid state provided: {state}")
            return
        self.state = state

    def _finish(self):
        _SUBMITTED_JOBS.remove(self.job_id)
        del self
