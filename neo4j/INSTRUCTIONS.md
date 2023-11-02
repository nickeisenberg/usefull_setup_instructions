* To get these versions, which are not the current versions, you need to go to
  https://neo4j.com/deployment-center/ 

* To download neo4j 5.6, go to Graph Database and then right-click on the download
  icon on Graph DatabaseSelf-Managed and open the link. This will download the
  latest version automatially, but when you are there, you can edit the url to
  take you to the 5.6 page and that 5.6 version will then download automatically.

* To download the cypher-shell 5.6 version, you do the same as above but go to tools
  on https://neo4j.com/deployment-center/

* Create a folder on your folder and move the downloaded `.deb` files into that folder
  just to stay organized.

* Before installing, Dan said to run
  `sudo apt install apt-transport-https ca-certificates curl software-properties-common -y`

* Then to install the `.deb` files, `cd` into the folder you moved these files into and 
  install cypher shell first with `sudo dpkg -i <cyphershell_deb_filename>.deb` and then
  install neo4j second with `sudo dpkg -i <neo4j_deb_filename>.deb`

* To start `neo4j`, just run `sudo neo4j start`. It will then open up in a local 
  browser. 

* The first time you log in, you use `username=neo4j` and `password=neo4j`. It will then
  ask you to set a password.

* To change the data directory, go to `/etc/neo4j/` and edit the file `neo4j.conf` and 
  change edit the line to `server.directories.data=<path to new dir>`. Once you start 
  neo4j back up, the databases will be stored to this folder. Only one server can be 
  attached to one folder.
