{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nix-comfyui.url = "github:dyscorv/nix-comfyui";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix for android
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-comfyui, nix-on-droid, nixos-wsl, ... }@inputs:
    let
      lib = nixpkgs.lib;
      vars = {
        user = "user";
        gitName = "firstname lastname";
        gitEmail = "firstname.lastname@maildomain.com";
        hostname = "nixos";
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        puffy = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/puffy/configuration.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs vars; };
            }
          ];
          specialArgs = {
            inherit inputs vars;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        puff = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/puff/configuration.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs vars; };
            }
          ];
          specialArgs = {
            inherit inputs vars;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        vm = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/vm/configuration.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs vars; };
            }
          ];
          specialArgs = {
            inherit inputs vars;
            pkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        hostname = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/wsl/configuration.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                vars = {
                  user = "workuser";
                  gitName = "firstname lastname";
                  gitEmail = "firstname.lastname@maildomain.com";
                  hostname = "hostname";
                };
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            vars = {
              user = "workuser";
              gitName = "firstname lastname";
              gitEmail = "firstname.lastname@maildomain.com";
              hostname = "hostname";
            };
          };
        };
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/wsl/configuration.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = { inherit inputs vars; };
            }
          ];
          specialArgs = {
            inherit inputs vars;
          };
        };
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
        };
        modules = [ ./hosts/mikrobi/configuration.nix ];

      };
    };
}
