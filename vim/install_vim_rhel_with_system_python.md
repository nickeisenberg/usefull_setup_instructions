* install dependencies
```bash
sudo dnf builddep -y vim
```

* get vim repo 

```bash
mkdir -p ${HOME}/.local/src
git clone https://github.com/vim/vim.git ~/.local/src/vim
```

* configure the install

```bash
cd ${HOME}/.local/src/vim/src
PREFIX="${HOME}/.local"
./configure \
	--with-features=huge \
	--with-x \
	--enable-python3interp \
	--enable-fail-if-missing \
	--with-python3-command=$(which python3) \
	--with-python3-config-dir=$(python3-config --configdir) \
	--prefix="${PREFIX}"
```

* make and install. the resulting binaries will be at `${HOME}/.local/bin`

``` bash
make
sudo make install
```
