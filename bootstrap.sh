#!/bin/bash
# The idea is that we can just do ./bootstrap.sh from the root of this git repo and
# have a lot of the setup run from there!
# Of course there's a lot that's not in here yet.

set -euxo pipefail

# https://github.com/pqrs-org/Karabiner-Elements/issues/1225#issuecomment-460170227
# If this isn't working as expected...
cp -r $(pwd)/home/complex_modifications ~/.config/karabiner/assets/


# Ideas of things to add:
# - ligature/terminal font setup/download + installation
# - terminal colors setup/download - Dracula is what I use
# - neovim installation + PlugInstall calls
# - https://github.com/ibraheemdev/modern-unix - various tools installation?
# - chsh -s /bin/bash ?? (i mean who knows how long i'll be on bash...)
