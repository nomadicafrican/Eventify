FROM postgres:15

WORKDIR /docker-entrypoint-initdb.d
COPY init.sql .
# RUN chown -R postgres:postgres /docker-entrypoint-initdb.d/

