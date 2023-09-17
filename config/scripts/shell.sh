#!/usr/bin/env sh

b=$*

a=1

c=$(echo "$b" | wc -w)

flake="nixpkgs#"


#options
while getopts 'gi' options; do

 case "$options" in
	g)
	   nix shell "github:$2"
	exit
	;;
        i)
		nix shell "nixpkgs#$2" --impure
	 exit
	;;

 esac
	
done

# fun 
num=$(while (( a <= c )); do
echo -n "$flake""$(echo $b | awk '{print $'$a'}') "
 ((a++));
done)
# 

nix shell $num

