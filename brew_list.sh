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
  atuin awscli bash-completion bat brotli c-ares ca-certificates cairo cask cffi coreutils cryptography diffutils docker docker-completion docker-compose duf emacs eza flux fontconfig freetype gdbm gettext gh giflib glib gmp gnutls gping graphite2 gsl harfbuzz helm htop icu4c@75 icu4c@76 jansson jpeg-turbo jq kubernetes-cli libevent libgit2 libgit2@1.7 libidn2 liblinear libnghttp2 libpng libssh2 libtasn1 libtiff libtommath libunistring libuv libx11 libxau libxcb libxdmcp libxext libxrender little-cms2 lua lz4 lzo maven midnight-commander mpdecimal mtr ncurses nettle nmap node nvm oniguruma openjdk openssl@3 p11-kit p7zip pcre pcre2 pixman powerlevel10k pycparser python-packaging python@3.8 python@3.11 python@3.12 python@3.13 readline redis ripgrep s-lang sqlite tailspin tcl-tk telnet terraform terragrunt tree tree-sitter unbound wget xorgproto xz zsh zsh-autosuggestions zsh-syntax-highlighting zstd
)

for formula in "${formulae[@]}"; do
  brew install "$formula"
done

# Install casks
casks=(
  alt-tab appcleaner caffeine coconutbattery dbeaver-community discord google-chrome iterm2 karabiner-elements latest lens multipass notion obsidian raycast shottr sloth sublime-text telegram visual-studio-code vlc windterm
)

for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done

# Cleanup
brew cleanup

echo "Installation complete!"
