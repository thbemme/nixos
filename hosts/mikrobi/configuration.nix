{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    vim
    git
    openssh
    dig
    man
    gnupg
    fish
    sudo
    hostname
    diffutils
    findutils
    utillinux
    tzdata
    htop
    gnupg
  ];

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

  # Set your time zone
  #time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;

    config =
      { config, lib, pkgs, ... }:
      {
        # Read the changelog before changing this value
        home.stateVersion = "24.05";
        home.file = {
          ".config/fish/config.fish".source = ../../home/dotfiles/mikrobi.fish;
        };
        services.ssh-agent.enable = true;
      };
  };
}
