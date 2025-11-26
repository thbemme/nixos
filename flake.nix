# https://git.kbnetcloud.de/riza/nixos
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    #nix-comfyui.url = "github:dyscorv/nix-comfyui";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-on-droid,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    variables = nixpkgs.lib.importJSON ./secrets/variables.json;
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    # Shared function for common arguments
    makeSpecialArgs = {
      useWorkVars ? false,
      gpuAcceleration ? false,
    }: {
      inherit inputs;
      vars =
        if useWorkVars
        then variables.work
        else variables.home;
      pkgs-unstable = pkgsUnstable;
      inherit gpuAcceleration;
    };

    # NixOS configuration function
    nixosConfig = {
      configPath,
      useUnstable ? false,
      useWorkVars ? false,
      gpuAcceleration ? false,
    }: let
      nixpkgsSrc =
        if useUnstable
        then nixpkgs-unstable
        else nixpkgs;
    in
      nixpkgsSrc.lib.nixosSystem {
        modules = [configPath];
        specialArgs = makeSpecialArgs {inherit useWorkVars gpuAcceleration;};
      };

    # Home Manager configuration function
    homeConfig = {
      configPath,
      useWorkVars ? false,
      gpuAcceleration ? false,
    }:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [configPath];
        extraSpecialArgs = makeSpecialArgs {inherit useWorkVars gpuAcceleration;};
      };
  in {
    nixosConfigurations = {
      nixos = nixosConfig {configPath = ./hosts/wsl/configuration.nix;};
      nixos-template = nixosConfig {configPath = ./hosts/nixos-template/configuration.nix;};
      puff = nixosConfig {configPath = ./hosts/puff/configuration.nix;};
      puffy = nixosConfig {
        configPath = ./hosts/puffy/configuration.nix;
        gpuAcceleration = true;
      };
      PWXCFPC6C4 = nixosConfig {
        configPath = ./hosts/wsl/configuration.nix;
        useWorkVars = true;
      };
      vm = nixosConfig {
        configPath = ./hosts/vm/configuration.nix;
        useUnstable = true;
      };
    };

    homeConfigurations.hm = homeConfig {configPath = ./hosts/hm/home.nix;};

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-linux";
      };
      modules = [./hosts/mikrobi/configuration.nix];
      extraSpecialArgs = {vars = variables.home;};
    };
  };
}
