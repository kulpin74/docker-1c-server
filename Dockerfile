FROM ubuntu:bionic

ARG UID=1000
ARG GID=1000

RUN groupadd --gid $GID grp1cv8 && \
    useradd --uid $UID --gid $GID --shell /bin/bash --create-home usr1cv8

ENV DEBIAN_FRONTEND noninteractive

ENV GOSU_VERSION 1.12
RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends ca-certificates wget locales \
  && `#----- Install the dependencies -----` \
  && apt-get -qq install --yes --no-install-recommends fontconfig imagemagick \
  && `#----- Install gosu -----` \
  && wget --quiet --output-document /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

RUN localedef --inputfile ru_RU --force --charmap UTF-8 --alias-file /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

ARG PLATFORM_VERSION
ARG SERVER_VERSION
ADD *.deb /tmp/
RUN dpkg --install /tmp/1c-enterprise$PLATFORM_VERSION-common_${SERVER_VERSION}_amd64.deb 2> /dev/null \
  && dpkg --install /tmp/1c-enterprise$PLATFORM_VERSION-server_${SERVER_VERSION}_amd64.deb 2> /dev/null \
  && rm /tmp/*.deb

COPY entrypoint.sh /
COPY logcfg.xml /

EXPOSE 1540-1541 1560-1591

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ragent"]
