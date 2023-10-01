Stop MySQL using the following command:

`sudo /etc/init.d/mysql stop`

Copy the existing data directory (default located in /var/lib/mysql) using the following command:

`sudo cp -R -p /var/lib/mysql /newpath`

edit the MySQL configuration file with the following command:

`sudo gedit /etc/mysql/my.cnf   # or perhaps /etc/mysql/mysql.conf.d/mysqld.cnf`

Look for the entry for datadir, and change the path (which should be /var/lib/mysql) to the new data directory.

In the terminal, enter the command:

`sudo gedit /etc/apparmor.d/usr.sbin.mysqld`

Look for lines beginning with `/var/lib/mysql`. Change `/var/lib/mysql` in the lines with the new path.

Save and close the file.

Edit the file `/etc/apparmor.d/tunables/alias` to include a line "alias /var/lib/mysql/ -> /newpath/,"

Restart the AppArmor profiles with the command:

`sudo /etc/init.d/apparmor reload`

Restart MySQL with the command:

`sudo /etc/init.d/mysql restart`

Now login to MySQL and you can access the same databases you had before.

To check if the datadir has changed, use the query:

`SHOW VARIABLES WHERE Variable_Name LIKE "%dir";`
