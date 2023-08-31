# Overview

This `worker` module is a wrapper around nerfstudio's CLI.

The available functions in this module is referred to as the "worker API".

It handles these complexities:

- Very particular file structure used by `ns-train` and `ns-viewer`.
- A Python API for calling each subprocess.
- State based database.

## Dataset tarballs

Each dataset is a collection of training images.

Each run is a specific training configuration and results on a dataset.

Therefore, each run belongs to a dataset.

The worker API can create and unpack `.tar.gz` tarballs of a dataset.
This allows you to:

- Pack the dataset and send it to a remote database.
- Come back later, download the tarball, unzip it, and resume any tasks.

The tarball is of a **dataset**; therefore, each tarball contains the training
images, and all nerfs associated with it.


## Expected workflow

Due to being able to pack any work in progress and upload it to a database,
most of these steps can be checkpoints, either to resume later or for another
server.

See `example.md` for an example with code.

- Download user data
    - Copy images into the dataset's raw images directory.
    - Optionally, rescale images to a standard resolution.
- Run Colmap
    - Uses `ns-process-data` and creates a colmap images directory.
- Run a run (train a nerf)
    - Create a child run of this dataset.
    - Run `ns-train`.
    - Copy results into the dataset.
- Run a viewer
    - Copy dataset results back to nerfstudio-style file structure.
    - Run `ns-viewer`.

## NerfRun directories

Due to the nature of `ns-train`'s output directory format, we use two directories
for each NerfRun:

- The dataset directory will be serialized into the `.tar.gz`. It is a single directory
  containing a few chosen files (e.g. model weights).
- The working (or temporary) directory is the direct output of `ns-train`. It contains
  all the fancy structures, and will not be serialized into the `.tar.gz`.

Therefore, we need to manually transfer files between these two. This is done with
the `copy_ds_to_tmp()` and `copy_tmp_to_ds()` methods. See `example.md` for more.

For example:

- After training, we `copy_tmp_to_ds` to move ns output into the database.
- Before running viewer, we `copy_ds_to_tmp` to setup the trained files into a structure
  nerfstudio will accept.
