{ config, pkgs, lib, dotfiles, ... }:

{
  imports = [
    ./common
  ];

  home = {
    username = "abbes";
    homeDirectory = "/home/abbes";
    stateVersion = "25.05";
  };

  # Minimal set of dotfiles
  home.file = {
    ".vimrc".source = "${dotfiles}/vim/.vimrc";
    ".tmux.conf".source = "${dotfiles}/tmux/.tmux.conf";
    ".gitconfig".source = "${dotfiles}/git/.gitconfig";
  };

  # Essential programs only
  home.packages = with pkgs; [
    # Terminal tools
    tmux
    vim
    
    # Basic utilities
    tree
    htop
    curl
    wget
  ];
  
  # Basic shell setup
  programs.bash.enable = true;
  programs.git.enable = true;
}
