[[ ! -f "$HOME/.bash-preexec.sh" ]] || source "$HOME/.bash-preexec.sh"
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi
export PATH="$HOME/.local/bin:$PATH"
alias dot='git -c core.fsmonitor=false --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
[[ ! -f "$HOME/.bashrc.local" ]] || source "$HOME/.bashrc.local"
