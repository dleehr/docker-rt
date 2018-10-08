FROM debian:stretch-slim
# Begin docker-rt-base

LABEL maintainer="Christian Loos <cloos@netsandbox.de>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 \
    cpanminus \
    curl \
    gcc \
    gnupg \
    vim \
    # RT core dependencies
    libapache2-mod-fcgid \
    libapache-session-perl \
    libbusiness-hours-perl \
    libc-dev \
    libcgi-emulate-psgi-perl \
    libcgi-psgi-perl \
    libconvert-color-perl \
    libcrypt-eksblowfish-perl \
    libcrypt-ssleay-perl \
    libcss-minifier-xs-perl \
    libcss-squish-perl \
    libdata-guid-perl \
    libdata-ical-perl \
    libdata-page-pageset-perl \
    libdata-page-perl \
    libdate-extract-perl \
    libdate-manip-perl \
    libdatetime-format-natural-perl \
    libdbd-pg-perl \
    libdbix-searchbuilder-perl \
    libdevel-globaldestruction-perl \
    libemail-address-list-perl \
    libemail-address-perl \
    libencode-perl \
    libfcgi-perl \
    libfcgi-procmanager-perl \
    libfile-sharedir-install-perl \
    libfile-sharedir-perl \
    libgd-graph-perl \
    libgraphviz-perl \
    libhtml-formattext-withlinks-andtables-perl \
    libhtml-formattext-withlinks-perl \
    libhtml-mason-perl  \
    libhtml-mason-psgihandler-perl \
    libhtml-quoted-perl \
    libhtml-rewriteattributes-perl \
    libhtml-scrubber-perl  \
    libipc-run3-perl \
    libipc-signal-perl \
    libjavascript-minifier-xs-perl \
    libjson-perl \
    liblocale-maketext-fuzzy-perl \
    liblocale-maketext-lexicon-perl \
    liblog-dispatch-perl \
    libmailtools-perl \
    libmime-tools-perl \
    libmime-types-perl \
    libmodule-refresh-perl \
    libmodule-signature-perl \
    libmodule-versions-report-perl \
    libnet-cidr-perl \
    libnet-ip-perl \
    libplack-perl \
    libregexp-common-net-cidr-perl \
    libregexp-common-perl \
    libregexp-ipv6-perl \
    librole-basic-perl \
    libscope-upper-perl \
    libserver-starter-perl \
    libsymbol-global-name-perl \
    libterm-readkey-perl  \
    libtext-password-pronounceable-perl \
    libtext-quoted-perl \
    libtext-template-perl \
    libtext-wikiformat-perl  \
    libtext-wrapper-perl \
    libtime-modules-perl \
    libtree-simple-perl  \
    libuniversal-require-perl \
    libxml-rss-perl \
    make \
    perl-doc \
    starlet \
    w3m \
    # RT developer dependencies
    libemail-abstract-perl \
    libfile-which-perl \
    liblocale-po-perl \
    liblog-dispatch-perl-perl \
    libmojolicious-perl \
    libperlio-eol-perl \
    libplack-middleware-test-stashwarnings-perl \
    libset-tiny-perl \
    libstring-shellquote-perl \
    libtest-deep-perl \
    libtest-email-perl \
    libtest-expect-perl \
    libtest-longstring-perl \
    libtest-mocktime-perl \
    libtest-nowarnings-perl \
    libtest-pod-perl \
    libtest-warn-perl \
    libtest-www-mechanize-perl \
    libtest-www-mechanize-psgi-perl \
    libwww-mechanize-perl \
    libxml-simple-perl \
&& rm -rf /var/lib/apt/lists/*

RUN cpanm \
  # RT dependencies
  Mozilla::CA \
  # RT extension development dependencies
  ExtUtils::MakeMaker \
  Module::Install \
  Module::Install::RTx \
  Module::Install::Substitute \
&& rm -rf /root/.cpanm

# end docker-rt-base

ENV RT_VERSION 4.4.3
ENV RT_SHA 738ab43cac902420b3525459e288515d51130d85810659f6c8a7e223c77dadb1

RUN cd /usr/local/src \
  && curl -sSL "https://download.bestpractical.com/pub/rt/release/rt-${RT_VERSION}.tar.gz" -o rt.tar.gz \
  && echo "${RT_SHA}  rt.tar.gz" | sha256sum -c \
  && tar -xzf rt.tar.gz \
  && rm rt.tar.gz \
  && cd "rt-${RT_VERSION}" \
  && ./configure \
    --disable-gpg \
    --disable-smime \
    --enable-developer \
    --enable-gd \
    --enable-graphviz \
    --with-db-type=Pg \
  && make install

# Removed "make initdb" because that depends on separate database service

RUN chown -R www-data:www-data /opt/rt4/var/
COPY RT_SiteConfig.pm /opt/rt4/etc/RT_SiteConfig.pm

COPY apache.rt.conf /etc/apache2/sites-available/rt.conf
RUN a2dissite 000-default.conf && a2ensite rt.conf

# /etc/apache2/envvars isn't sourced by default
ENV APACHE_LOCK_DIR=/var/lock/apache2 \
  APACHE_LOG_DIR=/var/log/apache2 \
  APACHE_PID_FILE=/var/run/apache2/apache2.pid \
  APACHE_RUN_DIR=/var/run/apache2 \
  APACHE_RUN_GROUP=www-data \
  APACHE_RUN_USER=www-data

VOLUME /opt/rt4

EXPOSE 80
CMD ["/usr/sbin/apache2","-DFOREGROUND"]
