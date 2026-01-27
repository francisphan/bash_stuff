# Bash Stuff - Improvements Documentation

This document describes the enhanced versions of the configuration files and how to use their new features.

## Table of Contents
- [bash_profile2 - Enhanced Bash Profile](#bash_profile2---enhanced-bash-profile)
- [vimrc2 - Enhanced Vim Configuration](#vimrc2---enhanced-vim-configuration)
- [Installation](#installation)
- [Quick Reference](#quick-reference)

---

## bash_profile2 - Enhanced Bash Profile

### What's New

#### 1. Cross-Platform Compatibility
Automatically detects your operating system and adjusts commands accordingly:
- **macOS**: Uses `ls -G` for colored output
- **Linux**: Uses `ls --color=auto`
- **Windows (Cygwin/MinGW)**: Compatible with Windows subsystems

#### 2. Enhanced History Management
```bash
HISTSIZE=10000              # Store 10,000 commands in memory
HISTFILESIZE=20000          # Store 20,000 commands in file
HISTCONTROL=ignoreboth:erasedups  # No duplicates or commands starting with space
HISTTIMEFORMAT="%F %T "     # Add timestamps to history
```

**Usage:**
- Your command history is much larger and includes timestamps
- Duplicate commands are automatically removed
- History is appended (not overwritten) when you close a terminal

#### 3. Smart Bash Options
```bash
shopt -s cdspell      # Auto-corrects typos: 'cd /ect' → 'cd /etc'
shopt -s autocd       # Type 'Documents' instead of 'cd Documents' (bash 4+)
shopt -s nocaseglob   # Case-insensitive filename matching
```

#### 4. Safety Aliases
Prevents accidental file loss:
```bash
rm file.txt    # Now asks for confirmation
cp file1 file2 # Asks before overwriting
mv old new     # Asks before overwriting
```

#### 5. Quick Navigation
```bash
..              # cd ..
...             # cd ../..
....            # cd ../../..
-               # Go back to previous directory
```

Auto-list files after changing directory.

#### 6. Enhanced Git Integration

**Aliases:**
```bash
gs              # git status
ga              # git add
gc              # git commit
gp              # git push
gpull           # git pull
gl              # git log --oneline --graph --decorate (beautiful log)
gd              # git diff
gb              # git branch
gco             # git checkout
```

**Smart Prompt:**
```
[user@host] /current/path (git-branch)*
$
```
The `*` appears when you have uncommitted changes.

#### 7. Useful Functions

##### File Management
```bash
mkcd mydir              # Create directory and cd into it
backup file.txt         # Creates file.txt.backup-20260127-123045
extract archive.tar.gz  # Universal archive extractor (zip, tar, gz, bz2, etc.)
```

##### Search Functions
```bash
ff pattern              # Find files by name
fd pattern              # Find directories by name
search "text"           # Search for text in files recursively
```

##### System Information
```bash
diskuse                 # Show disk usage of current directory, sorted by size
topcommands             # Show your 10 most-used commands
weather                 # Check weather (requires curl)
weather "New York"      # Check weather for a city
```

#### 8. Better Command Aliases
```bash
ll              # ls -lh (detailed list, human-readable sizes)
la              # ls -A (show hidden files)
c               # clear
h               # history
e               # Open in editor (vim)
v               # vim
```

#### 9. PATH Management
Safely add directories to PATH without duplicates:
```bash
pathappend /new/path    # Add to end of PATH
pathprepend /new/path   # Add to beginning of PATH
```

Automatically adds `~/bin` and `~/.local/bin` if they exist.

#### 10. Local Customizations
Create `~/.bash_profile_local` for machine-specific settings that won't be overwritten:
```bash
# Example ~/.bash_profile_local
export MY_CUSTOM_VAR="value"
alias myalias="my command"
```

---

## vimrc2 - Enhanced Vim Configuration

### What's New

#### 1. Modern Defaults
```vim
set number              " Line numbers
set relativenumber      " Relative line numbers for quick jumps
set cursorline          " Highlight current line
set scrolloff=3         " Keep 3 lines visible above/below cursor
```

#### 2. Better Search
```vim
set ignorecase          " Case-insensitive search
set smartcase           " Unless you use uppercase
```
**Example:** Searching for `hello` finds "Hello", "HELLO", "hello"
But searching for `Hello` only finds "Hello"

#### 3. Persistent Undo
Your undo history survives even after closing vim!
```vim
set undofile            " Save undo history to file
set undodir=~/.vim/undo " Location of undo files
```

#### 4. Spaces vs Tabs
```vim
set expandtab           " Use spaces instead of tabs
set tabstop=4           " 4 spaces per tab
set shiftwidth=4        " 4 spaces for indentation
```

#### 5. Enhanced Command Line
```vim
set wildmenu            " Visual autocomplete menu
set confirm             " Confirm instead of error
set autoread            " Auto-reload files changed outside vim
```

#### 6. Better Splits
```vim
set splitbelow          " New horizontal splits open below
set splitright          " New vertical splits open to right
```

#### 7. Fixed Key Mappings

All mappings now use non-recursive versions (safer):
```vim
;;                      " Quick escape from insert mode
//                      " Open file explorer
\                       " Toggle line numbers
==                      " Remove trailing whitespace
--                      " Toggle paste mode
cc                      " Remove Windows carriage returns
Ctrl-J / Ctrl-K         " Navigate between windows
```

#### 8. Improved Code Snippets

Type these abbreviations in insert mode:
```vim
rif     " Creates: if () {
        "
        "          }
        " Cursor positioned inside parentheses

relse   " Creates: else
        "          {
        "          }

bif     " Creates: if [  ]; then
        "            fi
        " Cursor positioned inside brackets

bfor    " Creates: for i in ""; do
        "            done

xdate   " Inserts: 2026-01-27
mdate   " Inserts: 2026-01-27 08:30AM
rdate   " Inserts: Monday 2026-01-27
```

#### 9. Smart Features
- Returns to last edit position when reopening files
- Automatically creates undo directory if missing
- Better window navigation with Ctrl-J/K

---

## Installation

### Quick Install
```bash
cd bash_stuff
./setup.sh
```

The setup script will:
1. Offer to backup your existing configurations
2. Let you choose between original and enhanced versions
3. Install your selected configurations
4. Create necessary directories (like `~/.vim/undo`)

### Manual Install

**For bash_profile2:**
```bash
cp profiles/bash_profile2 ~/.bash_profile
source ~/.bash_profile
```

**For vimrc2:**
```bash
cp profiles/vimrc2 ~/.vimrc
mkdir -p ~/.vim/undo
```

---

## Quick Reference

### Bash Profile 2 - Most Useful Commands

| Command | Description |
|---------|-------------|
| `..` | Go up one directory |
| `...` | Go up two directories |
| `-` | Go to previous directory |
| `mkcd mydir` | Create and enter directory |
| `backup file.txt` | Quick backup with timestamp |
| `extract archive.zip` | Extract any archive type |
| `ff pattern` | Find files by name |
| `search "text"` | Search for text in files |
| `diskuse` | Show disk usage sorted |
| `topcommands` | Your most-used commands |
| `gs` | git status |
| `gl` | Beautiful git log |
| `weather` | Check weather |

### Vimrc2 - Most Useful Keys

| Key | Mode | Description |
|-----|------|-------------|
| `;;` | Insert | Escape to normal mode |
| `//` | Normal | Open file explorer |
| `\` | Normal | Toggle line numbers |
| `==` | Normal | Remove trailing spaces |
| `--` | Normal | Toggle paste mode |
| `Ctrl-J` | Normal | Move to window below |
| `Ctrl-K` | Normal | Move to window above |

### Vimrc2 - Code Snippets

| Type | Result |
|------|--------|
| `rif` | Perl/C if statement |
| `relse` | Perl/C else block |
| `bif` | Bash if statement |
| `bfor` | Bash for loop |
| `xdate` | Insert today's date |

---

## Troubleshooting

### Bash Profile Not Loading
If bash_profile2 doesn't load automatically, your system might use `.bashrc` instead:
```bash
echo 'source ~/.bash_profile' >> ~/.bashrc
```

### Git Prompt Not Showing
Make sure git is installed:
```bash
git --version
```

### Vim Undo Not Working
The undo directory might not exist:
```bash
mkdir -p ~/.vim/undo
chmod 700 ~/.vim/undo
```

### Colors Not Showing
Your terminal might not support colors. Try:
```bash
export TERM=xterm-256color
```

---

## Differences Between Versions

### bash_profile vs bash_profile2

| Feature | Original | Enhanced |
|---------|----------|----------|
| Basic aliases | ✅ | ✅ |
| Git prompt | ✅ | ✅ (with dirty indicator) |
| Cross-platform | ❌ | ✅ |
| Enhanced history | ❌ | ✅ |
| Safety aliases | ❌ | ✅ |
| Useful functions | ❌ | ✅ (15+ functions) |
| Git aliases | ❌ | ✅ |
| PATH management | ❌ | ✅ |

### vimrc vs vimrc2

| Feature | Original | Enhanced |
|---------|----------|----------|
| Syntax highlighting | ✅ | ✅ |
| Line numbers | ❌ | ✅ (with relative) |
| Persistent undo | ❌ | ✅ |
| Smart search | ❌ | ✅ |
| Spaces vs tabs | ❌ | ✅ (spaces enabled) |
| Safe mappings | ❌ | ✅ (non-recursive) |
| Fixed snippets | ⚠️ | ✅ |
| Better history | 75 | 1000 |
| Auto-reload files | ❌ | ✅ |

---

## Contributing

If you have suggestions for improvements:
1. Fork the repository
2. Create your feature branch
3. Test your changes
4. Submit a pull request

---

## License

These configurations are provided as-is for personal use. Feel free to modify and share!
