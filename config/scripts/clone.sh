#!/usr/bin/env sh


while getopts 'lsq' option; do
	case "$option" in
		l)
			git clone "https://gitlab.com/$2" $3
			exit
			;;
		s)
			git clone "https://sourcehut.org/$2" $3
			exit
			;;
		q)
			query="$2"
			echo "searching for repo $2..."
			repo=`gh search repos $query | fzf --sync | awk '{print $1}'`
			git clone "http://github.com:$repo" $3
			exit
			;;
	esac
done

git clone "https://github.com:$1" $2
