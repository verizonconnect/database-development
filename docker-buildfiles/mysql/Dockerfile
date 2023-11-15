FROM nuget.development.fleetmatics.com:8080/buildimages/library/mysql:8.0
LABEL MAINTAINER David Murphy

RUN apt-get update \
    && apt-get install -y build-essential git-core libv8-dev curl \
    && rm -rf /var/lib/apt/lists/*

# install my_prove
RUN curl -LO http://xrl.us/cpanm \
    && chmod +x cpanm \
    && ./cpanm TAP::Parser::SourceHandler::MyTAP

# install mytap
RUN git clone https://github.com/hepabolu/mytap.git \
    && cd mytap \
    && chmod +x ./install.sh

WORKDIR /mytap
