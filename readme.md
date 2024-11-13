
# Gnome-PurgeX

**GNOME PurgeX** is a command-line tool designed to streamline and optimize your GNOME desktop environment by removing pre-installed GNOME applications that may be unnecessary for your workflow. With an interactive, sci-fi-inspired interface and multi-package manager support, GNOME PurgeX provides an efficient and powerful debloating experience.

---

# Table of Contents

- [Features](#features)
- [Supported Package Managers](#supported-package-managers)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Uninstallable Packages](#uninstallable-packages)
- [Example Usage](#example-usage)
- [Contributing](#contributing)
- [License](#license)

---

# Features
- **Multi-package manager support**: Automatically detects and works with apt, pacman, dnf, zypper, and yum.
- **Interactive selection**: Allows users to choose which GNOME packages to remove via an intuitive checklist interface powered by whiptail.
- **Dependency-aware**: Only displays packages currently installed on your system.
- **Logging**: Logs all removal actions and any errors encountered during execution.
- **Progress tracking**: Displays real-time feedback for each package removal action.
- **Sci-fi inspired interface**: Sleek colors and a futuristic name to make system maintenance feel high-tech.

---

# Supported Package Managers
- **apt** (Debian/Ubuntu)
- **pacman** (Arch Linux)
- **dnf** (Fedora)
- **zypper** (openSUSE)
- **yum** (RHEL/CentOS)

---

# Prerequisites
- **Bash**: This script is compatible with Bash and should run on any Linux distribution using GNOME.
- **whiptail**: This utility is required for the interactive checklist interface. Install it with:
    - `sudo apt install whiptail` (Debian/Ubuntu)
    - `sudo pacman -S libnewt` (Arch)
    - `sudo dnf install newt` (Fedora)
    - `sudo zypper install newt` (openSUSE)

---

# Installation
1.Download or clone the GNOME PurgeX script:
```bash
git clone https://github.com/intrepidDev101/Gnome-PurgeX.git
cd GNOME-PurgeX
```

2.Make the script executable:
```bash
chmod +x gpurgex.sh
```
---

# Usage
To run GNOME PurgeX, simply execute the script with `sudo` privileges:

```bash
sudo ./gpurgex.sh
```
---

# Upon execution, GNOME PurgeX will:

- Identify the package manager on your system. 
- Present a checklist of GNOME applications available for removal.
- Allow you to select which applications you want to uninstall.
- Log all removal actions to `/tmp/gnome_debloat.log`.

---

# Optional Arguments
Currently, GNOME PurgeX runs interactively. Future versions may include command-line flags for additional customization.

---

# Uninstallable Packages
GNOME PurgeX can target the following pre-installed GNOME applications:

- epiphany (Web browser)
- `gnome-software` (Software center)
- `gnome-tour` (Introduction tour)
- `gnome-text-editor` (Text editor)
- `gnome-system-monitor` (System monitor)
- `snapshot` (Snapshot tool)
- `totem` (Video player)
- `gnome-music` (Music player)
- `gnome-calculator` (Calculator)
- `gnome-calendar` (Calendar)
- `gnome-maps` (Maps)
- `gnome-weather` (Weather)
- `gnome-contacts` (Contacts)
- `gnome-characters` (Characters tool)
- `gnome-clocks` (Clocks)
- `gnome-user-docs` (User documentation)
- `yelp` (GNOME help browser)

---

# Example Usage
Here’s a step-by-step example of GNOME PurgeX in action:

Run the script:

```bash
sudo ./gpurgex.sh
```

1.The script will detect your package manager and display the packages available for removal.

2.Select the packages you want to remove from the checklist interface.

3.Confirm the selection, and GNOME PurgeX will remove the selected packages.

4.A summary will be displayed, and detailed logs will be saved to `/tmp/gnome_debloat.log`.

---

# Contributing
Contributions are welcome! Feel free to submit issues and pull requests to improve GNOME PurgeX. Here’s how to get started:

1.Fork the repository.
2.Create a new branch for your feature or bug fix:
```bash
git checkout -b feature-name
```
3.Make your changes and commit them.
4.Push to your fork and submit a pull request.

---

# License
This project is licensed under the MIT License. See the [LICENSE](#LICENSE) file for more information.

