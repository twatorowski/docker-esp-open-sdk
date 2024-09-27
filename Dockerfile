FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y bash git

RUN apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf \
flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
sed git unzip bash help2man wget bzip2
 
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
 
RUN useradd user
RUN chown -R user esp-open-sdk
USER user

WORKDIR /esp-open-sdk/crosstool-NG/.build/tarballs
COPY tarballs/* .

WORKDIR /esp-open-sdk
RUN make

USER root
WORKDIR /
ENV PATH="$PATH:/esp-open-sdk/xtensa-lx106-elf/bin"
