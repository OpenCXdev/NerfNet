"""
Handles opening subprocesses to train requested Nerfs.
"""

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from subprocess import check_call, Popen

ROOT = Path(__file__).parent


@dataclass
class RunConfig:
    """
    Configuration for a run request.
    """
    raw_data: Path
    """Path to raw data.
    If folder, assumes it contains images.
    If file, assumes it's a video."""
    method: str
    """Method to use for training (e.g. nerfacto)."""
    iters: int = 10000
    """Number of iterations to train for."""


@dataclass
class RunResult:
    """
    Result of a run request.
    """
    id: int
    """ID of this run."""
    proc_data: Path
    """Path to processed data folder."""
    results: Path
    """Path to results folder."""
    model: Path
    """Path to final model weights file."""


class Runner:
    def __init__(self):
        self.data = ROOT / "data"
        self.outputs = ROOT / "outputs"
        self.log = ROOT / "log"
        self.data.mkdir(exist_ok=True)
        self.outputs.mkdir(exist_ok=True)
        self.log.mkdir(exist_ok=True)

    def get_new_id(self) -> int:
        """
        Returns 1 more than highest ID present in log dir.
        """
        highest = -1
        for f in self.log.iterdir():
            if f.stem.isdigit():
                highest = max(highest, int(f.stem))
        return highest + 1

    def do_run(self, config: RunConfig) -> RunResult:
        """
        Starts nerfstudio subprocess and blocks until finished.
        - Runs ``ns-process-data`` on raw user data.
        - Runs ``ns-train`` to train the model.
        """
        id = self.get_new_id()

        # Dump config
        dict_config = asdict(config)
        for key in dict_config:
            dict_config[key] = str(dict_config[key])
        (self.log / f"{id}.json").write_text(json.dumps(dict_config, indent=4))

        # Process data
        proc_data = self.data / f"{id}"
        proc_data.mkdir()
        if config.raw_data.is_dir():
            check_call(["ns-process-data", "images", "--data", config.raw_data, "--output-dir", proc_data])
        elif config.raw_data.is_file():
            check_call(["ns-process-data", "video", "--data", config.raw_data, "--output-dir", proc_data])
        else:
            raise ValueError(f"raw_data must be a file or folder, not {config.raw_data}")

        # Train
        check_call([
            "ns-train", config.method,
            "--experiment-name", "server",
            "--timestamp", str(id),
            "--max-num-iterations", str(config.iters),
            "--vis", "tensorboard",
            "nerfstudio-data", "--data", proc_data,
        ])

        results_path = self.outputs / "server" / config.method / str(id)
        model_path = next((results_path / "nerfstudio_models").iterdir())
        result = RunResult(
            id=id,
            proc_data=proc_data,
            results=results_path,
            model=model_path,
        )
        return result

    def start_viewer(self, result: RunResult, port: int):
        proc = Popen([
            "ns-viewer",
            "--load-config", result.results / "config.yml",
            "--viewer.websocket-port", str(port),
        ])
        return proc


if __name__ == "__main__":
    import sys
    runner = Runner()
    cfg = RunConfig(
        raw_data=Path(sys.argv[1]),
        method="nerfacto",
        iters=1000,
    )
    results = runner.do_run(cfg)
    print(results)
