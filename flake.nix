{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        dev = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/dev/configuration.nix
            ./hosts/dev/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.abbes = import ./home/abbes/default.nix;
            }
          ];
        };

        workstation = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/workstation/configuration.nix
            ./hosts/workstation/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.abbes = import ./home/abbes/default.nix;
            }
          ];
        };
      };
    };
}

