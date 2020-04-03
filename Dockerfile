FROM ubuntu:16.04
MAINTAINER intel.com


# This will prevent questions from being asked during the install
ENV DEBIAN_FRONTEND=noninteractive
# update and install packages required by TAF
RUN apt-get update && apt-get install gcc -y
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    sudo \
    ca-certificates \
    curl \
    gcc \
    git \
    libpq-dev \
    pkg-config \
    libssl-dev \
    libffi-dev \
    libpcap-dev \
    xsltproc \
    smitools \
    sshpass \
    openjdk-8-jre \
    libc6-i386 \
    libcurl4-openssl-dev \
    tk8.6 \
    tcl8.6 \
    tclx \
    libzmq3-dev \
    iproute2 \
    iputils-ping \
    wget \
    openssh-client \
    doxygen \
    doxygen-latex \
    rsync \
    # install python
    python3 \
    python3-dev \
    # we can't use ubuntu pip because it is old
    python3-tk \
    && apt-get autoremove \
    && apt-get clean


RUN cd /tmp
RUN wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
RUN tar -xvf Python-3.8.2.tgz
RUN cd Python-3.8.2 && ./configure --enable-optimizations
RUN cd Python-3.8.2 && make
RUN cd Python-3.8.2 && make install

ARG TAF_ROOT=/root/taf
COPY /  $TAF_ROOT/
RUN export PYTHONPATH="$PYTHONPATH:/root/taf/taf"
RUN python3 -m venv /root/taf/venv
RUN /bin/bash -c "source /root/taf/venv/bin/activate && pip install pip -U"
RUN /bin/bash -c "source /root/taf/venv/bin/activate && pip install -r $TAF_ROOT/requirements.txt"


#RUN test -r "$TAF_ROOT/unittests/ci/requirements.txt" && pip install -r $TAF_ROOT/unittests/ci/requirements.txt || true

#RUN pip install -r $TAF_ROOT/requirements.txt


# entry point to login as root user for TAF container
ENTRYPOINT login -f root && bash
#py.test --loglevel=DEBUG --env=/root/taf/tests/examples/logger_usage/environment.json --setup_file=/root/taf/tests/examples/logger_usage/setup.json --call_check=fast examples/logger_usage/test_logger.py
#py.test --loglevel=DEBUG --env=/root/taf/tests/examples/logger_usage/environment.json --setup_file=/root/taf/tests/examples/logger_usage/setup.json --call_check=fast /root/taf/tests/examples/logger_usage/test_logger.py