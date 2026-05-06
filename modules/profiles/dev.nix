{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # Development Tools
      delta
      gh
      glow
      gnumake
      gperf
      jdk
      libxml2
      lzop
      m4
      ncurses5
      nix-output-monitor
      nixpkgs-review
      nodePackages.prettier
      openssl
      perl
      procps
      rustfmt
      schedtool
      shellcheck
      shfmt
      thonny

      # Utilities
      scrcpy
      unzip
      util-linux
      zip
      zlib
    ])
    ++ (with pkgs-unstable; [
      # Unstable packages
      android-studio
      ladybird
    ]);

  users.users.${vars.user}.extraGroups = ["kvm" "adbusers" "dialout"];

  programs.adb.enable = true;

  zramSwap.memoryPercent = 100;
}
