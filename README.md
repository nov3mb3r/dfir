# docker Forensic Toolkit
Collection of the most popular and widely used open-source forensic tools in a lightweight and fast docker image.

## Overview
Focus what on what matters the most! Memory (volatility), registry (regripper), filesystem (sleuthkit). 

Volatility comes with extra community plugins to speed up your investigations.

The Docker image is based on [Alpine Linux](https://hub.docker.com/_/alpine/), the most lightweight linux container distribution.
Kudos to the [SANS](https://github.com/sans-dfir) team, providing some of the tools 

### Install Docker
Wait! It's dangerous to go alone! 

Make sure you have the Docker engine installed. Click [here](https://docs.docker.com/install/) for detailed installation instructions.

### Build from Docker registry (Recommended)
Just :
```
sudo docker pull nov3mb3r/dfir
```
Simple isn't it?

### Run 
To deploy a container from the created image :
```
sudo docker run -it nov3mb3r/dfir /bin/ash
```
Access your case files with a shared folder between your working directory and the container.

##### Make sure you don't spoil your evidence files, by granting read-only permissions to the container. 
```
$ sudo docker run -it -v ~/cases:/cases:ro nov3mb3r/dfir /bin/ash 
```
