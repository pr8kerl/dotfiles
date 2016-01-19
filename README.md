# dotfiles

Some i3 wm config for starters
Ensure **feh** is installed for the background image.

* Clone recursively to check out the vim-go submodule

```
git clone --recursive git@github.com:pr8kerl/dotfiles.git
```

* Install urxvt

```
apt-get install rxvt-unicode
```

* Install font **Envy Code R**
Download [here](https://download.damieng.com/fonts/original/EnvyCodeR-PR7.zip)

```
mkdir -p ~/.fonts/truetype
unzip ~/Downloads/EnvyCodeR-PR7.zip -d ~/.fonts/truetype/
```

* Run the following command to add the font to your fontcache
``
fc-cache -v
fc-list|grep -i envy
``


