# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim less man wget tar git gzip unzip make cmake software-properties-common curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev

ADD . /repo
WORKDIR /repo
RUN cmake -DCMAKE_BUILD_TYPE=Release -B ./build 
RUN cmake --build ./build

