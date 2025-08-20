FROM bitnami/postgresql:16.2.0-debian-12-r18

USER root

# ติดตั้ง build tools และ pgvector
RUN install_packages \
      build-essential \
      git \
      postgresql-server-dev-16 \
    && git clone --branch v0.7.4 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make && make install \
    && cd / && rm -rf /tmp/pgvector \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER 1001
