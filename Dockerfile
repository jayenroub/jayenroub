FROM ubuntu:16.04

ARG DONATE_LEVEL=0
ARG GIT_TAG

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:jonathonf/gcc-7.1
RUN apt-get update
RUN apt-get install -y gcc-7 g++-7 git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev

RUN git clone https://github.com/xmrig/xmrig.git
WORKDIR /app/xmrig
RUN git checkout $GIT_TAG

# Adjust donation level
RUN sed -i -r "s/k([[:alpha:]]*)DonateLevel = [[:digit:]]/k\1DonateLevel = ${DONATE_LEVEL}/g" src/donate.h

RUN mkdir build
WORKDIR /app/xmrig/build
RUN cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7
RUN make
Run sysctl -w vm.nr_hugepages=1168


CMD ./xmrig -o pool.supportxmr.com:3333 -u 85oH2cH4q4zaP3Cze5Csa2fdPxWPaNW4hbvYLeHjrxj9NDyh7Qhd2zYGHFwBzcRqQrKbK1KC8gM3rigXMquEBSpA5K7UNUk -p x -k
