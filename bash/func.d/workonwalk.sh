function workon_walk () {
    # By Ron Duplain <rduplain AT gmail>
    # Walk the directory tree upward until:
	# * a virtualenv is found which matches the name of a directory
	# * the root directory is reached (no virtualenv found)
	#
	# Activate the identified virtualenv with virtualenvwrapper's workon.
	dir=${PWD}
	while [ -n "$dir" ]; do
		workon ${dir##*/} >/dev/null 2>&1
		if [ $? -eq 0 ]; then
			break
		fi
		dir=${dir%/*}
	done
}

