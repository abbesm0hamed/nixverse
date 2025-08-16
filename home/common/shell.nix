{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    
    shellAliases = {
      ll = "exa -l";
      la = "exa -la";
      tree = "exa --tree";
      cat = "bat";
      grep = "rg";
      find = "fd";
      
      # NixOS specific
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
      update = "nix flake update ~/nixos-config";
      clean = "sudo nix-collect-garbage -d";
      
      # Git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
    };
    
    functions = {
      # Custom functions
      mkcd = "mkdir -p $argv[1]; and cd $argv[1]";
      
      # Nix shell helper
      nix-shell-run = "nix-shell -p $argv[1] --run $argv[1]";
      
      # Search for packages
      search = "nix search nixpkgs $argv[1]";
      
      # Fish greeting
      fish_greeting = "echo 'Welcome to NixOS with Fish! 🐟'";
      
      # Custom prompt function
      fish_prompt = {
        body = ''
          set -l last_pipestatus $pipestatus
          set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
          set -l normal (set_color normal)
          set -l status_color (set_color brgreen)
          set -l cwd_color (set_color $fish_color_cwd)
          set -l vcs_color (set_color brpurple)
          set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$status_color" $last_pipestatus)

          echo -n -s (set_color bryellow) "$USER" $normal @ (set_color brblue) (prompt_hostname) $normal ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_status $normal "➜ "
        '';
      };
    };
    
    interactiveShellInit = ''
      # Vi mode
      fish_vi_key_bindings
      
      # Custom keybindings
      bind -M insert \cf accept-autosuggestion
      bind -M insert \ch backward-char
      bind -M insert \cl forward-char
      
      # Set colors
      set -g fish_color_normal normal
      set -g fish_color_command blue
      set -g fish_color_quote green
      set -g fish_color_redirection magenta
      set -g fish_color_end red
      set -g fish_color_error red --bold
      set -g fish_color_param cyan
      set -g fish_color_comment yellow
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_operator magenta
      set -g fish_color_escape cyan
      set -g fish_color_autosuggestion brblack
      
      # Custom abbreviations (like aliases but expand)
      abbr -a l exa
      abbr -a ls exa
      abbr -a vim nvim
      abbr -a vi nvim
      abbr -a gst git status
      abbr -a gco git checkout
      abbr -a gcb git checkout -b
      abbr -a gaa git add --all
      abbr -a gcm git commit -m
      abbr -a gp git push
      abbr -a gl git pull
      
      # NixOS abbreviations
      abbr -a nb sudo nixos-rebuild switch --flake ~/nixos-config
      abbr -a nt sudo nixos-rebuild test --flake ~/nixos-config
      abbr -a nu nix flake update ~/nixos-config
      abbr -a nc sudo nix-collect-garbage -d
      
      # Docker abbreviations
      abbr -a d docker
      abbr -a dc docker-compose
      abbr -a dcu docker-compose up
      abbr -a dcd docker-compose down
    '';
    
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "colored-man-pages";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "colored_man_pages.fish";
          rev = "f885c2507128ba95eb9e9689ec43c25391eb4531";
          sha256 = "ii9gdBPlC1/P1N2bmr9JOI0rLdmZnzcUpnOTMxtgBJg=";
        };
      }
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
    ];
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = config.programs.fish.shellAliases;
  };
  
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    
    settings = {
      add_newline = false;
      
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[V](bold yellow)";
      };
      
      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        style = "bold cyan";
      };
      
      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };
      
      git_status = {
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        up_to_date = "✓";
        untracked = "🤷‍";
        stashed = "📦";
        modified = "📝";
        staged = "👍";
        renamed = "👅";
        deleted = "🗑";
      };
      
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
        min_time = 2000;
      };
      
      username = {
        format = "[$user]($style)@";
        style_user = "bold yellow";
        show_always = true;
      };
      
      hostname = {
        format = "[$hostname]($style) ";
        style = "bold blue";
        ssh_only = false;
      };
    };
  };
}
