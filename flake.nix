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
      home = {
        user = "user";
        gitName = "firstname lastname";
        gitEmail = "firstname.lastname@maildomain.com";
        hostname = "nixos";
      };
      work = {
        user = "workuser";
        gitName = "firstname lastname";
        gitEmail = "firstname.lastname@maildomain.com";
        hostname = "hostname";
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        puffy = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/puffy/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        puff = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/puff/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        vm = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/vm/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        hostname = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/wsl/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = work;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/wsl/configuration.nix ];
          specialArgs = {
            inherit inputs;
            vars = home;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs-unstable {
          system = "aarch64-linux";
        };
        modules = [ ./hosts/mikrobi/configuration.nix ];
        extraSpecialArgs = {
          vars = home;
        };
      };
    };
}
