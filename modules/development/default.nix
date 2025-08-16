{ config, lib, pkgs, ... }:

{
  # Development tools
  environment.systemPackages = with pkgs; [
    # Languages and runtimes
    nodejs_20
    python3
    python3Packages.pip
    python3Packages.virtualenv
    rustc
    cargo
    go
    jdk17
    
    # Build tools
    gcc
    gnumake
    cmake
    pkg-config
    
    # Version control
    git
    gh
    gitui
    
    # Editors and IDEs
    vscode
    vim
    neovim
    
    # Terminal tools
    tmux
    alacritty
    kitty
    
    # Development utilities
    curl
    wget
    jq
    httpie
    postman
    
    # Database tools
    sqlite
    postgresql
    
    # Container tools
    docker-compose
    
    # System tools
    htop
    btop
    tree
    fd
    ripgrep
    bat
    exa
    fzf
    
    # Network tools
    nmap
    wireshark
    tcpdump
  ];
  
  # Enable development services
  programs.git.enable = true;
  
  # Shell improvements
  programs.zsh.enable = true;
  programs.fish.enable = true;
  
  # Enable direnv for project environments
  programs.direnv.enable = true;
}
