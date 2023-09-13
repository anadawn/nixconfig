
TodayDate=$(date +%d)
TodayTime=$(date +%R)
MonthNum=$(date +%b)


git clone https://github.com/charuaaru/anniversary ~/testfolder/anniversary-gift
	
		
if [ "$TodayDate" -eq "12" ];then
       rm ~/Pictures/Wallpapers/*
       cp ~/testfolder/anniversary-gift/anniversary.png ~/Pictures/Wallpapers/anniversary.png
       swww img ~/Pictures/Wallpapers/anniversary.png
       mv ~/testfolder/anniversary-gift/index1.html ~/testfolder/anniversary-gift/index.html
elif [ "$TodayDate" -eq "13" ]; then
	rm ~/Pictures/Wallpapers/anniversary.png
	chpaper $(wallhaven ~/Pictures/Wallpapers/)
	mv ~/testfolder/anniversary-gift/index.html ~/testfolder/anniversary-gift/index1.html
	touch ~/testfolder/anniversary-gift/index.html
fi
