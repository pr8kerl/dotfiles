
LS_COLORS='di=0;33' 
export LS_COLORS

xrdb -merge .Xresources

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s ~/.bashrc ]] && . ~/.bashrc
