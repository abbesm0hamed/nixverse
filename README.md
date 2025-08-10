## My Nixverse - My NixOS Configuration

A modular NixOS configuration with flakes and home-manager, featuring two host profiles and Niri compositor.

## Features

- **Modular Design**: Organized system modules for easy maintenance
- **Two Host Profiles**:
  - `minimal`: Lightweight setup for quick access
  - `workstation`: Full productivity environment with Niri compositor
- **Home Manager Integration**: User-specific configurations
- **Niri Compositor**: Modern scrollable-tiling Wayland compositor
- **Development Tools**: Complete development environment
- **Kanagawa Color Scheme**: Beautiful Japanese-inspired theming

## Host Configurations

### Minimal
- Basic system packages
- Development tools
- Lightweight terminal utilities
- Perfect for servers or quick access machines

### Workstation
- Full desktop environment with Niri
- All productivity applications
- Media tools (mpv, vlc, gimp)
- Development environment
- Communication tools (discord, telegram)

## Quick Start

### For Existing NixOS Systems

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> ~/nixverse
   cd ~/nixverse
   ```

2. **Update hardware configuration**:
   ```bash
   # Generate hardware config for your system
   sudo nixos-generate-config --dir /tmp/nixos-config
   
   # Copy to your host directory (minimal or workstation)
   cp /tmp/nixos-config/hardware-configuration.nix hosts/workstation/
   ```

3. **Update personal information**:
   - Edit `home/abbes/minimal.nix` or `home/abbes/workstation.nix`
   - Update git email and other personal settings

4. **Build and switch**:
   ```bash
   # For workstation
   sudo nixos-rebuild switch --flake .#workstation
   
   # For minimal
   sudo nixos-rebuild switch --flake .#minimal
   ```

### Fresh NixOS Installation Setup

If you're setting up a completely fresh NixOS installation, follow these detailed steps:

#### Step 1: Initial System Setup

After installing NixOS with the basic configuration:

```bash
# Check internet connectivity
ping google.com

# Install git temporarily (will be replaced by our config)
nix-shell -p git curl wget
```

#### Step 2: Download Your Nixverse Configuration

```bash
# Create directory for your config
mkdir -p ~/nixverse
cd ~/nixverse

# Option A: If you have the config in a git repository
git clone https://github.com/yourusername/nixverse.git .

# Option B: Transfer from another machine using scp
# scp -r user@othermachine:/home/abbes/nixverse/* .

# Option C: Transfer using USB drive
# sudo mount /dev/sdX1 /mnt
# cp -r /mnt/nixverse/* .
```

#### Step 3: Generate Hardware Configuration

```bash
# Generate hardware configuration for your new machine
sudo nixos-generate-config --dir /tmp/nixos-config

# Copy the hardware config to your workstation host directory
cp /tmp/nixos-config/hardware-configuration.nix ~/nixverse/hosts/workstation/

# Verify the file was copied correctly
ls -la ~/nixverse/hosts/workstation/
```

#### Step 4: Update Personal Information

```bash
# Edit the workstation home config
nano ~/nixverse/home/abbes/workstation.nix

# Update these settings:
# - Git email: change "your-email@example.com" to your actual email
# - Any other personal preferences
```

#### Step 5: Enable Flakes (if not already enabled)

```bash
# Create nix config directory
sudo mkdir -p /etc/nix

# Enable flakes system-wide
echo "experimental-features = nix-command flakes" | sudo tee /etc/nix/nix.conf
```

#### Step 6: Test the Configuration

```bash
cd ~/nixverse

# Test build (downloads packages but doesn't install)
sudo nixos-rebuild build --flake .#workstation

# Fix any errors before proceeding
```

#### Step 7: Switch to Your Configuration

```bash
# Switch to your workstation configuration
sudo nixos-rebuild switch --flake .#workstation

# This will:
# - Install all system packages
# - Set up Niri compositor
# - Configure all services
# - Set up your user environment with home-manager
```

#### Step 8: Reboot and Login

```bash
# Reboot to ensure everything loads correctly
sudo reboot
```

After reboot:
1. You should see the greetd login manager
2. Login with your user account
3. Niri should start automatically

#### Step 9: Post-Setup Verification

```bash
# Check if Niri is running
echo $XDG_SESSION_TYPE  # Should show "wayland"

# Test terminal (should open Kitty with Kanagawa colors)
# Press Super+Return or your configured terminal shortcut

# Check if home-manager applied correctly
which fish  # Should show fish shell
which nvim  # Should show neovim
which tmux  # Should show tmux

# Test some applications
wofi --show drun  # Application launcher
waybar &  # Status bar (if not auto-started)
```

#### Step 10: Final Configuration

```bash
# Set fish as your default shell
chsh -s $(which fish)

# Initialize starship prompt for fish
fish
starship init fish | source

# Test git configuration
git config --list
```

## Directory Structure

```
nixverse/
├── flake.nix              # Main flake configuration
├── hosts/                 # Host-specific configurations
│   ├── common.nix         # Common settings for all hosts
│   ├── minimal/           # Minimal host configuration
│   └── workstation/       # Workstation host configuration
├── modules/system/        # System modules
│   ├── core.nix          # Core system settings
│   ├── desktop.nix       # Desktop environment (Niri)
│   ├── devtools.nix      # Development tools
│   └── productivity.nix  # Productivity applications
├── home/abbes/           # Home Manager configurations
│   ├── minimal.nix       # Minimal user config
│   └── workstation.nix   # Workstation user config
└── users/                # User definitions
```

## Customization

### Adding New Packages

**System packages**: Add to the appropriate module in `modules/system/`
**User packages**: Add to the relevant home configuration in `home/abbes/`

### Creating New Modules

1. Create a new `.nix` file in `modules/system/`
2. Follow the existing module pattern with options and config
3. Import the module in your host configuration
4. Enable it with `modules.system.<name>.enable = true`

### Switching Between Hosts

```bash
# Switch to workstation
sudo nixos-rebuild switch --flake .#workstation

# Switch to minimal
sudo nixos-rebuild switch --flake .#minimal
```

## Software Included

### Development
- Neovim, Git, Lazygit
- Node.js, Python, Rust, C/C++
- Docker and Docker Compose
- Terminal tools: tmux, kitty, fish, starship

### Desktop (Workstation)
- Niri compositor
- Waybar, Wofi, Mako
- Media: MPV, VLC, GIMP
- Productivity: LibreOffice, Obsidian
- Communication: Discord, Telegram

### System Utilities
- File management: Ranger, Thunar
- System monitoring: btop, htop, cava
- Modern CLI tools: ripgrep, fd, bat, eza

## Troubleshooting

### Common Issues

1. **Build failures**: Check flake inputs are up to date
   ```bash
   nix flake update
   ```

2. **Missing hardware config**: Ensure hardware-configuration.nix exists in your host directory

3. **Permission issues**: Make sure you're running nixos-rebuild with sudo

### Useful Commands

```bash
# Check flake
nix flake check

# Update flake inputs
nix flake update

# Build without switching
sudo nixos-rebuild build --flake .#workstation

# Rollback to previous generation
sudo nixos-rebuild switch --rollback
```

## Contributing

Feel free to fork and customize this configuration for your own needs. The modular design makes it easy to add or remove components.

## License

MIT License - Feel free to use and modify as needed.
