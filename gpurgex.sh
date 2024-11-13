#!/bin/bash

# List of GNOME packages to remove
GNOME_PACKAGES=(
  "epiphany" "gnome-software" "gnome-tour" "gnome-text-editor" "gnome-system-monitor"
  "snapshot" "totem" "gnome-music" "gnome-calculator" "gnome-calendar" "gnome-maps"
  "gnome-weather" "gnome-contacts" "gnome-characters" "gnome-clocks" "gnome-user-docs" "yelp"
)

# Color codes for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Log file for recording removal actions
LOG_FILE="/tmp/gnome_debloat.log"

# Identify the package manager
identify_package_manager() {
    if command -v apt &>/dev/null; then
        PKG_MANAGER="apt"
    elif command -v pacman &>/dev/null; then
        PKG_MANAGER="pacman"
    elif command -v dnf &>/dev/null; then
        PKG_MANAGER="dnf"
    elif command -v zypper &>/dev/null; then
        PKG_MANAGER="zypper"
    elif command -v yum &>/dev/null; then
        PKG_MANAGER="yum"
    else
        echo -e "${RED}Unsupported package manager or OS detected.${RESET}"
        exit 1
    fi
    echo -e "${BLUE}Detected package manager: ${GREEN}$PKG_MANAGER${RESET}"
}

# Function to check package installation
is_installed() {
    case "$PKG_MANAGER" in
        apt) dpkg -l | grep -qw "$1" ;;
        pacman) pacman -Q "$1" &>/dev/null ;;
        dnf | yum) rpm -q "$1" &>/dev/null ;;
        zypper) rpm -q "$1" &>/dev/null ;;
        *) return 1 ;;
    esac
}

# Get a list of installed GNOME packages from GNOME_PACKAGES
get_installed_packages() {
    INSTALLED_PACKAGES=()
    for pkg in "${GNOME_PACKAGES[@]}"; do
        if is_installed "$pkg"; then
            INSTALLED_PACKAGES+=("$pkg")
        fi
    done
}

# Display package selection with whiptail
select_packages_to_remove() {
    PACKAGE_SELECTION=()
    OPTIONS=()
    for pkg in "${INSTALLED_PACKAGES[@]}"; do
        OPTIONS+=("$pkg" "" ON)
    done
    PACKAGE_SELECTION=$(whiptail --title "Select GNOME Packages to Remove" \
        --checklist "Choose packages to uninstall:" 20 70 10 "${OPTIONS[@]}" 3>&1 1>&2 2>&3)
    PACKAGE_SELECTION=($(echo "$PACKAGE_SELECTION" | tr -d "\""))
}

# Check for sudo/admin privileges
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}This script requires admin privileges. Please run with sudo.${RESET}"
        exit 1
    fi
}

# Remove selected packages with the detected package manager
remove_packages() {
    if [ ${#PACKAGE_SELECTION[@]} -eq 0 ]; then
        echo -e "${YELLOW}No packages selected for removal. Exiting.${RESET}"
        exit 0
    fi
    echo -e "${BLUE}Removing selected packages...${RESET}"

    # Execute removal based on package manager
    case "$PKG_MANAGER" in
        apt)
            sudo apt remove -y "${PACKAGE_SELECTION[@]}" | tee -a "$LOG_FILE"
            ;;
        pacman)
            sudo pacman -Rns --noconfirm "${PACKAGE_SELECTION[@]}" | tee -a "$LOG_FILE"
            ;;
        dnf)
            sudo dnf remove -y "${PACKAGE_SELECTION[@]}" | tee -a "$LOG_FILE"
            ;;
        zypper)
            sudo zypper remove -y "${PACKAGE_SELECTION[@]}" | tee -a "$LOG_FILE"
            ;;
        yum)
            sudo yum remove -y "${PACKAGE_SELECTION[@]}" | tee -a "$LOG_FILE"
            ;;
        *)
            echo -e "${RED}Package manager $PKG_MANAGER not supported by this script.${RESET}"
            exit 1
            ;;
    esac
    echo -e "${GREEN}Removal complete!${RESET}"
}

# Display the completion summary
completion_summary() {
    echo -e "${GREEN}All selected packages have been removed.${RESET}"
    echo -e "${YELLOW}Log of actions:${RESET} ${BLUE}$LOG_FILE${RESET}"
}

# Main script execution
main() {
    echo -e "${BLUE}Welcome to the GNOME Debloater Script!${RESET}"
    identify_package_manager
    check_sudo
    get_installed_packages

    if [ ${#INSTALLED_PACKAGES[@]} -eq 0 ]; then
        echo -e "${GREEN}No target GNOME applications are installed. Exiting.${RESET}"
        exit 0
    fi

    select_packages_to_remove
    remove_packages
    completion_summary
}

# Check if whiptail is installed for a better user interface
if ! command -v whiptail &> /dev/null; then
    echo -e "${RED}whiptail is not installed. Please install it to run this script interactively.${RESET}"
    exit 1
fi

# Run the main function
main
