# To disable auto-suspend when unplugged
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# To disable auto-suspend when plugged
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# To check the setting of auto-suspend when unplugged
gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# To check the setting of disable auto-suspend when plugged
gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

