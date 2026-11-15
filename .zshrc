# Powerlevel10k instant prompt must precede shell initialization.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path PATH
path=("$HOME/.local/bin" $path)
for brew_prefix in /opt/homebrew /usr/local; do
  if [[ -x "$brew_prefix/bin/brew" ]]; then
    path=("$brew_prefix/bin" "$brew_prefix/sbin" $path)
    break
  fi
done
export ZSH="$HOME/.oh-my-zsh"
HIST_STAMPS="%T %d.%m.%y"
plugins=(git)
[[ ! -r "$ZSH/oh-my-zsh.sh" ]] || source "$ZSH/oh-my-zsh.sh"
[[ ! -r "$HOME/.atuin/bin/env" ]] || source "$HOME/.atuin/bin/env"
(( ! $+commands[atuin] )) || eval "$(atuin init zsh)"

for shell_file in   "$brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme"   "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  [[ ! -r "$shell_file" ]] || source "$shell_file"
done
[[ ! -r "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY HIST_IGNORE_SPACE HIST_IGNORE_DUPS HIST_NO_STORE
export BAT_THEME="base16"
(( ! $+commands[eza] )) || alias ls='eza --color=always --long --git --icons=always -s=modified'
(( ! $+commands[bat] )) || alias cat='bat'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
(( UID == 0 )) || alias reboot='sudo reboot'
alias dot='git -c core.fsmonitor=false --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Optional app paths; private and machine-specific overrides belong in .zshrc.local.
for app_bin in "$HOME/.antigravity/antigravity/bin" "$HOME/.antigravity-ide/antigravity-ide/bin"; do
  [[ ! -d "$app_bin" ]] || path=("$app_bin" $path)
done
export STM32_PRG_PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin"
[[ ! -r "$HOME/.zshrc.local" ]] || source "$HOME/.zshrc.local"
# Load syntax highlighting after widgets and local customizations.
[[ ! -r "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] || source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
unset brew_prefix shell_file app_bin
