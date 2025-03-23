#!/bin/bash

# Update and install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
brew update
brew upgrade

# Install formulae
formulae=(
  atuin awscli bash-completion bat docker docker-completion docker-compose duf eza flux gping helm htop jq kubernetes-cli midnight-commander mtr nmap powerlevel10k ripgrep  tailspin telnet terraform terragrunt tree  wget  zsh zsh-autosuggestions zsh-syntax-highlighting 
)

for formula in "${formulae[@]}"; do
  brew install "$formula"
done

# Install casks
casks=(
  appcleaner coconutbattery dbeaver-community discord google-chrome iterm2 karabiner-elements lens obsidian raycast shottr sloth telegram visual-studio-code vlc 
)

#alt-tab caffeine multipass notion sublime-text windterm

for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done

# Cleanup
brew cleanup

echo "Installation complete!"
