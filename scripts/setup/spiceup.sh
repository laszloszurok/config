#!/bin/bash

# running wal
wal -i ~/Wallpapers/ocean-minimal.png

# launching spotify to create the files that we need to modify
echo "Close Spotify to continue..."
spotify &> /dev/null &

# gaining read and write permissions over spotify files
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# enabling spotify dev-tools
spicetify backup apply enable-devtool

# applying custom css theme for spotify
spicetify update

# installing lyrics fetching app for spotify
cd "$(dirname "$(spicetify -c)")/CustomApps"
git clone https://github.com/khanhas/genius-spicetify
mv "genius-spicetify" genius
spicetify config custom_apps genius
spicetify apply
