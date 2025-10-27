qtile_src_dir="${HOME}/.local/src/qtile"
qtile_repo_dir="${HOME}/.local/src/qtile/qtile"
link_qtile_bin_to="${HOME}/.local/bin"

mkdir -p "${qtile_src_dir}"

if [[ ! -d "${qtile_repo_dir}" ]]; then
	git clone https://github.com/qtile/qtile.git "${qtile_repo_dir}"
fi
rm -rf ${qtile_repo_dir}/build
rm -rf ${qtile_repo_dir}/qtile.egg-info

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

# Set up virtual environment
if [[ ! -d "${qtile_src_dir}/.venv" ]]; then
	python3 -m venv "${qtile_src_dir}/.venv"
fi
source "${qtile_src_dir}/.venv/bin/activate"
if [[ "$(which python)" != "${HOME}/.local/src/qtile/.venv/bin/python" ]]; then
	echo "venv is not properal activated"
	echo "$(which python)"
	exit 1
fi
pip uninstall -y qtile

# Install dependencies
sudo apt install -y \
	"python${python_version}-venv" \
	python3-cffi \
	libpangocairo-1.0-0 || exit 1

# Set up virtual environment
python3 -m venv "${qtile_src_dir}/.venv"
source "${qtile_src_dir}/.venv/bin/activate"

# Install Python dependencies
pip install \
	xcffib \
	pulsectl-asyncio \
	numpy \
	psutil \
	iwlib || exit 1

cd "${qtile_repo_dir}"
git fetch --tags
git checkout v0.33.0
pip install .

qtile_bin="${qtile_src_dir}/.venv/bin/qtile"
if [[ ! -x "${qtile_bin}" ]]; then
        echo "qtile bin not found in ${qtile_src_dir}/.venv/bin/"
        exit 1
fi

unlink "${link_qtile_bin_to}/qtile"
ln -s "${qtile_bin}" "${link_qtile_bin_to}"

# Create .desktop entry
# qtile_desktop_entry="/usr/share/xsessions/qtile.desktop"
# sudo rm -f "$qtile_desktop_entry"
#
# echo "[Desktop Entry]
# Name=Qtile
# Comment=Qtile Session
# Exec=qtile start
# Type=Application
# Keywords=wm;tiling" | sudo tee "$qtile_desktop_entry" > /dev/null
#
# echo "Qtile installation complete!"
