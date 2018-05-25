# rm-build-env Dockerfile

# base image
FROM centos:7

# image meta data
LABEL maintainer=info@ccu-historian.de
LABEL version=1.0.0+20180524
LABEL license=GPLv3
LABEL org.label-schema.schema-version=

# install required packages
COPY requirements.txt /
RUN yum -y install $(cat requirements.txt)
RUN rm /requirements.txt
RUN yum clean all

# prepare build directory and envorinment
ENV FORCE_UNSAFE_CONFIGURE=1
VOLUME /rmbuild
WORKDIR /rmbuild

# launch a shell
CMD ["/bin/bash"]
