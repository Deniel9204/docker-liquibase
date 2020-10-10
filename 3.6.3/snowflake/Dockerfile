# DO NOT EDIT: created by update.sh from /templates/.dockerfile.j2" > "$dir/Dockerfile"
FROM openjdk:11-jre-slim-buster

# Install GPG for package vefification
RUN apt-get update \
	&& apt-get -y install gnupg wget

# Add the liquibase user and step in the directory
RUN addgroup --gid 1001 liquibase
RUN adduser --disabled-password --uid 1001 --ingroup liquibase liquibase

# Make /liquibase directory and change owner to liquibase
RUN mkdir /liquibase && chown liquibase /liquibase
WORKDIR /liquibase

# Change to the liquibase user
USER liquibase

# Latest Liquibase Release Version
ARG LIQUIBASE_VERSION=3.6.3

# Download, verify, extract
RUN set -x \
  && wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz" \
  && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz

# Setup GPG
RUN GNUPGHOME="$(mktemp -d)" 

# Download JDBC libraries, verify





RUN wget -O /liquibase/lib/snowflake.jar https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.12.3/snowflake-jdbc-3.12.3.jar \
	&& wget -O wget -O /liquibase/lib/snowflake.jar.asc https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.12.3/snowflake-jdbc-3.12.3.jar.asc \
    && gpg --auto-key-locate keyserver --keyserver ha.pool.sks-keyservers.net \
        --keyserver-options auto-key-retrieve \
        --verify /liquibase/lib/snowflake.jar.asc /liquibase/lib/snowflake.jar





COPY --chown=liquibase:liquibase docker-entrypoint.sh /usr/local/bin/
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["--help"]