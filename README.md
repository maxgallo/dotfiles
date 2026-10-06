# Max's dotfiles

My personal setup for macOS and Linux: shell, editor, terminal, git and app configuration, plus the scripts that install them. Most of it works on both; the macOS-only parts are listed separately below.

Each tool has its own small install script instead of one big `install-everything.sh`. That way I can add or remove one piece at a time, a failure in one script can't leave the whole machine half-configured, and problems are easy to isolate.

## Requirements

- **macOS or Linux**. The scripts install packages with Homebrew on both (on Linux that's [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)).
- **The repo cloned at `~/github/maxgallo/dotfiles`**. Configs are symlinked from there; the path is set in [`utils/config.sh`](utils/config.sh), so change it if you clone it elsewhere.
- [Homebrew](https://brew.sh) is installed automatically by the scripts that need it.

> **Linux note:** a few configs still point at macOS-specific paths, such as `/opt/homebrew/bin/fish` (tmux, ghostty, herdr), `pbcopy` (tmux) and `/Users/max.gallo/...` (fish, bash, zsh). Adjust those on a Linux machine.

## Getting started

```bash
mkdir -p ~/github/maxgallo
git clone git@github.com:maxgallo/dotfiles.git ~/github/maxgallo/dotfiles
cd ~/github/maxgallo/dotfiles

./brew.sh        # CLI tools first, other scripts rely on them (jq, fzf, ...)
./fish.sh        # then the shell
./git.sh
./vim.sh
# ...pick whatever else you need from the list below
```

Run the scripts **from the repo root** (and the ones in `more/` from inside `more/`), because they source the helpers in `utils/` with relative paths.

### Uninstalling

Every script accepts `--remove` (or `-r`) to undo what it did. It asks for confirmation first.

```bash
./tmux.sh --remove
```

## Scripts

### macOS and Linux

| Script | What it does | Config files |
| --- | --- | --- |
| `brew.sh` | Installs CLI tools (`bat`, `fd`, `fzf`, `jq`, `tldr`, `tfenv`, ...) | – |
| `git.sh` | Installs git + `diff-so-fancy`, links the global config and gitignore, asks for your name and email (kept in the untracked `~/.gitconfig.local`) | [`git/`](git) → `~/.gitconfig`, `~/.gitignore_global` |
| `fish.sh` | Installs fish, [Fisher](https://github.com/jorgebucaran/fisher) and the `done` plugin, links config and functions | [`fish/`](fish) → `~/.config/fish/` |
| `nvm.sh` | Installs [nvm.fish](https://github.com/jorgebucaran/nvm.fish) and the latest Node (run after `fish.sh`) | – |
| `yarn.sh` | Installs global yarn packages (`prettier`, `nodemon`, `serverless`) | – |
| `vim.sh` | Links the vim config; plugins are installed by [vim-plug](https://github.com/junegunn/vim-plug) on first launch | [`vim/`](vim) → `~/.vimrc`, `~/.vim/coc-settings.json` |
| `tmux.sh` | Installs tmux, [TPM](https://github.com/tmux-plugins/tpm) and its plugins, links the config | [`tmux/.tmux.conf`](tmux/.tmux.conf) → `~/.tmux.conf` |
| `bash.sh` | Minimal bash setup | [`bash/`](bash) → `~/.bashrc`, `~/.bash_profile` |
| `zsh.sh` | Minimal zsh setup | [`zsh/`](zsh) → `~/.zshrc`, `~/.zshenv` |
| `herdr.sh` | Links the Herdr config and reloads a running server | [`herdr/config.toml`](herdr/config.toml) → `~/.config/herdr/` |
| `claude.sh` | Links the Claude Code status line and registers it in `~/.claude/settings.json` | [`claude/statusline.sh`](claude/statusline.sh) → `~/.claude/` |

### macOS only

| Script | What it does | Config files |
| --- | --- | --- |
| `macos.sh` | Applies macOS defaults: dark mode, hot corners, Dock apps, trackpad, Finder, menu bar | – |
| `brew-cask.sh` | Installs GUI apps through Homebrew casks (browsers, Slack, Docker, 1Password, ...) | – |
| `iterm.sh` | Installs iTerm2 with my dynamic profiles | [`iterm/`](iterm) → iTerm2 `DynamicProfiles/` |
| `karabiner.sh` | Installs Karabiner-Elements for key remapping | [`karabiner/karabiner.json`](karabiner/karabiner.json) → `~/.config/karabiner/` |

### Extras (`more/`)

Things I don't install on every machine.

| Script | What it does | Platform |
| --- | --- | --- |
| `more/awscli.sh` | Installs the AWS CLI (fish completion lives in `config.fish`) | macOS, Linux |
| `more/eslint.sh` | Installs ESLint + TypeScript globally and links [`more/.eslintrc.json`](more/.eslintrc.json) | macOS, Linux |
| `more/mas.sh` | Installs Mac App Store apps through [`mas`](https://github.com/mas-cli/mas) | macOS |
| `more/shuttle.sh` | Installs [Shuttle](https://github.com/fitztrev/shuttle), the SSH shortcut menu | macOS |

## Config without a script

- [`ghostty/config`](ghostty/config): [Ghostty](https://ghostty.org) config, link it to `~/.config/ghostty/config` by hand.
- [`mitmproxy/README.md`](mitmproxy/README.md): mitmproxy cheatsheet (proxy setup on macOS, iOS Simulator and Android, plus key bindings).

## Fish

The fish config sets aliases for the tools above (`cat` → `bat`, `ping` → `prettyping`, ...), vi key bindings, PATH, [Atuin](https://atuin.sh) history and the [Hydro](https://github.com/jorgebucaran/hydro) prompt colors.

Custom functions in [`fish/functions`](fish/functions):

| Function | What it does |
| --- | --- |
| `bip` / `bup` / `brp` | Install / update / remove brew packages picked with fzf |
| `kp` | Kill processes picked with fzf |
| `agr <from> <to>` | Search and replace across a folder (uses `ag`) |
| `encrypt-file` / `decrypt-file` | Encrypt or decrypt a file with OpenSSL AES-256 |
| `clpr` | Open a draft PR using the current branch's CHANGELOG entry |

### Secrets

Tokens and other secrets go in `~/.config/fish/secrets.fish`, which is gitignored and loaded by `config.fish` if it exists. Start from the example:

```bash
cp fish/secrets.fish.example fish/secrets.fish
```

## Repo layout

```
*.sh       one install script per tool (run from the repo root)
more/      optional install scripts (run from inside more/)
utils/     helpers sourced by the scripts: logging, confirm prompt, brew & file helpers
<tool>/    the config files that get symlinked into $HOME
```

## Thanks to

- Project that made me start: https://github.com/bdougherty/dotfiles
- Article about improvements: https://remysharp.com/2018/08/23/cli-improved
- Huge dotfiles collection: https://github.com/mathiasbynens/dotfiles
- Where I copied Karabiner stuff: https://github.com/rkalis/dotfiles
- [@simmo](https://github.com/simmo) for the Claude Code status line
