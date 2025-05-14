#!/bin/bash

# requires python3.11 as a quick fix

CLONE_VIM_REPO_TO="${HOME}/.local/src/vim"
VIM_CONFIGURE_PREFIX="${HOME}/.local"

CURRENT_PWD=$(pwd)

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


rm -rf "$CLONE_VIM_REPO_TO"
mkdir -p "$CLONE_VIM_REPO_TO"

git clone https://github.com/vim/vim.git "$CLONE_VIM_REPO_TO" || exit 1

cd "$CLONE_VIM_REPO_TO/src" || exit 1

mkdir -p "$VIM_CONFIGURE_PREFIX"

./configure \
	--with-features=huge \
	--with-x \
	--enable-python3interp \
	--enable-fail-if-missing \
	--with-python3-command="python3.11" \
	--with-python3-config-dir=$(python3.11-config --configdir) \
	--prefix="${VIM_CONFIGURE_PREFIX}"

make -j install prefix="${VIM_CONFIGURE_PREFIX}" || exit 1

cd "$CURRENT_PWD" || exit 1
echo "Vim installation complete."
