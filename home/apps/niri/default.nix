{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    ./settings.nix
    ./binds.nix
    ./window-rules.nix
  ];

  nixpkgs.overlays = [inputs.niri.overlays.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
