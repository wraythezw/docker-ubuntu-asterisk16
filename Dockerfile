FROM ubuntu:bionic
MAINTAINER Keith Rose <me@keithro.se>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install --yes git curl wget libnewt-dev libssl-dev \
            libncurses5-dev subversion  libsqlite3-dev build-essential libjansson-dev libxml2-dev  uuid-dev && \
    apt-get install --yes aptitude-common libboost-filesystem1.65.1 libboost-iostreams1.65.1 \
  libboost-system1.65.1 libcgi-fast-perl libcgi-pm-perl libclass-accessor-perl \
  libcwidget3v5 libencode-locale-perl libfcgi-perl libhtml-parser-perl \
  libhtml-tagset-perl libhttp-date-perl libhttp-message-perl libio-html-perl \
  libio-string-perl liblwp-mediatypes-perl libparse-debianchangelog-perl \
  libsigc++-2.0-0v5 libsub-name-perl libtimedate-perl liburi-perl libxapian30

WORKDIR /usr/src
RUN curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz && \
    tar -xvf asterisk-16-current.tar.gz && \
    mv asterisk-16.*/ asterisk
WORKDIR /usr/src/asterisk

RUN contrib/scripts/get_mp3_source.sh && \
    contrib/scripts/install_prereq install

RUN ./configure && \
    make menuselect.makeopts && \
    menuselect/menuselect --enable DONT_OPTIMIZE --enable BETTER_BACKTRACES menuselect.makeopts

RUN make && make install && make config && ldconfig

COPY configs/ /etc/asterisk/
COPY configs/pjsip.d/* /etc/asterisk/pjsip.d/

COPY startup.sh /root/startup.sh

EXPOSE 5060/udp
EXPOSE 10000-20000/udp

ENTRYPOINT ["/bin/bash", "/root/startup.sh"]
