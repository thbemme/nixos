# https://git.kbnetcloud.de/riza/nixos
{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05"; #nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager"; #/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix"; #/release-26.05";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:thbemme/danksearch/updateVendorHash";
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
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    variables = nixpkgs.lib.importJSON ./secrets/variables.json;

    # Shared arguments for all configurations
    makeSpecialArgs = {
      gpuAcceleration ? false,
      useUnstable ? false,
      useWorkVars ? false,
    }: {
      inherit inputs;
      vars =
        if useWorkVars
        then variables.work
        else variables.home;
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit useUnstable gpuAcceleration;
    };

    # NixOS configuration helper
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
        specialArgs = makeSpecialArgs {inherit gpuAcceleration useUnstable useWorkVars;};
      };

    # Home Manager configuration helper
    homeConfig = {
      configPath,
      useWorkVars ? false,
      gpuAcceleration ? false,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [configPath];
        extraSpecialArgs = makeSpecialArgs {inherit gpuAcceleration useWorkVars;};
      };
  in {
    nixosConfigurations = {
      nixos = nixosConfig {configPath = ./hosts/wsl/configuration.nix;};
      nixos-template = nixosConfig {configPath = ./hosts/nixos-template/configuration.nix;};
      puff = nixosConfig {configPath = ./hosts/puff/configuration.nix;};
      DEN02263 = nixosConfig {configPath = ./hosts/DEN02263/configuration.nix;};
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

    homeConfigurations = {
      hm = homeConfig {configPath = ./hosts/hm/home.nix;};
    };

    nixOnDroidConfigurations = {
      default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {system = "aarch64-linux";};
        modules = [./hosts/mikrobi/configuration.nix];
        extraSpecialArgs = {vars = variables.home;};
      };
    };
  };
}
