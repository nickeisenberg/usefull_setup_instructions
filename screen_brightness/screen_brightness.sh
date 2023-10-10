#! /bin/bash

# list all active monitiors
xrandr --listmonitors

# choose the monitor and set the brightness

monitor="MonitorName"
val=.6

xrandr --output $monitor --brightness $val
