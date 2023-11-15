FROM mcr.microsoft.com/mssql/server:2019-CU22-ubuntu-20.04
LABEL maintainer David Murphy <david.murphy@verizonconnect.com>

USER root

RUN apt-get update; \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-3.1

RUN mkdir /opt/coverage
COPY ./linux-x64 /opt/sqlcover
RUN chmod 777 -R /opt/sqlcover
