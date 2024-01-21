# Mounting an EBS volume

* Running `lsblk will show the drives with size and you can then find the
  the drives that we need to mount.

* Format the drive with `sudo mkfs -t ext4 /dev/<drivename>`

* Now create a folder to mount the drive to. For example,
  `sudo mkdir /ebs0`

* Mount this drive with `sudo mount /dev/<drivename> /ebs0`

* Now `df -H` should show the mounted drive

# Mounting to survive an EC2 shutdown and restart.

The above volumes will need to be remounted if you shutdown an ec2 instance
and then restart it. To fix this you need to edit the `/etc/fstab` file. Do the
following.

* Run `blkid` to find the UUID of the volume.

* Add the this line to the bottom of the file:
  `UUID=<UUID> /nvme1n1 ext4 defaults 0 2` where `<UUID>` is the actual UUID.
  Do not put quotation marks around the UUID. Here is the menaing of
  `defaults 0 2` according to chat gpt.

  ``` 
  defaults: This is a set of default mount options that are applied when
  the filesystem is mounted. The defaults option actually implies several other
  options: rw (read-write), suid (allow set-user-identifier or
  set-group-identifier bits), dev (interpret character or block special devices
  on the filesystem), exec (allow execution of binaries), auto (automatically
  mounted at boot or with the -a option), nouser (only permit root to mount the
  filesystem), and async (all I/O to the filesystem is done asynchronously).
  Essentially, when you specify defaults, you are applying a common, standard
  set of options that are suitable for most filesystems.

  0: This is the dump field. The dump utility uses this field to determine when
  to make a backup of the filesystem. A value of 0 means that the filesystem
  will never be backed up by the dump program. This is a common setting for
  most systems, as dump is an older utility and not widely used in many modern
  Linux distributions.

  2: This is the pass (or fsck order) field. It determines the order in which
  filesystem checks are done at boot time by the fsck program. The root
  filesystem should have this value set to 1, and other filesystems that should
  be checked should have it set to 2. This means they will be checked after the
  root filesystem. Filesystems that do not need to be checked at boot time are
  typically set to 0.

  So, "defaults 0 2" means: Mount with default options, do not back up with dump,
  and check the filesystem at boot time after the root filesystem. 
  ```
