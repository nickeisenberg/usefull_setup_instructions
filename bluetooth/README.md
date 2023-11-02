* use `bluetoothctl devices` to get the available devices. For example,
```
nicholas@lenovo:~$ bluetoothctl devices
Device 21:09:21:07:55:00 DEWALT TWS 209A
nicholas@lenovo:~$
```

* grab the number from this output, `21:09:21:07:55:00`, and then run
  `bluetoothctl connect 21:09:21:07:55:00`.
