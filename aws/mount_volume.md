# Mounting an EBS volume

* Running `lsblk will show the drives with size and you can then find the
  the drives that we need to mount.

* Format the drive with `sudo mkfs -t ext4 /dev/<drivename>`

* Now create a folder to mount the drive to. For example,
  `sudo mkdir /ebs0`

* Mount this drive with `sudo mount /dev/<drivename> /ebs0`

* Now `df -H` should show the mounted drive
