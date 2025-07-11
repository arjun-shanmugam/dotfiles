#!/bin/bash

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Update neovim config
rm -rf /home/arjun.shanmugam/.local/state/nvim
mkdir /home/arjun.shanmugam/.local/state/nvim
curl -L -o /home/arjun.shanmugam/.local/state/nvim.tar.gz https://github.com/arjun-shanmugam/dotfiles/raw/refs/heads/main/nvim.tar.gz
tar -xzf /home/arjun.shanmugam/.local/state/nvim.tar.gz -C /home/arjun.shanmugam/.local/state
tar -xzf /home/arjun.shanmugam/.local/state/nvim.tar.gz -C /home/arjun.shanmugam/.config
cd ~

# Create alias 
alias nvim='source ${VIRTUAL_ENV_DIR}/python310/bin/activate && /opt/nvim-linux-x86_64/bin/nvim'
export VIRTUAL_ENV="${VIRTUAL_ENV_DIR}/python310"

# Add copilot token


# Install tpix 
cd
wget https://github.com/jesvedberg/tpix/releases/download/v1.0.0/tpix-1.0.0-x86_64-linux.tar.gz
tar xzf tpix-1.0.0-x86_64-linux.tar.gz
alias tpix='~/tpix'

# Install Node JS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22
# Verify the Node.js version:
node -v # Should print "v22.17.0".
nvm current # Should print "v22.17.0".
# Verify npm version:
npm -v # Should print "10.9.2".
