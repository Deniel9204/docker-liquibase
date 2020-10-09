#!/bin/bash

# Need to docker login before run

# temp directory for generated dockerfiles
mkdir generated

cp docker-entrypoint.sh ./generated/docker-entrypoint.sh

#databases=(postgres mssql mariadb h2 db2 snowflake sybase firebird sqlite sqlite)
databases=(postgres mysql all)
files=$(cd ./variables && ls -1 | sed -e 's/\.yml$//')

for f in $files
do
    for d in "${databases[@]}"
    do
        docker run --rm \
        -v $PWD/templates:/templates \
        -v $PWD/variables:/variables \
        dinutac/jinja2docker:2.1.6 /templates/Dockerfile-$d.j2 /variables/$f.yml --format=yaml > ./generated/Dockerfile.$f

        docker build -f ./generated/Dockerfile.$f -t deniel92/liquibase:$f-$d .
        docker push deniel92/liquibase:$f-$d
    done
done

# clean
rm -rf generated