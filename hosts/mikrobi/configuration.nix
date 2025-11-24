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
  environment.packages = myPackages;

  environment.extraOutputsToInstall = [
    "doc"
    "info"
    "devdoc"
  ];
  environment.motd = null;

  user.shell = "${lib.getExe pkgs.fish}";

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hosts = {
    "192.168.178.1" = ["rt-dd-01"];
    "192.168.178.2" = ["rt-dd-02"];
    "192.168.178.3" = ["printer"];
    "192.168.178.4" = ["chromecast"];
    "192.168.178.5" = ["pita"];
    "192.168.178.6" = ["pihole-amd64-vm"];
    "192.168.178.7" = ["blowfish"];
    "192.168.178.9" = ["debian"];
    "192.168.178.14" = ["nginx-amd64-vm"];
    "192.168.178.15" = ["mail" "mail-amd64-vm"];
    "192.168.178.17" = ["medium-amd64-vm"];
    "192.168.178.18" = ["docker-amd64-vm"];
    "192.168.178.19" = ["ssh-amd64-vm"];
    "192.168.178.20" = ["puffy"];
    "192.168.178.23" = ["ansible-amd64-vm"];
  };

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
