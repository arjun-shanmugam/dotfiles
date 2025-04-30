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

# Install euporie notebook
source ${VIRTUAL_ENV_DIR}/python310/bin/activate
pip install euporie
alias nb='python3 -m ipykernel install --name python310 && euporie-notebook'
