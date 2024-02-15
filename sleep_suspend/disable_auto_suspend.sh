# To disable auto-suspend when unplugged
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# To disable auto-suspend when plugged
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# To check the setting of auto-suspend when unplugged
gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type

# To check the setting of disable auto-suspend when plugged
gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 

# chatgpt said this should work
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# chatgpt said this will undue the previous
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
