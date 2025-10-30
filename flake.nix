# https://git.kbnetcloud.de/riza/nixos
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    #nix-comfyui.url = "github:dyscorv/nix-comfyui";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nix-on-droid,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    variables = nixpkgs.lib.importJSON ./secrets/variables.json;

    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    specialArgs = useWorkVars: {
      inherit inputs;
      vars =
        if useWorkVars
        then variables.work
        else variables.home;
      pkgs-unstable = pkgsUnstable;
    };

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
        specialArgs = specialArgs useWorkVars // {inherit gpuAcceleration;};
      };
  in {
    nixosConfigurations = {
      puffy = nixosConfig {
        configPath = ./hosts/puffy/configuration.nix;
        gpuAcceleration = true;
      };
      puff = nixosConfig {configPath = ./hosts/puff/configuration.nix;};
      nixos-template = nixosConfig {configPath = ./hosts/nixos-template/configuration.nix;};
      vm = nixosConfig {
        configPath = ./hosts/vm/configuration.nix;
        useUnstable = true;
      };
      PWXCFPC6C4 = nixosConfig {
        configPath = ./hosts/wsl/configuration.nix;
        useWorkVars = true;
      };
      nixos = nixosConfig {configPath = ./hosts/wsl/configuration.nix;};
    };

    homeConfigurations.hm = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        backupFileExtension = "hm-back";
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [./hosts/hm/home.nix];
      extraSpecialArgs = {
        inherit inputs;
        gpuAcceleration = false;
        vars = variables.home;
        pkgs-unstable = pkgsUnstable;
      };
    };

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-linux";
      };
      modules = [./hosts/mikrobi/configuration.nix];
      extraSpecialArgs = {vars = variables.home;};
    };
  };
}
