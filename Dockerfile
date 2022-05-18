FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev cmake

ADD . /repo
WORKDIR /repo
RUN cmake -DCMAKE_BUILD_TYPE=Release -B ./build 
RUN cmake --build ./build

