# Dependencies
* `sudo apt install cmake unzip gettext`

* `node` must be installed. The follwoing instructions are from
  https://heynode.com/tutorial/install-nodejs-locally-nvm/

  1. `curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh`

  2. `bash install_nvm.sh`

  3. Add the following to the `.bash_profile`
     ```
     export NVM_DIR="$HOME/.nvm"
     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
     ```

  4. `source ~/.bash_profile`

  5. `npm --version` and `node --version` will now work.

# Installing from source
* Clone neovim, `git clone https://github.com/neovim/neovim.git`

* `git fetch --all`

* `git pull`

* use `git branch -r` to check all releases. Then pick a release
  `git checkout release-0.9`.

* `make distclean && make CMAKE_BUILD_TYPE=Release`

* `sudo make install`

* `nvim` should now work.
