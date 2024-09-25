{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      lib = nixpkgs.lib;
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
          ];
          specialArgs = {
            inherit inputs;
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
          ];
          specialArgs = {
            inherit inputs;
          };
        };
        testing = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/testing/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
          };
          vm = lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/vm/configuration.nix
              inputs.home-manager.nixosModules.default
            ];
            specialArgs = {
              inherit inputs;
            };
          };
        };
      };
    };
}
