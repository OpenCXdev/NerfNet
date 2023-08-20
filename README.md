# NerfNet
This repository is code meant for a cloud (probably Lambda Labs) for training, displaying, and organizing contributed NeRFs. It contains the user interface for uploading custom data, the backend for integrating our data storage and our servers, and a rendering feature that displays a fully trained NeRF on the user-supplied data.

Our UI supports a host of features, including the option for a user-supplied configuration file that will be parsed by our Large Language Model (LLM) assistant and a dual-sided rendering operation that can load a NeRF in "preview" mode and "fully-trained" mode. The user-supplied configuration file should follow the set of guidelines specified [here](), but its intended purpose is to allow for user control/customizability over the training process. We provide several examples of possible user configuration files to assist the user in using our website [here](https://docs.google.com/document/d/1B1i8rZoaeyODgPVHXVug7rnuB24XrqXqgHw06SKVoWs/view).

The original data and results can be experimented with using [CognitiveStudio](https://github.com/opencv/CognitiveStudio)

## Code Content
