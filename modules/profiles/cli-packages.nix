{pkgs, ...}: let
  myPackages = import ./packages.nix {inherit pkgs;};
in {
  environment.systemPackages = myPackages;
}
