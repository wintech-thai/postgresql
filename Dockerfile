FROM bitnamilegacy/postgresql:17.5.0-debian-12-r16

USER root

RUN install_packages \
    wget \
    lsb-release \
    gnupg \
    ca-certificates \
    postgresql-17-postgis-3 \
    postgresql-17-postgis-3-scripts \
    postgis \
    postgresql-17-pgvector

USER 1001
