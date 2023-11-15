FROM dev.packagemanager.eu.tools.vz-connect.net/buildimages/vzc/library/postgres:13.4-alpine

ENV PERL_MM_USE_DEFAULT=1
ENV PG_PARTMAN_VERSION=4.5.1

RUN apk add --no-cache --update \
        build-base \
        curl \
        expat \
        expat-dev \
        git \
        gnupg \
        llvm \
        llvm-dev \
        make \
        perl \
        perl-app-cpanminus \
        perl-dev \
        perl-dbd-pg \
        perl-dbi \
        perl-xml-libxml \
        perl-xml-parser \
        perl-xml-simple \
        postgresql-client \
        postgresql-dev \
        sudo \
        wget
         
RUN     rm -rf /var/cache/apk/* /tmp/*

RUN     cpan -i Module::Signature \
                TAP::Parser::SourceHandler::pgTAP \
                XML::SAX::Expat \ 
# install pg_prove
RUN cpanm TAP::Parser::SourceHandler::pgTAP
RUN cpanm Test::Deep
RUN cpanm TAP::Harness::JUnit
 
WORKDIR /var/lib/postgresql
 
# install pgtap
#RUN git clone https://github.com/theory/pgtap.git \
#    && cd pgtap \
#    && make \
#    && make install \
#    && make clean

# install pg_partman
RUN wget -O /var/lib/postgresql/pg_partman.tgz https://github.com/pgpartman/pg_partman/archive/refs/tags/v$PG_PARTMAN_VERSION.tar.gz \
    && tar xvzf /var/lib/postgresql/pg_partman.tgz \
    && cd pg_partman-$PG_PARTMAN_VERSION \
    && make NO_BGW=1 install \
    && cd .. && rm -rf pg_partman.tgz

# install pg_cron
RUN git clone https://github.com/citusdata/pg_cron.git \
    && cd pg_cron \
    && export PATH=/usr/bin:$PATH \
    && make && sudo PATH=$PATH make install \
    && cp /usr/lib/postgresql/pg_cron.so /usr/local/lib/postgresql/ \
    && cp /usr/share/postgresql/extension/* /usr/local/share/postgresql/extension/

CMD ["-c", "shared_preload_libraries=pg_cron", "-c", "cron.database_name=postgres"]

#RUN mkdir ./tests