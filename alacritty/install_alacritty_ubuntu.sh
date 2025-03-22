#!/bin/bash

alacritty_repo_path="${HOME}/.local/src/alacritty"
alacritty_bin_path="${HOME}/.local/bin"

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
echo "  - cmake"
echo "  - g++"
echo "  - pkg-config"
echo "  - libfreetype6-dev"
echo "  - libfontconfig1-dev"
echo "  - libxcb-xfixes0-dev"
echo "  - libxkbcommon-dev"
echo "  - python3"
echo

read -rp "Do you want to install these? [Y/n]: " response
if ! continue_on "$response"; then
	echo "Exiting install."
	exit 1
fi

sudo apt install -y \
	cmake \
	g++ \
	pkg-config \
	libfreetype6-dev \
	libfontconfig1-dev \
	libxcb-xfixes0-dev \
	libxkbcommon-dev \
	python3 || exit 1

# Ensure Rust is available
if rustup override set stable && rustup update stable; then
	echo "Rust is set to stable and updated successfully."
else
	read -rp "Rustup must be installed. Do you want to install it? [Y/n]: " response
	if ! continue_on "$response"; then
		echo "Exiting install."
		exit 1
	fi
	
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	
	if [[ -f "${HOME}/.cargo/env" ]]; then
		source "${HOME}/.cargo/env"
	fi
	
	if rustup override set stable && rustup update stable; then
		echo "Rust is set to stable and updated successfully."
	else
		echo "Rustup is still not working properly."
		exit 1
	fi
fi

# Clone and build Alacritty
rm -rf "$alacritty_repo_path"
mkdir -p "$alacritty_repo_path"
git clone https://github.com/alacritty/alacritty.git "$alacritty_repo_path" || exit 1
cd "$alacritty_repo_path" || exit 1
cargo build --release || exit 1

mkdir -p "$alacritty_bin_path"
ln -sf "${alacritty_repo_path}/target/release/alacritty" "${alacritty_bin_path}/alacritty"

echo
echo "Alacritty has been built and linked to $alacritty_bin_path/alacritty"
