#!/usr/bin/env sh


while getopts 'hls' option; do
       case "$option" in
        l)
                git clone "https://gitlab.com/$2" $3
		exit
        ;;
        s)
		git clone "https://sourcehut.org/$2" $3
		exit
	;;
       esac
done

  git clone "git@github.com:$1" $2
