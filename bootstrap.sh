#!/bin/bash
# The idea is that we can just do ./bootstrap.sh from the root of this git repo and
# have a lot of the setup run from there!
# Of course there's a lot that's not in here yet.

GH_KEY_TYPE="ed25519"
GH_KEY_SUFFIX="gh"

# set -euo pipefail

# https://github.com/pqrs-org/Karabiner-Elements/issues/1225#issuecomment-460170227
# If this isn't working as expected...


case "$SHELL" in
    "/bin/bash")
      echo "Shell is already /bin/bash, yay. Continuing on."
      ;;
    *)
      echo "The default shell is not bash: $SHELL"
      echo "Running chsh to set default shell to bash."
      echo "This script might not work, but probably will."
      chsh -s /bin/bash
      ;;
esac


read -p "Enter github user name for ssh config: " gh_username
read -p "Enter email address for github key: " email
echo "Read username: ${gh_username} - email: ${email}"
sleep 2
echo "Generating ssh key for github access..."

GH_KEY_PATH="$HOME/.ssh/id_${GH_KEY_TYPE}_${GH_KEY_SUFFIX}"

ssh-keygen -t "${GH_KEY_TYPE}" -C "${email}" -f "${GH_KEY_PATH}"

# Add github ssh config to ~/.ssh/config
cat << EOF >> "$HOME/.ssh/config"
Host ${gh_username}.github.com
  Hostname github.com
  PreferredAuth publickey
  IdentityFile ${GH_KEY_PATH}

EOF

eval "$(ssh-agent -s)"
ssh-add -K "${GH_KEY_PATH}"

echo 'SSH Key for Github added to ssh, printing public key to terminal & using pbcopy to insert it into copy-paste buffer'
cat ${GH_KEY_PATH}.pub
pbcopy < ${GH_KEY_PATH}.pub

read -p 'Press enter once you add the new key to your hosted git: ' dummyvar

function osx_setup() {
    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Use brew bundle install (uses Brewfile)
    brew bundle install --verbose

    # Allow key repeat
    defaults write -g ApplePressAndHoldEnabled -bool false
    # And for vscode
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

    # Dracula iterm theme
    git clone https://github.com/dracula/iterm.git
    read -p "Please open iterm2 and set the dracula theme on your profile: "


    # Tell them to open and allow karabiner to set up its folders & perms
    read -p "Please open karabiner-elements and grant it the perms it asks for - any key once that's done: "
    cp -r $(pwd)/home/complex_modifications ~/.config/karabiner/assets/

    read -p "OK, now try to add or enable the karabiner modification for caps-lock/ctrl: "

}

# Homeshick!
# Now this is kind of weird, because this means you'll have 2 copies of this repo. Oh well.
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone kemcbride/dotfiles

# OS-specific stuff:
OS_NAME=$(uname -s)
case "$OS_NAME" in
    "Darwin")
        echo "This is a macOS system."
        osx_setup
        ;;
    "Linux")
        echo "This is a Linux system."
        echo "TODO - I haven't set up package setup/installation for linux"
        ;;
    *)
        echo "This is an unknown operating system: $OS_NAME"
        echo "TODO... slash maybe NEVERDO - I have no idea how to even prep that."
        ;;
esac

echo "Running neovim and attempting to set up Plug packages..."
nvim --headless +PlugInstall +qa

echo 'Done'
