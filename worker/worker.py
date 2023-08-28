"""
Utils for handling data and file structure.

File structure:
/tmp/NerfNetWorker
|__ dataset0    # Some unique ID.
    |__ raw_data    # Raw user data as images.
        |__ 0.jpg
        |__ 1.jpg
        ...
    |__ colmap_data    # Output of ns-process-data
        ...
    |__ nerfs
        |__ nerf0    # Some unique nerf name.
            ...    # Selected files from output of ns-train
    |__ status.json    # Metadata or status.
|__ dataset0.tar.gz    # Created on demand.
|__ dataset0.nerf0    # ns-train working directory.
    ...    # Output of ns-train
...

Each individual dataset (e.g. `run0`) is stored in our database as a `tar.gz`.

The workflow on our backend server is:
- Receive request to do something
- Pull existing dataset from database
- Unpack dataset tarball
- Do something
- Repack dataset tarball
- Push dataset to database
"""

import json
import shutil
from dataclasses import dataclass
from pathlib import Path
from subprocess import check_call
from typing import Generator

import cv2

STANDARD_RES = 400
TMP_DIR = Path("/tmp/NerfNetWorker")


@dataclass
class RunConfig:
    """
    Configuration for a run request.
    """
    method: str
    """Method to use for training (e.g. nerfacto)."""
    iters: int = 10000
    """Number of iterations to train for."""


class NerfRun:
    """
    This class represents one nerf run; e.g. `nerf0`.

    Each NerfRun can only have one actual ns-train run;
    if you do multiple, the previous one will be overwritten.

    For multiple runs, create multiple NerfRuns.

    See file structure above.
    """
    parent: "Dataset"

    def __init__(self, id: str, parent: "Dataset", config: RunConfig):
        self.id = id
        self.parent = parent
        self.config = config

        self.ds_path = parent.path / "nerfs" / id
        """Path inside the dataset"""
        self.tmp_path = parent.tmpdir / f"{parent.id}.{id}"
        """Path inside the tmpdir"""

        self.ds_path.mkdir(parents=True, exist_ok=True)
        self.tmp_path.mkdir(parents=True, exist_ok=True)

    @property
    def results_path(self) -> Path:
        return self.tmp_path / "outputs" / "NerfNetWorker" / self.config.method / "0"

    def run(self):
        check_call([
            "ns-train",
            self.config.method,
            "--experiment-name", "NerfNetWorker",
            "--timestamp", "0",
            "--max-num-iterations", str(self.config.iters),
            "--vis", "tensorboard",
            "nerfstudio-data", "--data", self.parent.colmap_data_path.absolute(),
        ], cwd=self.tmp_path)

    def copy_tmp_to_ds(self):
        """
        Copy from tmp working dir (e.g. `dataset0.nerf0/*`)
        to dataset (e.g. `dataset0/nerfs/nerf0`).
        Also serializes RunConfig.
        """
        ns_config = self.results_path / "config.yml"
        model = next((self.results_path / "nerfstudio_models").iterdir())
        shutil.copy(ns_config, self.ds_path / "ns_config.yml")
        shutil.copy(model, self.ds_path / "model.ckpt")
        (self.ds_path / "config.json").write_text(json.dumps(self.config.__dict__, indent=4))


class Dataset:
    """
    This class represents one dataset; e.g. `dataset0`.

    See file structure above.

    This class doesn't guarantee that data exists;
    it takes in a directory, and if you query for data,
    it assumes the data exists.

    E.g. if you request to run colmap on raw data,
    it will run regardless if the data is there, if it has already been run, etc.
    """

    def __init__(self, id: str, tmpdir: Path = TMP_DIR):
        self.id = id
        self.tmpdir = tmpdir
        self.path = tmpdir / id

        self.path.mkdir(parents=True, exist_ok=True)

    @property
    def raw_data_path(self) -> Path:
        return self.path / "raw_data"

    @property
    def colmap_data_path(self) -> Path:
        return self.path / "colmap_data"

    @property
    def runs_path(self) -> Path:
        return self.path / "runs"

    def iter_run_paths(self) -> Generator[Path, None, None]:
        yield from self.runs_path.iterdir()

    def get_run(self, id: str, config: RunConfig) -> NerfRun:
        return NerfRun(id, self, config)

    def read_status(self):
        return json.loads((self.path / "status.json").read_text())

    def write_status(self, status):
        (self.path / "status.json").write_text(json.dumps(status, indent=4))

    def rescale_images(self, res: int = STANDARD_RES):
        """
        Uses cv2 to rescale all raw images.
        Largest side will become `res`.
        """
        for file in self.raw_data_path.iterdir():
            img = cv2.imread(str(file))
            h, w = img.shape[:2]
            if h > w:
                new_h = res
                new_w = int(res * w / h)
            else:
                new_w = res
                new_h = int(res * h / w)
            img = cv2.resize(img, (new_w, new_h))
            cv2.imwrite(str(file), img)

    def run_colmap(self):
        """
        Runs ns-process-data on `raw_data`, saving output to `colmap_data`.
        """
        check_call([
            "ns-process-data",
            "images",
            "--data", self.path / "raw_data",
            "--output-dir", self.path / "colmap_data",
        ], cwd=self.path)

    def make_tar(self) -> Path:
        """
        Create tarball of this dataset.
        Runs `tar`; this isn't a fast operation, so don't use it too often.
        """
        check_call([
            "tar",
            "-czf",
            self.tmpdir / f"{self.id}.tar.gz",
            self.id,
        ], cwd=self.tmpdir)
        tar_path = self.tmpdir / f"{self.id}.tar.gz"
        assert tar_path.exists()

        return tar_path
