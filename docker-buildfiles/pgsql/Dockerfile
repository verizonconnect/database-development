FROM postgres:13.4-alpine
LABEL maintainer David Murphy <david.murphy@verizonconnect.com>

ENV PERL_MM_USE_DEFAULT=1

RUN apk add --no-cache --update \
        build-base \
        clang \
        curl \
        expat \
        expat-dev \
        git \
        gnupg \
        heirloom-mailx \
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
         
RUN rm -rf /var/cache/apk/* /tmp/*

RUN cpan -i Module::Signature \
        TAP::Parser::SourceHandler::pgTAP \
        XML::SAX::Expat
 
# install pg_prove
RUN cpanm TAP::Parser::SourceHandler::pgTAP
 
WORKDIR /var/lib/postgresql
 
# install pgtap
RUN git clone https://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install \
    && make clean

RUN mkdir ./tests
