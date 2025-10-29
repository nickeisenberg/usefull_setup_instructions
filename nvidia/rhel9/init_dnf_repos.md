* check repos
```
sudo dnf repolist
```

add the following repos is the did not appear from the above 
```
subscription-manager repos --enable=rhel-9-for-$(uname -m)-appstream-rpms
subscription-manager repos --enable=rhel-9-for-$(uname -m)-baseos-rpms
subscription-manager repos --enable=codeready-builder-for-rhel-9-$(uname -m)-rpms
sudo dnf update -y
```

* add the epel repo
```
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf update -y
```

* test the install
```
sudo dnf install -y neofetch
```
