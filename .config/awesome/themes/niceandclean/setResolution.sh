#!/bin/bash
#

THEMEDIR="/home/ians/.config/awesome/themes/niceandclean"

# http://awesome.naquadah.org/wiki/Using_Multiple_Screens
# check current settings...
xrandr -q
#Screen 0: minimum 320 x 200, current 2944 x 1080, maximum 8192 x 8192
#LVDS1 connected 1024x768+0+0 (normal left inverted right x axis y axis) 293mm x 164mm
#   1366x768       60.0 +   40.0  
#   1360x768       59.8     60.0  
#   1024x768       60.0* 
#   800x600        60.3     56.2  
#   640x480        59.9  
#VGA1 disconnected (normal left inverted right x axis y axis)
#HDMI1 connected 1920x1080+1024+0 (normal left inverted right x axis y axis) 509mm x 286mm
#   1920x1080      60.0*+
#   1280x1024      75.0     60.0  
#   1152x864       75.0  
#   1024x768       75.1     60.0  
#   800x600        75.0     60.3  
#   640x480        75.0     60.0  
#   720x400        70.1  
#DP1 disconnected (normal left inverted right x axis y axis)


# set resolution for external monitor

xrandr --output HDMI1 --mode 1920x1080 --right-of LVDS1

