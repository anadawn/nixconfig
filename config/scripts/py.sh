BBlue='\033[1;34m'

# python
py ()
{
  if test -f $HOME/testfolder/projects/python/flake.nix; then
    mkdir $HOME/testfolder/projects/python/$project_name
    cd $HOME/testfolder/projects/python
    cd $project_name
    touch main.py
    nix develop ../. -c $SHELL
  else
    nix flake new -t github:nix-community/templates#python ~/testfolder/projects/python 
    mkdir $HOME/testfolder/projects/python/$project_name
    cd $HOME/testfolder/projects/python
    cd $project_name
    touch main.py
    nix develop ../. -c $SHELL
  fi
	
}

# jupyter
jup ()
{
  if  test -d $HOME/testfolder/projects/python/jupyter; then
    cd $HOME/testfolder/projects/python/jupyter
    hyprctl dispatch movetoworkspace special
    nix shell nixpkgs#python311Packages.jupyterlab -c $SHELL -c jupyter-lab & hyprctl dispatch togglespecialworkspace
  else
    mkdir $HOME/testfolder/projects/python/jupyter/ 
    cd $HOME/testfolder/projects/python/jupyter/ #$project_name
    hyprctl dispatch movetoworkspace special
    nix shell nixpkgs#python311Packages.jupyterlab -c $SHELL -c jupyter-lab & hyprctl dispatch togglespecialworkspace
  fi
}


if [[ $1 == "jup" ]]; then
	jup

elif [[ $1 == "ls" ]]; then
	pushd $HOME/testfolder/projects/*/
        for i in $(ls -d */ | cut -f1 -d '/' ); do echo -e $BBlue${i}; done
	popd
elif [[ -z $1 ]]; then
  echo "enter project name"
  read -r project_name
  py
  echo "hi"

	
elif test -d $HOME/testfolder/projects/python/$1; then
   cd $HOME/testfolder/projects/python/$1
   nix develop ../. -c $SHELL
else
	project_name=$1
	if test -d $HOME/testfolder/projects/python/$1; then
		cd $HOME/testfolder/projects/python/$1
	else
		py

		
	fi
fi
