{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-comfyui.url = "github:dyscorv/nix-comfyui";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix for android
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, lanzaboote, nix-comfyui, nix-on-droid, nixos-wsl, ... }@inputs:
    let
      lib = nixpkgs.lib;
      variables = pkgs.lib.importJSON ./secrets/variables.json;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        puffy = lib.nixosSystem {
          modules = [ ./hosts/puffy/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = variables.home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        puff = lib.nixosSystem {
          modules = [ ./hosts/puff/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = variables.home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        vm = nixpkgs-unstable.lib.nixosSystem {
          modules = [ ./hosts/vm/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = variables.home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        hostname = lib.nixosSystem {
          modules = [ ./hosts/wsl/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = variables.work;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        nixos = lib.nixosSystem {
          modules = [ ./hosts/wsl/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = variables.home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
        };
        modules = [ ./hosts/mikrobi/configuration.nix ];
        extraSpecialArgs = {
          vars = variables.home;
        };
      };
    };
}
