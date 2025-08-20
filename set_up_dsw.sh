#!/bin/bash
deactivate ; pyenv deactivate ; ~/arjun.shanmugam_nfs/dotfiles/install ; deactivate ; pyenv deactivate ; source $VIRTUAL_ENV_DIR/python310/bin/activate ; pip install black ; source ~/.path ; export PATH="$VIRTUAL_ENV_DIR/python310/bin:$PATH"
