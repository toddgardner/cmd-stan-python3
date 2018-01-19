FROM python:3.6

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1
ENV STANVERSION 2.17.0

# Install LLVM
RUN apt-get update && apt-get install -y \
    clang-3.5 \
    postgresql-client \
    libc++-dev
RUN ln -s /usr/bin/clang++-3.5 /usr/bin/clang++

# Download and compile cmdStan
WORKDIR /opt
RUN wget https://github.com/stan-dev/cmdstan/releases/download/v${STANVERSION}/cmdstan-${STANVERSION}.tar.gz && tar -xzf cmdstan-${STANVERSION}.tar.gz
WORKDIR /opt/cmdstan-${STANVERSION}
RUN make build -j4 && ln -fs /opt/cmdstan-${STANVERSION}/bin/stanc /usr/bin
