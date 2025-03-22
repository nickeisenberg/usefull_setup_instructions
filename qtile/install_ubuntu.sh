qtile_src_dir="${HOME}/.local/src/qtile"
qtile_bin_dir="${HOME}/.local/bin"

mkdir -p "${qtile_src_dir}"

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

# Check for Python 3
if ! python3 --version >/dev/null 2>&1; then
	echo "Python3 is not installed."
	exit 1
fi

# Get major.minor Python version
python_version=$(python3 --version | awk '{print $2}')
major=$(echo "$python_version" | cut -d. -f1)
minor=$(echo "$python_version" | cut -d. -f2)
python_version="${major}.${minor}"
echo "Detected Python version: $python_version"

# Show dependencies
echo
echo "The following dependencies need to be installed:"
echo "  - python${python_version}-venv"
echo "  - python3-cffi"
echo "  - libpangocairo-1.0-0"
echo

read -rp "Do you want to install these? [Y/n]: " response
if ! continue_on "$response"; then
	echo "Exiting install."
	exit 1
fi

# Install dependencies
sudo apt install -y \
	"python${python_version}-venv" \
	python3-cffi \
	libpangocairo-1.0-0 || exit 1

# Set up virtual environment
python3 -m venv "${qtile_src_dir}/.venv"
source "${qtile_src_dir}/.venv/bin/activate"

if [[ "$(which python)" != "${HOME}/.local/src/qtile/.venv/bin/python" ]]; then
	echo "venv is not properal activated"
	echo "$(which python)"
	exit 1
fi

# Install Python dependencies
pip install \
	xcffib \
	pulsectl-asyncio \
	numpy \
	qtile \
	psutil \
	iwlib || exit 1

qtile_bin="${qtile_src_dir}/.venv/bin/qtile"
if [[ ! -x "${qtile_bin}" ]]; then
	echo "qtile bin not found in ${qtile_src_dir}/.venv/bin/"
	exit 1
fi

ln -s "${qtile_bin}" "${qtile_bin_dir}"

# Create .desktop entry
qtile_desktop_entry="/usr/share/xsessions/qtile.desktop"
sudo rm -f "$qtile_desktop_entry"

echo "[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling" | sudo tee "$qtile_desktop_entry" > /dev/null

echo "Qtile installation complete!"
