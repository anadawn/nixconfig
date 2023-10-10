#!/usr/bin/env sh

b=$*

a=1

c=$(echo "$b" | wc -w)

flake="nixpkgs#"

input="--inputs-from /persist/home/aruna/nixconfig"


#options
while getopts 'gi' options; do

 case "$options" in
	g)
	   nix shell "github:$2"
	exit
	;;
        i)
		nix shell $input "nixpkgs#$2" --impure
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

nix shell $input $num

