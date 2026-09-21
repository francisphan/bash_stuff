#!/bin/bash

############### Bash Stuff Setup Script ###############
# Installs bash, vim, tmux, and claude configuration files

# Prevent running as root
if [[ $EUID -eq 0 ]]; then
    echo "It is preferred you do not run this script as root as this repo is not meant for root"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

get_choice() {
    local prompt="$1"
    local valid_choices="$2"
    local choice

    while true; do
        read -p "$prompt" choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [[ "$valid_choices" == *"$choice"* ]]; then
            echo "$choice"
            return 0
        else
            print_warning "Invalid choice. Please try again."
        fi
    done
}

# Helper to back up and install a dotfile
install_dotfile() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [[ -f "$dest" ]]; then
        print_warning "Found existing $dest"
        RESP=$(get_choice "Do you want to replace it? (y/n): " "yn")
    else
        RESP="y"
    fi

    if [[ "$RESP" == "y" ]]; then
        if [[ -f "$dest" ]]; then
            BACKUP_FILE="${dest}.backup-$(date +%Y%m%d-%H%M%S)"
            cp "$dest" "$BACKUP_FILE"
            print_info "Backed up to $BACKUP_FILE"
        fi
        cp "$src" "$dest"
        print_success "Installed $name"
        return 0
    else
        print_info "Kept existing $name"
        return 1
    fi
}

echo ""
print_info "Bash Stuff Configuration Setup"
echo "======================================"

#========== Bash Profile ==========
echo ""
print_info "bash_profile"
install_dotfile "$SCRIPT_DIR/profiles/bash_profile" ~/.bash_profile "bash_profile"

#========== Vimrc ==========
echo ""
print_info "vimrc"
if install_dotfile "$SCRIPT_DIR/profiles/vimrc" ~/.vimrc "vimrc"; then
    if [[ ! -d ~/.vim/undo ]]; then
        mkdir -p ~/.vim/undo
        print_info "Created ~/.vim/undo for persistent undo"
    fi
fi

#========== Tmux ==========
echo ""
print_info "tmux.conf"
install_dotfile "$SCRIPT_DIR/profiles/tmux.conf" ~/.tmux.conf "tmux.conf"

# Reload tmux config if tmux is running
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null; then
    tmux source-file ~/.tmux.conf 2>/dev/null && print_info "Reloaded tmux config"
fi

#========== Claude Settings ==========
echo ""
print_info "Claude Code settings"
CLAUDE_DIR="$HOME/.claude"
if [[ ! -d "$CLAUDE_DIR" ]]; then
    mkdir -p "$CLAUDE_DIR"
    print_info "Created $CLAUDE_DIR"
fi
install_dotfile "$SCRIPT_DIR/profiles/claude_settings.json" "$CLAUDE_DIR/settings.json" "Claude settings"

#========== Repo Sync ==========
echo ""
print_info "repo-sync (keeps ~/workspace repos in sync between FPMoss and FPZeph)"
RESP=$(get_choice "Install the repo-sync timer (runs at startup and hourly)? (y/n): " "yn")
if [[ "$RESP" == "y" ]]; then
    "$SCRIPT_DIR/bin/repo-sync" install && print_success "Installed repo-sync"
else
    print_info "Skipped repo-sync"
fi

#========== Done ==========
echo ""
echo "======================================"
print_success "Setup complete!"
echo ""
print_info "To activate bash_profile changes, run:"
echo -e "  ${GREEN}source ~/.bash_profile${NC}"
echo ""
