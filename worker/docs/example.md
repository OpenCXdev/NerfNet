# Example

```py
from worker import Dataset, RunConfig, NerfRun

dset = Dataset("dataset_id")

# Copy training images into dataset
images_path = dset.raw_data_path
# For example...
shutil.copy(image1, images_path / "1.jpg")
...

# Rescale user images
dset.rescale_images()
# or dset.rescale_images(res=400)

# Possible tar.gz

# Run colmap
dset.run_colmap()

# Possible tar.gz

# Create child NerfRun
config = RunConfig(method="nerfacto", iters=1000)
run: NerfRun = dset.get_run("run_id", config)
run.run_train()
# Copy to database
run.copy_tmp_to_ds()

# Possible tar.gz

# Run viewer
run.copy_ds_to_tmp()
proc = run.run_viewer(port=5050)
```

## Tarball

In the above code block, at all parts marked `Possible tar.gz`, it is possible and
advisable to create and save a tarball.

Tarballs can be uploaded to a remote database. Then, at any time in the future, even
on a different server, you can download the tarball and resume where you were.

Code is:

```py
tarball_path = dset.make_tar()
# upload to database...

# later:

# download tarball...
tarball_path = ...
dset.unpack_tar(tarball_path)

# and resume where you left off.
```
