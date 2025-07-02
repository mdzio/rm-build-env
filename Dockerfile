# rm-build-env Dockerfile

# base image
FROM rockylinux/rockylinux:9

# image meta data
LABEL org.opencontainers.image.title="rm-build-env"
LABEL org.opencontainers.image.description="Docker image containing all required tools to build RaspberryMatic."
LABEL org.opencontainers.image.source="https://github.com/mdzio/rm-build-env"
LABEL org.opencontainers.image.licenses="GPLv3"
LABEL org.opencontainers.image.authors="mdzio <info@ccu-historian.de>"

# install required packages
COPY requirements.txt /
RUN dnf -y install $(cat requirements.txt) && rm /requirements.txt && dnf clean all

# prepare build directory and environment
ENV FORCE_UNSAFE_CONFIGURE=1
VOLUME /rmbuild
WORKDIR /rmbuild

# launch a shell
CMD ["/bin/bash"]
