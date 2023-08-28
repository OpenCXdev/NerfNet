# Worker

Wrapper around CognitiveStudio CLI.

## Usage

```py
from pathlib import Path

from worker import Runner, RunConfig, RunResult, verify_config

runner = Runner()


config = RunConfig(
    raw_data=Path("path/to/images/")
    method="nerfacto",
    iters=10000,
)

verify = verify_config(config)
if verify is None:
    print("Config valid.")
else:
    print("Config invalid:", verify)

result: RunResult = runner.do_run(config)
viewer_proc = runner.start_viewer(result, port=5000)
```

The `raw_data` path should contain individual image files to use.

`runner.do_run` waits for nerfstudio to finish; it then returns the result that
is guarenteed to be done (unless nerfstudio fails, in which case an error is raised).

`runner.start_viewer` returns a running `ns-viewer` process. It must be manually killed
later.
