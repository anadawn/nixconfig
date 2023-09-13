
TodayDate=$(date +%d)
TodayTime=$(date +%R)
MonthNum=$(date +%b)


git clone https://github.com/charuaaru/anniversary ~/testfolder/anniversary-gift
	
		
if [ "$TodayDate" -eq "14" ];then
       rm ~/Pictures/Wallpapers/*
       cp ~/testfolder/anniversary-gift/anniversary.png ~/Pictures/Wallpapers/anniversary.png
       swww img ~/Pictures/Wallpapers/anniversary.png
       mv ~/testfolder/anniversary-gift/index1.html ~/testfolder/anniversary-gift/index.html
fi
