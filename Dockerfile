FROM python:3.9.12

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1
ENV STANVERSION 2.22.1

# Install LLVM
RUN apt-get update && apt-get install -y \
    clang-3.9 \
    postgresql-client \
    libc++-dev

# Install CMake
RUN apt-get install -y cmake

# Download and compile cmdStan
WORKDIR /opt
RUN wget https://github.com/stan-dev/cmdstan/releases/download/v${STANVERSION}/cmdstan-${STANVERSION}.tar.gz && tar -xzf cmdstan-${STANVERSION}.tar.gz
WORKDIR /opt/cmdstan-${STANVERSION}
RUN make build -j4 && ln -fs /opt/cmdstan-${STANVERSION}/bin/stanc /usr/bin
