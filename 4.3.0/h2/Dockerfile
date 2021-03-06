# DO NOT EDIT: created by update.sh from /templates/.dockerfile.j2" > "$dir/Dockerfile"
FROM openjdk:11-jre-slim-buster

# Install GPG for package vefification and WGET for file download
RUN apt-get update \
	&& apt-get -y install gnupg wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add the liquibase user and step in the directory
RUN addgroup --gid 1001 liquibase
RUN adduser --disabled-password --uid 1001 --ingroup liquibase liquibase

# Make /liquibase directory and change owner to liquibase
RUN mkdir /liquibase && chown liquibase /liquibase
WORKDIR /liquibase

# Change to the liquibase user
USER liquibase

# Latest Liquibase Release Version
ARG LIQUIBASE_VERSION=4.3.0

# Download, verify, extract
RUN set -x \
  && wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz" \
  && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz

# Setup GPG
RUN GNUPGHOME="$(mktemp -d)" 

# Download JDBC libraries, verify



RUN wget -O /liquibase/lib/h2.jar https://repo1.maven.org/maven2/com/h2database/h2/1.4.200/h2-1.4.200.jar \
	&& wget -O wget -O /liquibase/lib/h2.jar.asc https://repo1.maven.org/maven2/com/h2database/h2/1.4.200/h2-1.4.200.jar.asc \
    && gpg --auto-key-locate keyserver --keyserver ha.pool.sks-keyservers.net \
        --keyserver-options auto-key-retrieve \
        --verify /liquibase/lib/h2.jar.asc /liquibase/lib/h2.jar







COPY --chown=liquibase:liquibase docker-entrypoint.sh /usr/local/bin/
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["--help"]