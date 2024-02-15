# Setting up users on a mounted EBS volume

* `sudo useradd -m -d /ebs0/<username> -s /bin/bash <username>`

* `sudo chown <username>:<username> /ebs0/<username>`

* `sudo chmod 700 /ebs0/<username>`

* To set up a password, `sudo passwd <username>`

* To give the user sudo access then do `sudo usermod -aG sudo <username>`

# Copying the setup of one user to another.

* `sudo useradd -m -d /ebs0/<username> -s /bin/bash <username>`

* `sudo rsync -av /ebs0/user1/ /ebs0/user2/`

* `sudo chown -R <username>:<username> /ebs0/<username>`

* `sudo chmod 700 /ebs0/<username>`

* To give the user sudo access then do `sudo usermod -aG sudo <username>`

# Allow users to have access to the data drive

* Create a group for the data drive with `sudo groupadd drive_group`

* Add this group to the drive with `sudo chown -R :drive_group /<drive>`

* Add this group to the users with `sudo usermod -aG drive_group <user>`

* Run `sudo chmod -R 770 /<drive>` to give read write to the group.

# ensure that drive_groups is always added as the group for new things in /<drive>
```bash
sudo chmod g+s /<drive>
sudo find /<drive> -type d -exec chmod g+s {} +
```


# View all users that are set up.

* The user that are set up will appear at the bottom of `/etc/passwd`
