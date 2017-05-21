#!/bin/bash
INTERNAL_OUTPUT="eDP-1"

# use arandr to create the monitor config scripts
WORK_SCRIPT=~/.screenlayout/work.sh
DEFAULT_SCRIPT=~/.screenlayout/home.sh


# just look for status of DP-1 - if connected - we are in the office
WORK=`xrandr|grep DP-1|grep -v $INTERNAL_OUTPUT |cut -f2 -d" "`

case $WORK in
				"connected")
          echo "set work monitor settings"
					. $WORK_SCRIPT
					;;
				*)
          echo "set home monitor settings"
					. $DEFAULT_SCRIPT
					;;
esac
