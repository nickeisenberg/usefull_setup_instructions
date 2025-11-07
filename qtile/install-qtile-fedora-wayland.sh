#--------------------------------------------------
# Set these variables
#--------------------------------------------------

# qtile_save_root is the location where to clone the qtile repo too. A virtual
# env will also be made in the localtion which will be used for the qtile installation.
# So after install, you will have
# ./qtile
# |__qtile (the repo)
# |__.venv (the venv used for installing qtile)
qtile_save_root="${HOME}/qtile"

# which branch of the repo do you want to install
branch="master"

# where do you want a symlink of the qtile bin to be linked to. This the location
# does not exist, the script will mkdir -p.
link_qtile_bin_to="${HOME}/.local/bin"

#--------------------------------------------------
# nothing below needs to be set unless there are bugs with the install
#--------------------------------------------------

if [[ ! -d ${link_qtile_bin_to} ]]; then
	mkdir -p ${link_qtile_bin_to}
fi

mkdir -p "${qtile_save_root}"

qtile_repo_dir="${qtile_save_root}/qtile"
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
if [[ ! -d "${qtile_save_root}/.venv" ]]; then
	python3 -m venv "${qtile_save_root}/.venv"
fi

source "${qtile_save_root}/.venv/bin/activate"
if [[ "$(which python)" != "${qtile_save_root}/.venv/bin/python" ]]; then
        echo "venv is not properly activated"
        echo "$(which python)"
        exit 1
fi
pip uninstall -y qtile

# for v0.33.0
# wlroots0.17 \
# wlroots0.17-devel \
sudo dnf install -y \
	wlroots \
	wlroots-devel \
	wayland-protocols-devel \
	libffi-devel \
	cairo-devel \
	pkg-config \
	gcc \
	python3-devel

# Install Python dependencies
pip install \
    pulsectl-asyncio \
    numpy \
    psutil || exit 1

cd "${qtile_repo_dir}"
git fetch --all
git fetch --tags
git checkout ${branch}
if [[ ${branch} == *"v0."* ]]; then
	# this is only for v0.33 and most likely less
	pip install --no-cache-dir . --config-settings=backend=wayland qtile[wayland]
else
	# this is currently for master which is v0.33.1.dev
	pip install . --config-settings=backend=wayland
fi

qtile_bin="${qtile_save_root}/.venv/bin/qtile"
if [[ ! -x "${qtile_bin}" ]]; then
    echo "qtile bin not found in ${qtile_save_root}/.venv/bin/"
    exit 2
fi

if [[ -f "${link_qtile_bin_to}/qtile" ]]; then
	unlink "${link_qtile_bin_to}/qtile"
fi
ln -s "${qtile_bin}" "${link_qtile_bin_to}"
