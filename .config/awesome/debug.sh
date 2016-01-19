Xephyr :1 -ac -br -noreset -screen 1152x720 &
sleep 5
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.new
