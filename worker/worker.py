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
            ...    # Output of ns-train
    |__ status.json    # Metadata or status.
|__ dataset0.tar.gz    # Created on demand.
...

Each individual dataset (e.g. `run0`) is stored in our database as a `tar.gz`.
"""

import cv2
import json
from pathlib import Path
from subprocess import check_call

STANDARD_RES = 400
TMP_DIR = Path("/tmp/NerfNetWorker")


class Dataset:
    """
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
    def raw_data_path(self):
        return self.path / "raw_data"

    @property
    def colmap_data_path(self):
        return self.path / "colmap_data"

    @property
    def nerfs_path(self):
        return self.path / "nerfs"

    def iter_nerfs(self):
        yield from self.nerfs_path.iterdir()

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
