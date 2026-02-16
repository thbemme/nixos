{
  lib,
  pkgs,
  vars,
  ...
}: let
  myPackages = import ../../modules/profiles/packages.nix {inherit pkgs;};
in {
  imports = [
    ../../modules/system/hosts.nix
  ];
  environment = {
    etcBackupExtension = ".bak";
    extraOutputsToInstall = [
      "doc"
      "info"
      "devdoc"
    ];
    motd = null;
    packages = myPackages;
  };

  user.shell = "${lib.getExe pkgs.fish}";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # Stop all running processes on exit (ssh-agent)
  build.extraProotOptions = ["--kill-on-exit"];

  # Set your time zone
  #time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit vars;
    };
    config = ../../home/profiles/nixondroid.nix;
  };
}
