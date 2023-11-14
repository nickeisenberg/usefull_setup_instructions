### Here are some things to consider for to run `ssh -p <port_number> <username>@<public_ip>`

1. Add `Port <port_number>` to `/etc/ssh/ssh_config` and `/etc/ssh_sshd_config`. 
   After doing this, you will need to `sudo systemctl restart ssh` and 
   `sudo systemctl restart sshd`. There are other setting in here that should be set.

2. Allow the port through the firewall with `sudo ufw allow <port_number>/tcp`.

3. Check that `<port_number>` is available in the `iptable` with
   `sudo iptables --list | grep <port_number>`

4. Make sure port forwarding is set throught the router and modem. For the router,
   go to `routerlogin.net` and for the modem, use the cox wifi app and go to 
   `wifi -> view wifi equipment -> advanced settings -> port forwarding`. Note that the
   internal IP address may change so that the router's port forward may need to be updated 
   from time to time.
