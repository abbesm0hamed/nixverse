{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    
    # Hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, niri, zen-browser, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      
      # Custom packages overlay
      overlay = final: prev: {
        zen-browser = zen-browser.packages.${system}.default;
      };
      
      # Common arguments passed to all configurations
      specialArgs = {
        inherit niri zen-browser;
        dotfiles = ./dotfiles;
      };
      
    in {
      nixosConfigurations = {
        minimal = lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            { nixpkgs.overlays = [ overlay ]; }
            ./hosts/common
            ./hosts/minimal/configuration.nix
            ./hosts/minimal/hardware-configuration.nix
            
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.abbes = import ./home/minimal.nix;
                extraSpecialArgs = specialArgs;
              };
            }
          ];
        };

        workstation = lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            { nixpkgs.overlays = [ overlay ]; }
            ./hosts/common
            ./hosts/workstation/configuration.nix
            ./hosts/workstation/hardware-configuration.nix
            niri.nixosModules.niri
            
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.abbes = import ./home/workstation.nix;
                extraSpecialArgs = specialArgs;
              };
            }
          ];
        };
        
        # VM configuration
        vm = lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            { nixpkgs.overlays = [ overlay ]; }
            ./hosts/common
            ./hosts/common/vm.nix
            ./hosts/workstation/configuration.nix
            # Use a generic hardware config for VMs
            
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.abbes = import ./home/workstation.nix;
                extraSpecialArgs = specialArgs // { isVM = true; };
              };
            }
          ];
        };
      };
      
      # Development shell for managing the config
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          nixos-rebuild
          home-manager
          git
        ];
      };
    };
}
