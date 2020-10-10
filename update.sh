
variants=(
	postgresql
	mssql
	mariadb
	h2
	db2
	snowflake
	sybase
	firebird
	sqlite
	mysql
    all
)

min_version='3.0'

# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

function create_variant() {
	dir="$1/$variant"

	# Create the version+variant directory with a Dockerfile.
	mkdir -p "$dir"

	template="Dockerfile.template"
    docker run --rm \
        -v $PWD/templates:/templates \
        -e DOCKERFILE_HEADER='# DO NOT EDIT: created by update.sh from /templates/.dockerfile.j2" > "$dir/Dockerfile"' \
        -e LIQUIBASE_VERSION=$1 \
        -e DATABASE=$variant \
        dinutac/jinja2docker:2.1.6 /templates/.dockerfile.j2 > $dir/Dockerfile

	# Copy the shell scripts
	for name in entrypoint; do
		cp "docker-$name.sh" "$dir/docker-$name.sh"
	done
}

# Setting up latest version
curl -fsSL 'https://raw.githubusercontent.com/liquibase/liquibase/master/changelog.txt' |tac|tac| \
	grep -oE 'Changes in version [[:digit:]]+(\.[[:digit:]]+){2}' | \
	grep -oE '[[:digit:]]+(\.[[:digit:]]+){2}' | \
	sort -uV | \
	tail -1 > latest.txt

# Find versions
fullversions=( $( curl -fsSL 'https://raw.githubusercontent.com/liquibase/liquibase/master/changelog.txt' |tac|tac| \
	grep -oE 'Changes in version [[:digit:]]+(\.[[:digit:]]+){2}' | \
	grep -oE '[[:digit:]]+(\.[[:digit:]]+){2}' | \
	sort -urV ) )
versions=( $( printf '%s\n' "${fullversions[@]}" | cut -d. -f1-2 | sort -urV ) )

# Generate variants
for version in "${versions[@]}"; do
	fullversion="$( printf '%s\n' "${fullversions[@]}" | grep -E "^$version" | head -1 )"
    
	if version_greater_or_equal "$version" "$min_version"; then
        echo "Generating $version"
		for variant in "${variants[@]}"; do
			create_variant "$fullversion"
		done
	fi
done