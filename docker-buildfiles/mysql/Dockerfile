FROM mysql:8.4
LABEL maintainer David Murphy <david.murphy@verizonconnect.com>

# Fix: Import the MySQL GPG key to prevent verification errors
RUN rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023

RUN microdnf update -y \
    && microdnf install -y make gcc \
    && microdnf clean all

