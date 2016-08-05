FROM fedora:24
MAINTAINER info@vlad.eu

ENV USER default
ENV GROUP default
ENV HOME /home/default

RUN dnf install -y nss_wrapper procps htop git mc vim mlocate net-tools bind-utils make ed tar\
    && dnf clean all

# add developer user
RUN groupadd -g 1000 ${GROUP} \
    && useradd -u 1000 -r --gid 1000 -G wheel -m -d ${HOME} -s /bin/bash -c "Developer user" ${USER} \
    && chmod -R 755 ${HOME}

COPY nss_wrapper.sh /etc/profile.d/
COPY entrypoint.sh /entrypoint.sh

WORKDIR /workspace

VOLUME /workspace

CMD [ "/bin/bash" ]
ENTRYPOINT [ "/entrypoint.sh" ]