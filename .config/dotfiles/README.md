# Dotfiles

Bare Git repository: ~/.dotfiles; working tree: ~. Only explicitly added paths are tracked.

## Daily use

- `dot-status`: tracked changes and branch status.
- `dot-save "message"`: syntax checks, tracked changes, diff, local commit.
- `dot push`: send manual commits. Every 30 minutes launchd also checks, commits and pushes.
- `dot add -- .config/example/config`: explicitly enroll a new reviewed file, then `dot commit`.
  dot-save refuses a pre-staged index so it cannot silently commit unrelated staging.
- `dot-check`: validate shell syntax.

Never use `dot add .` from the home directory. Local overrides live in ~/.zshrc.local
and ~/.bashrc.local. They are excluded by the repository-specific .config/dotfiles/gitignore, alongside credentials, histories and caches.

## Restore on a new Mac

Install Apple command-line tools (`xcode-select --install`) and Homebrew if needed.
Then, with GitHub SSH access configured:

```sh
git clone git@github.com:dlevchuk/dotfiles.git /tmp/my-dotfiles
bash /tmp/my-dotfiles/.local/bin/dot-bootstrap --with-apps
```

The script refuses an existing ~/.dotfiles, backs up conflicting tracked files under
~/.local/state/dotfiles/backups, deploys configs, installs shell dependencies with Brew,
clones Oh My Zsh if absent, checks syntax and enables the 30-minute agent.
Without --with-apps it skips Brew installation. Open a new terminal afterwards.
Brewfile contains shell essentials; Brewfile.apps is an optional installed-app snapshot:
`brew bundle --file=~/.config/dotfiles/Brewfile.apps`.

## Automation

`dot-install-agent` generates ~/Library/LaunchAgents/com.user.dotfiles-sync.plist.
It runs dot-save --auto at login and every 1800 seconds, commits only tracked files,
and pushes main. It never pulls, rebases, force-pushes or adds untracked files.
Errors stop the run. Existing staging requires manual review. Files remain staged if
validation/commit fails; inspect `dot diff --cached`, fix them and commit manually.
Logs: ~/.local/state/dotfiles/sync.log and sync.err. These logs are not committed.
SSH uses BatchMode and connection timeouts; an unavailable key/network fails visibly.

Inspect: `launchctl print gui/$(id -u)/com.user.dotfiles-sync`.
Disable: `launchctl bootout gui/$(id -u)/com.user.dotfiles-sync`.
Git fsmonitor is disabled specifically for this bare repository; global settings stay intact.
If dot-save is forcibly killed, verify its PID in save.pid before removing save.lock.

## Checks and recovery

GitHub Actions checks shell syntax on pushes and pull requests. Syntax checks do not
prove plugins work: a minimal-home startup check should also be run when editing .zshrc.
Local backups made during this setup contain original configs and agent configuration.
Restore individual files from backups, then inspect `dot diff` before saving.
The old chezmoi source at ~/.local/share/chezmoi was left intact; do not apply it over
these same files unless intentionally migrating away from bare Git.
