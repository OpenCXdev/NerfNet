# NerfNet
This repository is code meant for a cloud server (Lambda Labs) for training, displaying, and organizing contributed NeRFs. It contains the user interface for uploading custom data, the backend for integrating our data storage and our servers, and a rendering feature that displays a fully trained NeRF on the user-supplied data.

## Code Content

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Our [UI](https://docs.google.com/document/d/1-bKa5ty8xtjYgkV19riDosuHCsskMCWuYKAEekRvm4Q/view) supports a host of features, including the option for a user-supplied configuration file that will be parsed by our Large Language Model (LLM) assistant and a dual-sided rendering operation that can load a NeRF in "preview" mode and "fully-trained" mode. The user-supplied configuration file should follow the set of guidelines specified [here](), but its intended purpose is to allow for user control/customizability over the training process. We provide several examples of possible user configuration files to assist the user in using our website [here](https://docs.google.com/document/d/1B1i8rZoaeyODgPVHXVug7rnuB24XrqXqgHw06SKVoWs/view).

The rendering methodology supports two types: a "preview" mode and a "fully-trained" mode. The preview mode shows the user an expectation of what the fully trained NeRF will look like (we use a modified version of [instant neural graphics primitives](https://nvlabs.github.io/instant-ngp/) in order to produce the preview as it takes a very short amount of time (on the order of a few seconds) to train. Our fully-trained mode takes longer to train, as most 3D reconstruction methods take significantly longer than a few seconds (on the magnitude of several minutes to hours to even days). The default method for our fully-trained mode is a modification of the Nerfacto method presented in the [Nerfstudio](https://docs.nerf.studio/en/latest/). We rely on a self-maintained fork of this repository, called [CognitiveStudio](https://github.com/opencv/CognitiveStudio). All of the original results can be reproduced using this fork. Our fork inherents most of the functionality present in the original Nerfstudio library, but also supports the [RegNeRF](https://m-niemeyer.github.io/regnerf/) and [ReFNeRF](https://dorverbin.github.io/refnerf/) models.

Our library also supports a modified implementation of [3D Gaussian Splatted Radiance Fields](https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/), which is the current state-of-the-art and is not a neural radiance field model but instead utilizes another paradigm of 3D reconstruction, rasterization, to render the images.

The "preview" mode supports real-time rendering while the "fully-trained" mode will send a websocket viewer link to the user's email address that will be live for 24 hours.
