# Version: 0.0.1
# @jose Examen-final
# DOCKER
# -------------------------------------
FROM fedora:27
LABEL author="@jose otero perez"
LABEL description="POP server 2018-2019"
RUN dnf -y install procps passwd uw-imap
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
