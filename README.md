# Download Dataset (Important)

In order for python code to work you need the datasets which can be downloaded from [here](https://ungprod.sharepoint.com/:u:/s/NSFResearchProjectAModularMultilayerFrameworkforReal-Time355/ERG9Cw0WY6pCrfWkGKj2WlEBaEbHVeBD2HTCwKsmpWhSZw?e=h6tFYP) and unzip at the root of the project

[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/jigsawhsi-a-network-for-hyperspectral-image/hyperspectral-image-classification-on-pavia)](https://paperswithcode.com/sota/hyperspectral-image-classification-on-pavia?p=jigsawhsi-a-network-for-hyperspectral-image)

[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/jigsawhsi-a-network-for-hyperspectral-image/hyperspectral-image-classification-on-salinas-1)](https://paperswithcode.com/sota/hyperspectral-image-classification-on-salinas-1?p=jigsawhsi-a-network-for-hyperspectral-image)

[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/jigsawhsi-a-network-for-hyperspectral-image/hyperspectral-image-classification-on-indian)](https://paperswithcode.com/sota/hyperspectral-image-classification-on-indian?p=jigsawhsi-a-network-for-hyperspectral-image)

# JigsawHSI

Application of the Jigsaw network to Hyperspectral Image (HSI) classification.

# Requisites

You need to donwload manually the datasets from: https://www.ehu.eus/ccwintco/index.php/Hyperspectral_Remote_Sensing_Scenes
Copy the following files to your ./data directory:

- Indian Pines (Corrected Indian Pines and Indian Pines groundtruth)
- Pavia University (Pavia University and Pavia University groundtruth)
- Salinas scene (Corrected Salinas and Salinas groundtruth)

Create an Anaconda environment with Python 3.8 and the libraries from conda_requisites.txt

- You can run: "conda create --name <new_env> --file conda_requisites.txt", where <new_env> is the name of your new environment's name

The program makes use of GPU resources to train and use neural networks, therefore, you need a CUDA-compatible NVIDA GPU.

# How to run

You need to run Jupyter in your local machine:

- Clone this repository to your computer
- Run anaconda and select your <new_env> environment
- Change directories to the cloned repository
- Run Jupyter in your local machine
- Follow the instructions to open Jupyter in your browser and connect to it
- Open the JigsawHSI.ipyb notebook and run the cells

# How to make changes

There are two main ways to run variants of the JigsawHSI:

- Edit config.ini
- Select your preferred configuration from config.ini by changing the line "dataset = 'PU_100'"
- Edit the code to your heart's content!

# The paper

You can read the early release of the paper in ArXiv or in this repository: JigsawHSI.pdf

# Acknowledgements

Thanks to Gopal Krishna, for making the HyperSN code available in github (https://github.com/gokriznastic/HybridSN).
