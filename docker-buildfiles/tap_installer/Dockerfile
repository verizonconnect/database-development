# Start with a lightweight Linux image
FROM alpine:3.18
LABEL maintainer="Your Name <your.email@example.com>"

# Install all necessary build dependencies.
# ⭐️ ADDED 'expat-dev' for compiling the XML::Parser module.
RUN apk add --no-cache --update \
    bash \
    build-base \
    perl \
    perl-app-cpanminus \
    perl-dev \
    perl-dbi \
    perl-xml-parser \
    perl-xml-simple \
    expat-dev \
    git \
    curl \
    wget \
    # The MySQL client for connecting to the database
    mysql-client

# Install cpanm (Perl package manager) globally
RUN curl -LO http://xrl.us/cpanm && \
    chmod +x cpanm && \
    mv cpanm /usr/local/bin/

# Now, use cpanm to install the required TAP modules.
RUN cpanm TAP::Parser::SourceHandler::MyTAP && \
    cpanm TAP::Harness::JUnit

# Install the MySQL client, which is our only runtime dependency.
RUN apk add --no-cache mysql-client

# Clone the mytap repository.
RUN git clone https://github.com/hepabolu/mytap.git /mytap

# Set the final working directory.
WORKDIR /mytap