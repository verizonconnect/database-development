FROM mysql:8.2.0
LABEL maintainer David Murphy <david.murphy@verizonconnect.com>

# Fix: Import the MySQL GPG key to prevent verification errors
RUN rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023

RUN microdnf update -y \
    && microdnf install -y make gcc git curl perl perl-core expat-devel \
    && microdnf clean all

# install my_prove
RUN curl -LO http://xrl.us/cpanm \
    && chmod +x cpanm \
    && ./cpanm TAP::Parser::SourceHandler::MyTAP \
    && ./cpanm TAP::Harness::JUnit

# install mytap
RUN git clone https://github.com/hepabolu/mytap.git \
    && cd mytap \
    && chmod +x ./install.sh

WORKDIR /mytap