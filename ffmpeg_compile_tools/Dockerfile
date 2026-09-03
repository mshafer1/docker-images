FROM ubuntu:26.04@sha256:2260313b31c8c011cd2eebe728008efac1b3982be73eb71348ea2648d2c0e09b

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq

# dependencies
RUN apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libgnutls28-dev \
  libmp3lame-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  meson \
  ninja-build \
  pkg-config \
  texinfo \
  wget \
  yasm \
  zlib1g-dev


RUN mkdir -p /root/ffmpeg_sources /root/bin

# gnutls not found using pkg-config
# aom >= 2.0.0 not found using pkg-config
# SvtAv1Enc >= 0.9.0 not found using pkg-config
RUN apt-get install -y $(apt-cache search 'libgnutls.*-dev' | cut -d' ' -f1) \
    libunistring-dev \
    libaom-dev \
    libunistring-dev libaom-dev libsvtav1enc-dev


# precompiled deps
RUN apt-get install -y \
    nasm \
    libx264-dev \
    libx265-dev libnuma-dev \
    libvpx-dev \
    libfdk-aac-dev \
    libopus-dev \
    libdav1d-dev
    

# libraries from ffmpeg itself
WORKDIR  /root/ffmpeg_sources
RUN wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
    tar xjvf ffmpeg-snapshot.tar.bz2

COPY ./build_command.sh /root/ffmpeg_sources/

RUN cd ffmpeg && bash /root/ffmpeg_sources/build_command.sh


# AV1 video encoder/decoder
RUN cd /root/ffmpeg_sources && \
    git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && \
    mkdir -p aom_build && \
    cd aom_build && \
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_TESTS=OFF -DENABLE_NASM=on ../aom && \
    PATH="$HOME/bin:$PATH" make && \
    make install

# libsvtav1
RUN cd /root/ffmpeg_sources && \
    git -C SVT-AV1 pull 2> /dev/null || git clone https://gitlab.com/AOMediaCodec/SVT-AV1.git && \
    mkdir -p SVT-AV1/build && \
    cd SVT-AV1/build && \
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF .. && \
    PATH="$HOME/bin:$PATH" make && \
    make install

# libvmaf
RUN cd ~/'ffmpeg_sources' && \
    git -C vmaf pull 2> /dev/null || git clone --depth 1 https://github.com/Netflix/vmaf.git && \
    mkdir -p 'vmaf/libvmaf/build' && \
    cd 'vmaf/libvmaf/build' && \
    meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static '../' --prefix "$HOME/ffmpeg_build" --bindir="$HOME/bin" --libdir="$HOME/ffmpeg_build/lib" && \
    ninja && \
    ninja install;

# user should get the libraries, but not the sources
VOLUME [ "/root/ffmpeg_sources" ]
