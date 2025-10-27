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

# Set up virtual environment
python3 -m venv "${qtile_src_dir}/.venv"
source "${qtile_src_dir}/.venv/bin/activate"

if [[ "$(which python)" != "${HOME}/.local/src/qtile/.venv/bin/python" ]]; then
        echo "venv is not properly activated"
        echo "$(which python)"
        exit 1
fi

sudo dnf install \
	cairo-devel \
    wayland-protocols-devel

# Install Python dependencies
pip install \
        xcffib \
        pulsectl-asyncio \
        numpy \
        psutil || exit 1

pip install /home/nicholas/qtile --config-settings=backend=wayland

# for non-fedora
# pip install iwlib

qtile_bin="${qtile_src_dir}/.venv/bin/qtile"
if [[ ! -x "${qtile_bin}" ]]; then
        echo "qtile bin not found in ${qtile_src_dir}/.venv/bin/"
        exit 1
fi

unlink "${qtile_bin_dir}/qtile"
ln -s "${qtile_bin}" "${qtile_bin_dir}"
