# Cheat Sheet

Quick reference for custom keybindings, aliases, and commands.

---

## Tmux

Prefix is `Ctrl+B` unless noted otherwise.

### Pane Navigation (no prefix needed)

| Key | Action |
|-----|--------|
| `Alt+Arrow` | Switch to pane in that direction |
| `Alt+Z` | Toggle zoom (fullscreen current pane) |

### Pane Management

| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontal (keeps current path) |
| `prefix + -` | Split vertical (keeps current path) |
| `prefix + Arrow` | Resize pane (repeatable — keep pressing) |
| `prefix + x` | Close current pane |
| `prefix + z` | Toggle zoom (default) |

### Windows

| Key | Action |
|-----|--------|
| `prefix + c` | New window (keeps current path) |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 1-9` | Jump to window by number |
| `prefix + ,` | Rename window |
| `prefix + &` | Close window |

### Sessions

| Command | Action |
|---------|--------|
| `tmux new -s name` | New named session |
| `tmux ls` | List sessions |
| `tmux attach -t name` | Attach to session |
| `tmux rename-session name` | Rename current session |
| `prefix + d` | Detach from session |
| `prefix + s` | Session picker |

### Copy Mode (vi keys)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank (copy) and exit |
| `q` | Exit copy mode |
| `/` | Search forward |
| `?` | Search backward |

### Session Notes

| Command | Action |
|---------|--------|
| `tnote some message` | Pin a note to the status bar |
| `tnote` | Clear the note |

### Other

| Key / Command | Action |
|---------------|--------|
| `prefix + r` | Reload tmux config |
| Mouse scroll | Scroll through history |
| Mouse click | Focus pane |
| Mouse drag | Resize pane borders |

---

## Vim

### Custom Key Mappings

| Key | Mode | Action |
|-----|------|--------|
| `;;` | Insert | Escape to normal mode |
| `//` | Normal | Open file explorer (netrw) |
| `\` | Normal | Toggle line numbers |
| `==` | Normal | Remove trailing whitespace |
| `--` | Normal | Toggle paste mode |
| `cc` | Normal | Remove Windows carriage returns (^M) |
| `Ctrl+J` | Normal | Jump to window below and maximize |
| `Ctrl+K` | Normal | Jump to window above and maximize |

### Code Snippet Abbreviations (insert mode)

| Type | Expands To |
|------|------------|
| `rif` | Perl/C if statement |
| `relse` | Perl/C else block |
| `rp` | Perl print statement |
| `bif` | Bash if statement |
| `bfor` | Bash for loop |
| `xdate` | Current date (2026-03-08) |
| `mdate` | Date and time (2026-03-08 14:30PM) |
| `rdate` | Full date (Saturday 2026-03-08) |

### Search

| Key / Command | Action |
|---------------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `*` | Search for word under cursor |
| `n` / `N` | Next / previous result |
| `/hello` | Case-insensitive (finds Hello, HELLO) |
| `/Hello` | Case-sensitive (smartcase kicks in) |

### Splits

| Command | Action |
|---------|--------|
| `:split` | Horizontal split (opens below) |
| `:vsplit` | Vertical split (opens right) |
| `Ctrl+W w` | Cycle through windows |
| `Ctrl+W =` | Equalize window sizes |

### Undo (persistent across sessions)

| Key / Command | Action |
|---------------|--------|
| `u` | Undo |
| `Ctrl+R` | Redo |
| `:earlier 5m` | Go back 5 minutes |
| `:later 5m` | Go forward 5 minutes |

### Useful Defaults

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit (confirms if unsaved) |
| `:wq` or `ZZ` | Save and quit |
| `:Explore` | File explorer |
| `:Sexplore` | Explorer in horizontal split |
| `:Vexplore` | Explorer in vertical split |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace with confirmation |

---

## Bash

### Navigation

| Alias | Action |
|-------|--------|
| `..` | cd .. |
| `...` | cd ../.. |
| `....` | cd ../../.. |
| `.....` | cd ../../../.. |
| `-` | cd - (previous directory) |
| `~` | cd ~ |

Note: `cd` auto-lists directory contents after changing.

### File Listing

| Alias | Action |
|-------|--------|
| `ls` | Colored output |
| `ll` | Detailed list, human-readable sizes |
| `la` | Show hidden files |
| `lsa` | Full details with colors |
| `l` | Columnar format |

### Git

| Alias | Action |
|-------|--------|
| `gs` | git status |
| `ga` | git add |
| `gc` | git commit |
| `gp` | git push |
| `gpull` | git pull |
| `gl` | git log (oneline, graph, decorated) |
| `gd` | git diff |
| `gb` | git branch |
| `gco` | git checkout |

### Functions

| Command | Action |
|---------|--------|
| `mkcd dirname` | Create directory and cd into it |
| `extract file.tar.gz` | Extract any archive type |
| `ff pattern` | Find files by name |
| `fd pattern` | Find directories by name |
| `search "text"` | Grep recursively for text |
| `diskuse` | Disk usage sorted by size |
| `topcommands` | Show your 10 most-used commands |
| `weather` | Current weather (or `weather "city"`) |
| `backup file` | Timestamped backup (file.backup-20260308-143000) |
| `tnote message` | Set tmux session note |
| `shrug` | You know what this does |

### Safety

`rm`, `cp`, `mv`, and `ln` all prompt for confirmation before overwriting.

### Smart Bash Features

- **Typo correction**: `cd /ect` corrects to `cd /etc`
- **Case-insensitive glob**: `ls doc*` matches Documents, DOCS, etc.
- **Auto cd**: Type a directory name to cd into it (no `cd` needed)
- **History**: 10,000 lines, timestamped, no duplicates

### Local Customizations

Machine-specific config goes in `~/.bash_profile_local` (auto-sourced, not tracked in git).

### Repo Sync (FPMoss <-> FPZeph)

`bin/repo-sync` keeps the repos in `~/workspace` in sync through GitHub. A systemd user timer runs it 30s after startup and then hourly. It only ever fast-forwards and clones; anything it won't touch (unpushed, diverged, blocked by local edits) is listed at login.

| Command | Action |
|---------|--------|
| `repo-sync` | Sync now |
| `repo-sync status` | Result of the last sync + next scheduled run |
| `repo-sync log` | Tail `~/.local/state/repo-sync/sync.log` |
| `repo-sync install` | Install timer + login summary (new machine: `git pull && bin/repo-sync install`) |
| `repo-sync uninstall` | Remove them |

When the other machine is online over Tailscale it is asked over ssh for its repo state: repos missing here get cloned, and commits it hasn't pushed are flagged. Its last report is cached, so that still works while it is off.

Overrides go in `~/.config/repo-sync/config`, e.g. `REPO_SYNC_IGNORE="loa-logs"` or `REPO_SYNC_AUTO_PUSH=1` (see the header of `bin/repo-sync`).

---

## Claude Code

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Enter` | Send message |
| `Shift+Enter` | New line |
| `Ctrl+C` | Cancel current generation |
| `Ctrl+L` | Clear conversation |
| `Escape` | Cancel input / interrupt |
| `Up Arrow` | Previous message |
| `/` | Open slash command menu |

### Useful Slash Commands

| Command | Action |
|---------|--------|
| `/help` | Help and usage info |
| `/clear` | Clear conversation |
| `/compact` | Compress context to save tokens |
| `/cost` | Show token usage and cost |
| `/memory` | Show CLAUDE.md files |
| `/fast` | Toggle fast mode (same model, faster output) |

### Permission Model

Auto-allowed without prompting: `Read`, `Glob`, `Grep`, `WebSearch`, `WebFetch`, `mcp__salesforce-netsuite__*`, `tmux set-environment`, `tmux show-environment`.

Everything else (file edits, bash commands, git operations) prompts for approval.

### Tips

- Start messages with `#` to add a note without triggering a response
- Use `Shift+Tab` to cycle through tool approval options
- Claude can set/read tmux session notes directly via `tmux set-environment TNOTE "message"`
