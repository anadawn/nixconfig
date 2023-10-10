

touch  $HOME/.local/share/lastwatch
cd $HOME
while true
do
	sleep 3 
	find Downloads/ -name "* *" -type f | rename 's/ /_/g'
	file=$(find -L $HOME/Downloads/ -type f -cnewer $HOME/.local/share/lastwatch | awk '{print $1}')
	file=$(echo $file | awk '{print $1}')
	echo $file
	if [[ $file =~ .*\.(sh|md|txt|pdf|html) ]]; then
		if [[ $file == *.pdf ]]; then
			mv $file $HOME/Documents/pdfs/

		else
			mv $file $HOME/Documents/

		fi

	elif [[ $file =~ .*\.(mkv|mp4)  ]]; then
		mv $file $HOME/Videos/

	elif [[ $file =~ .*\.(jpg|webp|jpeg|png) ]]; then
		mv $file $HOME/Pictures/

	elif [[ $file =~ .*\.(ipynb) ]]; then
		mv $file $HOME/testfolder/projects/python/jupyter/

	elif [[ $file =~ .*\.(iso) ]]; then
		mv $file $HOME/Other/iso

	elif [[ $(echo $file | awk -F '/' '{print $4}') == "Downloads" || $file == *"."* ]]; then
		notify-send -u critical "Error: Unknown file extension for file '$(echo $file | awk -F '/' '{print $5}')'. Don't know where to move"
		sleep 20
	fi
done
