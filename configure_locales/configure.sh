# Gnome terminal was not opening in X11.
# This happened after I made the guest account. This caused
# the system wide language to erase. This set it back to 
# english

sudo dpkg-reconfigure locales
sudo update-locale LANG=en_US.UTF-8
