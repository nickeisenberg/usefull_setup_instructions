#!/bin/bash

vim_repo_path="${HOME}/.local/src/vim"
vim_bin_and_share_root="${HOME}/.local"

my_pwd=$(pwd)

continue_on() {
	case "$1" in
		[Yy])
			return 0
			;;
		*)
			return 1
			;;
	esac
}

echo "The following dependencies need to be installed:"
echo "  - libtool-bin"
echo "  - libx11-dev"
echo "  - xserver-xorg-dev"
echo "  - xorg-dev"
echo "  - libncurses-dev"
echo

read -rp "Do you want to install these? [Y/n]: " response
if ! continue_on "$response"; then
	echo "Exiting install."
	exit 1
fi

sudo apt install -y \
	libtool-bin \
	libx11-dev \
	xserver-xorg-dev \
	xorg-dev \
	libncurses-dev


rm -rf "$vim_repo_path"
mkdir -p "$vim_repo_path"
git clone https://github.com/vim/vim.git "$vim_repo_path" || exit 1
cd "$vim_repo_path/src" || exit 1

mkdir -p "$vim_bin_and_share_root"

./configure --with-x --prefix="$vim_bin_and_share_root" || exit 1
make || exit 1
sudo make install || exit 1

cd "$my_pwd" || exit 1
echo "Vim installation complete."
