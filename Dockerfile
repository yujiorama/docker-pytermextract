FROM python:3.9.1-slim

MAINTAINER Yuji Okazawa <yujiorama+github@gmail.com>

ARG PYTERMEXTRACT_URL="http://gensen.dl.itc.u-tokyo.ac.jp/soft/pytermextract-0_01.zip"
ARG PYTERMEXTRACT_DISTNAME="pytermextract-0_01"
ARG MECAB_IPADIC_NEOLOGD_URL="https://github.com/neologd/mecab-ipadic-neologd.git"

ENV PYTERMEXTRACT_DIST="/usr/local/pytermextract/pytermex"

RUN set -x \
 && useradd \
    -d /temrex \
    -m \
    -u 10001 \
    -U \
    termex \
 ;

RUN set -x \
 && DEBIAN_FRONTEND=noninteractive apt-get update -q -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    curl \
    file \
    git \
    libmecab-dev \
    make \
    mecab \
    mecab-ipadic-utf8 \
    patch \
    sudo \
    unzip \
    xz-utils \
    zip \
 && pip install janome \
 && curl -fsSL --output "/var/tmp/${PYTERMEXTRACT_DISTNAME}.zip" "${PYTERMEXTRACT_URL}" \
 && unzip -q -d "/var/tmp" "/var/tmp/${PYTERMEXTRACT_DISTNAME}.zip" \
 && cd "/var/tmp/${PYTERMEXTRACT_DISTNAME}" \
   && python setup.py install \
   && mkdir -p "${PYTERMEXTRACT_DIST}" \
   && cp -a pytermex/* "${PYTERMEXTRACT_DIST}/" \
 && cd / \
 && rm -rf "/var/tmp/${PYTERMEXTRACT_DISTNAME}.zip" "/var/tmp/${PYTERMEXTRACT_DISTNAME}" \
 && git clone --depth 1 "$MECAB_IPADIC_NEOLOGD_URL" /var/tmp/mecab-ipadic-neologd \
 && /var/tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
 && rm -rf /var/tmp/mecab-ipadic-neologd \
 && SUDO_FORCE_REMOVE=yes DEBIAN_FRONTEND=noninteractive apt-get remove -q -y \
    curl \
    file \
    git \
    make \
    patch \
    sudo \
    unzip \
    xz-utils \
    zip \
 && DEBIAN_FRONTEND=noninteractive apt-get autoremove -q -y \
 && DEBIAN_FRONTEND=noninteractive apt-get clean -q -y \
 && rm -rf /var/lib/apt/lists/* \
 ;

COPY termextract docker-entrypoint.sh /usr/local/bin/

RUN set -x \
 && chmod 755 /usr/local/bin/termextract /usr/local/bin/docker-entrypoint.sh \
 ;

USER termex
WORKDIR /temrex

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["janome"]
