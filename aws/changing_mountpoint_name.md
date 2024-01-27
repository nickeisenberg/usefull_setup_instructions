Suppose you have a volume /dev/nvme1n1 that is mounted to /nvme1n1. Also,
suppose that you have a a user created on /nvme1n1, ie, /nvme1n1/nick.
The following are instructions if you want to rename the mountpoint /nvme1n1.

1. First you need to unmount the volume. `sudo umount /nvme1n1`. You may need
   to force it with `sudo umount -f /nvme1n1`

2. Move the mount point `sudo mv /nvme1n1 /nvme1n1users`

3. Remount with `sudo mount /dev/nvme1n1 /nvme1n1users`

4. Update the `/etc/fstab` file to handle this change

5. Update the users with 
    * `sudo usermod -d /nvme1n1users/nick nick`
    * `sudo chown -R nick:nick /nvme1n1users/nick`
