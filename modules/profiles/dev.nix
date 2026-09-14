{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # Development Tools
      android-tools
      delta
      gh
      glow
      gnumake
      gperf
      jdk
      libxml2
      lzop
      m4
      moreutils
      ncurses5
      nix-output-monitor
      nix-prefetch-git
      nix-update
      nixpkgs-review
      openssl
      perl
      prettier
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
      #ladybird
    ]);

  users.users.${vars.user}.extraGroups = ["kvm" "adbusers" "dialout"];

  zramSwap.memoryPercent = 100;
}
