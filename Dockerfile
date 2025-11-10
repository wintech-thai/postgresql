FROM bitnamilegacy/postgresql:16.2.0-debian-12-r18

USER root

RUN install_packages \
      wget \
      lsb-release \
      gnupg \
      build-essential \
      git \
    && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update \
    # --- ติดตั้ง PostGIS สำหรับ PostgreSQL 16 ---
    && apt-get install -y postgresql-16-postgis-3 postgis \
    # --- ติดตั้ง pgvector ---
    && apt-get install -y postgresql-server-dev-16 \
    && git clone --branch v0.7.4 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make && make install \
    && cd / && rm -rf /tmp/pgvector \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER 1001
