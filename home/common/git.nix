{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "Abbes";
    userEmail = "abbesmohamed717@gmail.com";  # Change this
    
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      
      pull = {
        rebase = false;
      };
      
      push = {
        default = "simple";
      };
      
      merge = {
        tool = "vimdiff";
      };
      
      diff = {
        tool = "vimdiff";
      };
      
      color = {
        ui = true;
        branch = "auto";
        diff = "auto";
        status = "auto";
      };
      
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        df = "diff";
        lg = "log --oneline --graph --decorate --all";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
      };
    };
    
    ignores = [
      "*~"
      "*.swp"
      "*.tmp"
      ".DS_Store"
      "Thumbs.db"
      ".vscode/"
      ".idea/"
      "*.log"
      "node_modules/"
      "__pycache__/"
      "*.pyc"
      ".env"
      ".direnv/"
      "result"
      "result-*"
    ];
  };
  
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  
  programs.gitui.enable = true;
}
