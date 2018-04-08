# dfir-docker
Collection of the most popular and widely used open-source forensic tools in a lightweight and fast docker image.

## Overview
The Docker image is based on [Alpine Linux](https://hub.docker.com/_/alpine/) and contains the most popular open-source forensics tools. 
Some of them are provided by the great folks of [SANS](https://github.com/sans-dfir). 

### Install Docker
Wait! It's dangerous to go alone! 
Make sure you have Docker engine installed. Click [here](https://docs.docker.com/install/) for detailed installation instructions.
Build the image with one of the following ways :

### Build from Docker registry (Recommended)
Just :
```
sudo docker pull nov3mb3r/dfir
```
Simple isn't it?

### Build from source
Follow these steps and you are good to go.
```
git clone https://github.com/nov3mb3r/dfir-docker.git
cd dfir-docker
sudo docker build -t "dfir" .
```

### Run 
To run created image :
```
sudo docker run -it dfir /bin/ash
```
Access your case files with a shared folder between your working directory and the container.

##### Preserve the authenticity of your evidence: Make sure you don't tamper with the data, by granting read only permissions to the container. 
```
$ sudo docker run -it -v ~/cases:/cases:ro dfir /bin/ash 
```
