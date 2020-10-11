
## Liquibase Docker images

This is forked from official [liquibase-docker](https://github.com/liquibase/docker) repository.  
This repo automatically creates docker images from [liquibase changelog](https://raw.githubusercontent.com/liquibase/liquibase/master/changelog.txt).

# Supported Tags

Minimum version: 3.8.x
Supported databases: `postgresql`, `mssql`, `mariadb`, `h2`, `db2`, `snowflake`, `sybase`, `firebird`, `sqlite`, `mysql`

The following tag combinations are supported:

-	`<VERSION>-<DATABASE>`,
- `<VERSION>`, where contains all database type
- `latest`, where contains all database type

## Examples

# MSSQL (SQL Server)

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \
  deniel92/liquibase \
  --url="jdbc:sqlserver://<IP OR HOSTNAME>:1433;database=<DATABASE>;" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  --liquibaseProLicenseKey="<PASTE LB PRO LICENSE KEY HERE>" \
  generateChangeLog
```

# PostgreSQL

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \
  deniel92/liquibase \
  --url="jdbc:postgresql://<IP OR HOSTNAME>:5432/<DATABASE>?currentSchema=<SCHEMA NAME>" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```

# MariaDB (MySQL)

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \
  deniel92/liquibase \
  --url="jdbc:mariadb://<IP OR HOSTNAME>:3306/<DATABASE>" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```

# DB2

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \
  deniel92/liquibase \ 
  --url="jdbc:db2://<IP OR HOSTNAME>:50000/<DATABASE>" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```

# Snowflake

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \
  deniel92/liquibase \ 
  --url="jdbc:snowflake://<IP OR HOSTNAME>/?db=<DATABASE>&schema=<SCHEMA NAME>" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```

# Sybase

```sh
docker run --rm \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \ 
  deniel92/liquibase \
  --url="jdbc:jtds:sybase://<IP OR HOSTNAME>:/<DATABASE>" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```

# SQLite

```sh
docker run --rm \
  -v <PATH TO DB FILE>:/liquibase/<DB FILE NAME>.db \
  -v <PATH TO CHANGELOG DIR>:/liquibase/changelog \ 
  deniel92/liquibase \ 
  --url="jdbc:sqlite:/liquibase/<DB FILE NAME>.db" \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  generateChangeLog
```

# Oracle (or any other host located JDBC libraries)

```sh
docker run --rm \
  -v <JDBC LOCAL DIR>:/liquibase/lib \
  -v <PATH TO CHANGELOG LOCAL DIR>:/liquibase/changelog \
  deniel92/liquibase \
  --classpath=/liquibase/lib/<JDBC JAR FILE> \
  --url=<JDBC URL> \
  --changeLogFile=/liquibase/changelog/<CHANGELOG NAME ie: "changelog.xml"> \
  --username=<USERNAME> --password=<PASSWORD> \
  generateChangeLog
```
