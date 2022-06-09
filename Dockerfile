FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev cmake

ADD . /repo
WORKDIR /repo
RUN cmake -DCMAKE_BUILD_TYPE=Release -B ./build 
RUN cmake --build ./build

RUN mkdir -p /deps
RUN ldd /repo/dictu | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /repo/dictu /repo/dictu
ENV LD_LIBRARY_PATH=/deps

