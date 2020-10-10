#!/bin/bash


latest=$( cat latest.txt )

# Generate each of the tags, build, and push.
versions=( */ )
versions=( "${versions[@]%/}" )
for version in "${versions[@]}"; do

    # Exclude templates folder
    if [ "$version" != "templates" ]; then
        variants=( $version/*/ )
        variants=( $(for variant in "${variants[@]%/}"; do
            echo "$(basename "$variant")"
        done) )
        for variant in "${variants[@]}"; do
        
            image="deniel92/liquibase"
			tagAliases=( )

            if [ "$variant" = "all" ]; then
                tagAliases+=( "$image:$version" )
            else
                tagAliases+=( "$image:$version-$variant" )
            fi

            if [ "$version" = "$latest" ] && [ "$variant" = "all" ]; then
                tagAliases+=( "$image:latest" )
            fi

            for tagAlias in "${tagAliases[@]}"; do
                echo "$tagAlias"
            done

            docker build -f $version/$variant/Dockerfile -t $image:$version-$variant .
            
            for tagAlias in "${tagAliases[@]}"; do
                echo "$tagAlias"
                docker tag $image:$version-$variant $tagAlias
                docker push $tagAlias
            done

        done
    fi
done