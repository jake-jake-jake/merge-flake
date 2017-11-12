 #!/usr/bin/env bash
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
	merge_diff=$(git diff $cur_br master --name-only | grep '.py' | sort | uniq)
	
	flake8 --format=$FORMAT $merge_diff > merge-flake.txt
	errs=$(cat merge-flake.txt | wc -l)
	if [[ $errs > "0" ]]; then
		echo merge-flake.txt | \
		awk -F"~~" \
			-v path="$FILE_COL0R" \
			-v error="$ERROR_COLOR" \
			-v warn="$WARN_COLOR" \
			-v no_color="$NO_COLOR" \
			-v cur_br="$cur_br" \
			-v target="$target" \
			'BEGIN{print path "****** Linting errors merging " warn cur_br path " into " warn target path " ******"}
			      {print path $1 "\t" warn $2 "\t" no_color $3}'
		rm merge-flake.txt
	else
		echo -e "$FILE_COL0R****** No errors found merging" "$WARN_COLOR" "$cur_br" "$FILE_COL0R" "into $WARN_COLOR $target $FILE_COL0R******$NO_COLOR"
		rm merge-flake.txt
	fi
}

merge-flake $1