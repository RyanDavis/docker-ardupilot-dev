FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    ccache \
    python3-pip \
    python3-dev \
    python3-future \
    python3-wxgtk4.0 \
    python3-matplotlib \
    python3-scipy \
    python3-opencv \
    python3-serial \
    python3-numpy \
    python3-pyparsing \
    python3-empy \
    cmake \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpng-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libwebsockets-dev \
    libvorbis-dev \
    libavformat-dev \
    libswscale-dev \
    libdc1394-dev \
    libjpeg-turbo8-dev \
    libv4l-dev \
    libasio-dev \
    libqt5core5a \
    libqt5gui5 \
    libqt5widgets5 \
    libqt5svg5 \
    libqt5serialport5 \
    qtdeclarative5-dev \
    qml-module-qtquick2 \
    qml-module-qtquick-controls2 \
    qml-module-qtquick-dialogs \
    qml-module-qtlocation \
    qml-module-qtpositioning \
    libxml2-utils \
    wget \
    curl \
    sudo \
    nano \
    vim \
    gcc-arm-none-eabi \
    libtool \
    genromfs \
    unzip \
    xterm \
    autoconf \
    automake \
    pkg-config \
    gperf \
    usbutils

# Install Python dependencies
RUN pip3 install --no-cache-dir pexpect pytest pymavlink MAVProxy future

# Create a user for development
RUN useradd -m -s /bin/bash ardupilot && \
    echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot && \
    chmod 0440 /etc/sudoers.d/ardupilot

# Set up working directory
USER ardupilot
WORKDIR /home/ardupilot

# Clone the repository
RUN git clone https://github.com/ArduPilot/ardupilot.git && \
    cd ardupilot && \
    git submodule update --init --recursive

# Set up environment variables
ENV PATH="/home/ardupilot/.local/bin:${PATH}"
ENV PATH="/home/ardupilot/ardupilot/Tools/autotest:${PATH}"

# Set prompt to show we're in the container
RUN echo "PS1='\[\e[1;36m\](docker)\[\e[0m\] \u@\h:\w\$ '" >> /home/ardupilot/.bashrc

# Default command
CMD ["/bin/bash"]
