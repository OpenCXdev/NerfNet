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
...

Each individual dataset (e.g. `run0`) is stored in our database as a `tar.gz`.
"""

import json
from pathlib import Path
from subprocess import check_call

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
