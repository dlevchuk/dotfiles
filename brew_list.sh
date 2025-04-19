#!/bin/bash

# Exit on error
set -e

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Detect architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Update and install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || handle_error "Failed to install Homebrew"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ "$ARCH" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Verify Homebrew installation
if ! command -v brew &>/dev/null; then
    handle_error "Homebrew installation failed"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update || handle_error "Failed to update Homebrew"
brew upgrade || handle_error "Failed to upgrade Homebrew packages"

# Install formulae
formulae=(
    atuin
    awscli
    bash-completion
    bat
    docker
    docker-completion
    docker-compose
    duf
    eza
    flux
    gping
    helm
    htop
    jq
    kubernetes-cli
    midnight-commander
    mtr
    nmap
    powerlevel10k
    ripgrep
    tailspin
    telnet
    terraform
    terragrunt
    tree
    wget
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
)

echo "Installing formulae..."
for formula in "${formulae[@]}"; do
    echo "Installing $formula..."
    brew install "$formula" || handle_error "Failed to install $formula"
done

# Install casks
casks=(
    appcleaner
    coconutbattery
    dbeaver-community
    discord
    google-chrome
    iterm2
    karabiner-elements
    lens
    obsidian
    raycast
    shottr
    sloth
    telegram
    visual-studio-code
    vlc
)

#alt-tab caffeine multipass notion sublime-text windterm

echo "Installing casks..."
for cask in "${casks[@]}"; do
    echo "Installing $cask..."
    brew install --cask "$cask" || handle_error "Failed to install $cask"
done

# Cleanup
echo "Cleaning up..."
brew cleanup || handle_error "Failed to clean up"

echo "Installation complete!"
