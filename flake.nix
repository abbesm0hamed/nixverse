{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        minimal = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/minimal/configuration.nix
            ./hosts/minimal/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.abbes = import ./home/abbes/minimal.nix;
            }
          ];
        };

        workstation = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/workstation/configuration.nix
            ./hosts/workstation/hardware-configuration.nix
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.abbes = import ./home/abbes/workstation.nix;
              home-manager.extraSpecialArgs = { inherit niri; };
            }
          ];
        };
      };
    };
}

