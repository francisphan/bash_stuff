#!/bin/bash

############### Bash Stuff Setup Script ###############
# This script installs bash and vim configuration files

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

# Helper function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Helper function to get user choice
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

echo ""
print_info "Bash Stuff Configuration Setup"
echo "======================================"
echo ""

#========== Bash Profile Setup ==========
print_info "Checking bash_profile configuration..."

if [[ -f ~/.bash_profile ]]; then
    print_warning "Found existing ~/.bash_profile"
    RESP=$(get_choice "Do you want to replace it? (y/n): " "yn")
else
    RESP="y"
fi

if [[ "$RESP" == "y" ]]; then
    # Ask which version to install
    echo ""
    print_info "Which bash_profile version would you like to install?"
    echo "  1) Original - Basic configuration with git prompt and colors"
    echo "  2) Enhanced - Extended features, functions, and cross-platform support"
    echo "  3) Skip bash_profile installation"
    echo ""

    VERSION=$(get_choice "Enter choice (1/2/3): " "123")

    case "$VERSION" in
        1)
            # Backup existing bash_profile if it exists
            if [[ -f ~/.bash_profile ]]; then
                BACKUP_FILE=~/.bash_profile.backup-$(date +%Y%m%d-%H%M%S)
                cp ~/.bash_profile "$BACKUP_FILE"
                print_info "Backed up existing bash_profile to $BACKUP_FILE"
            fi

            # Preserve existing PATH if present
            if [[ -f ~/.bash_profile ]]; then
                temp_path=$(grep -E "^export PATH=" ~/.bash_profile | tail -1)
            fi

            cp "$SCRIPT_DIR/profiles/bash_profile" ~/.bash_profile

            # Append preserved PATH if it existed
            if [[ -n "$temp_path" ]]; then
                echo "" >> ~/.bash_profile
                echo "# Preserved PATH from previous configuration" >> ~/.bash_profile
                echo "$temp_path" >> ~/.bash_profile
            fi

            print_success "Installed original bash_profile"
            ;;
        2)
            # Backup existing bash_profile if it exists
            if [[ -f ~/.bash_profile ]]; then
                BACKUP_FILE=~/.bash_profile.backup-$(date +%Y%m%d-%H%M%S)
                cp ~/.bash_profile "$BACKUP_FILE"
                print_info "Backed up existing bash_profile to $BACKUP_FILE"
            fi

            cp "$SCRIPT_DIR/profiles/bash_profile2" ~/.bash_profile
            chmod +x ~/.bash_profile
            print_success "Installed enhanced bash_profile2"
            print_info "The enhanced version includes PATH management, so no need to preserve old PATH"
            ;;
        3)
            print_info "Skipped bash_profile installation"
            ;;
    esac
else
    print_info "Kept existing bash_profile"
fi

#========== Vimrc Setup ==========
echo ""
print_info "Checking vimrc configuration..."

if [[ -f ~/.vimrc ]]; then
    print_warning "Found existing ~/.vimrc"
    RESP=$(get_choice "Do you want to replace it? (y/n): " "yn")
else
    RESP="y"
fi

if [[ "$RESP" == "y" ]]; then
    # Ask which version to install
    echo ""
    print_info "Which vimrc version would you like to install?"
    echo "  1) Original - Basic vim configuration"
    echo "  2) Enhanced - Modern improvements with persistent undo, better defaults"
    echo "  3) Skip vimrc installation"
    echo ""

    VERSION=$(get_choice "Enter choice (1/2/3): " "123")

    case "$VERSION" in
        1)
            # Backup existing vimrc if it exists
            if [[ -f ~/.vimrc ]]; then
                BACKUP_FILE=~/.vimrc.backup-$(date +%Y%m%d-%H%M%S)
                cp ~/.vimrc "$BACKUP_FILE"
                print_info "Backed up existing vimrc to $BACKUP_FILE"
            fi

            cp "$SCRIPT_DIR/profiles/vimrc" ~/.vimrc
            print_success "Installed original vimrc"
            ;;
        2)
            # Backup existing vimrc if it exists
            if [[ -f ~/.vimrc ]]; then
                BACKUP_FILE=~/.vimrc.backup-$(date +%Y%m%d-%H%M%S)
                cp ~/.vimrc "$BACKUP_FILE"
                print_info "Backed up existing vimrc to $BACKUP_FILE"
            fi

            cp "$SCRIPT_DIR/profiles/vimrc2" ~/.vimrc

            # Create vim undo directory if it doesn't exist
            if [[ ! -d ~/.vim/undo ]]; then
                mkdir -p ~/.vim/undo
                print_info "Created ~/.vim/undo directory for persistent undo"
            fi

            print_success "Installed enhanced vimrc2"
            ;;
        3)
            print_info "Skipped vimrc installation"
            ;;
    esac
else
    print_info "Kept existing vimrc"
fi

#========== Completion ==========
echo ""
echo "======================================"
print_success "Setup complete!"
echo ""
print_info "To activate bash_profile changes, run:"
echo "  ${GREEN}source ~/.bash_profile${NC}"
echo ""
print_info "To test vim configuration:"
echo "  ${GREEN}vim${NC}"
echo ""
print_info "For more information, see IMPROVEMENTS.md"
echo ""
