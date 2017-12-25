sed -E -n '/^path/p;/^path/s|([^/,]*/)*([^,]+)|\2|gp' $1
