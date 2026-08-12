FROM bitnamilegacy/postgresql:17.5.0-debian-12-r16

USER root

RUN install_packages \
    wget \
    lsb-release \
    gnupg \
    build-essential \
    git \
    ca-certificates \
    && mkdir -p /etc/apt/keyrings \
    && wget --quiet -O /etc/apt/keyrings/postgresql.asc \
       https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    && echo "deb [signed-by=/etc/apt/keyrings/postgresql.asc] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
       > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    \
    # --- ติดตั้ง PostGIS สำหรับ PostgreSQL 17 ---
    && apt-get install -y \
       postgresql-17-postgis-3 \
       postgis \
    \
    # --- ติดตั้ง PostgreSQL development headers ---
    && apt-get install -y \
       postgresql-server-dev-17 \
    \
    # --- ติดตั้ง pgvector ---
    && git clone --branch v0.8.1 --depth 1 \
       https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/pgvector \
    \
    # --- cleanup ---
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER 1001
