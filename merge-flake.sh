FORMAT="%(path)s:%(row)d:%(col)d:~~%(code)s~~%(text)s"

# awk needs escape colors formatted in this way;
FILE_COL0R='\033[0;35m'  # PURPLE
ERROR_COLOR='\033[31m'   # RED
WARN_COLOR='\033[1;33m'  # YELLOW
NO_COLOR='\033[0m'       # NO COLOR

function merge-flake {
	# Lint merge into target branch if provided, otherwise 
	# assume we are merging into master.
	if [[ $1 ]]; then
		target=$1
	else
		target="master"
	fi
	
	cur_br=$(git branch | grep '*' | cut -d ' ' -f2)
	merge_diff=$(git diff $cur_br master --name-only | sort | uniq)
	
	flake8 --format=$FORMAT $merge_diff | \
		awk -F"~~" \
			-v path="$FILE_COL0R" \
			-v error="$ERROR_COLOR" \
			-v warn="$WARN_COLOR" \
			-v no_color="$NO_COLOR" \
			-v cur_br="$cur_br" \
			-v target="$target" \
			'BEGIN{print path "****** Linting errors merging " warn cur_br path " into " warn target path " ******"}
			      {print path $1 "\t" warn $2 "\t" no_color $3}'

}