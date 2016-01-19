#!/bin/bash
# http://awesome.naquadah.org/wiki/Using_Multiple_Screens
# check current settings...
SCREENS=`xrandr -q|grep connected|grep -v disconnected|awk '{print $1}'`
#Screen 0: minimum 320 x 200, current 2944 x 1080, maximum 8192 x 8192
#LVDS1 connected 1024x768+0+0 (normal left inverted right x axis y axis) 293mm x 164mm
#   1366x768       60.0 +   40.0  
#   1360x768       59.8     60.0  
#VGA1 disconnected (normal left inverted right x axis y axis)
#HDMI1 connected 1920x1080+1024+0 (normal left inverted right x axis y axis) 509mm x 286mm
#   1920x1080      60.0*+
#DP1 disconnected (normal left inverted right x axis y axis)


# set resolution for external monitor
xrandr -q|grep connected|grep -v disconnected|awk '{print $1}'|while read SCREEN
do
	case "$SCREEN" in
		LVDS1)
			xrandr --output LVDS1 --mode 1366x768 --auto
			;;
		HDMI1)
			xrandr --output HDMI1 --mode 1920x1080 --auto
			xrandr --output LVDS1 --off
			;;
		*)
			xrandr --output LVDS1 --mode 1366x768 --auto
			xrandr --output HDMI1 --off
			;;
	esac
done

xrdb -merge $HOME/.Xresources

