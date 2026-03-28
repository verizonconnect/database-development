FROM mcr.microsoft.com/mssql/server:2019-CU22-ubuntu-20.04
LABEL maintainer David Murphy <david.murphy@verizonconnect.com>

ENV ACCEPT_EULA=Y
ENV DOTNET_VERSION=6.0
ENV SQL_SERVER_COVERAGE_VERSION=3.0
ENV TSQLT_VERSION=1.0.8083.3529

USER root

RUN apt-get update; \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-${DOTNET_VERSION} zip && \
    mkdir /opt/sqlcover && \
    mkdir /opt/tsqlt && \
    wget --directory-prefix=/opt/sqlcover/ https://github.com/sayantandey/SQLServerCoverage/releases/download/v${SQL_SERVER_COVERAGE_VERSION}/SQLServerCoverage_${SQL_SERVER_COVERAGE_VERSION}_linux-x64.zip && \
    unzip /opt/sqlcover/SQLServerCoverage_${SQL_SERVER_COVERAGE_VERSION}_linux-x64.zip -d /opt/sqlcover/ && \
    chmod 777 -R /opt/sqlcover && \
    rm /opt/sqlcover/SQLServerCoverage_${SQL_SERVER_COVERAGE_VERSION}_linux-x64.zip && \
    cd /opt && \
    wget https://tsqlt.org/download/tsqlt/?version=1-0-8083-3529 -O /opt/tSQLt_v${TSQLT_VERSION}.zip && \
    unzip -j /opt/tSQLt_v${TSQLT_VERSION}.zip tSQLt.class.sql PrepareServer.sql -d /opt/tsqlt/ && \
    rm /opt/tSQLt_v${TSQLT_VERSION}.zip
