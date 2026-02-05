{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    delta
    glow
    gnumake
    gperf
    jdk
    libxml2
    lzop
    m4
    ncurses5
    nettools
    nix-output-monitor
    nixpkgs-review
    nodePackages.prettier
    openssl
    perl
    procps
    rustfmt
    schedtool
    scrcpy
    shellcheck
    shfmt
    unzip
    util-linux
    zip
    zlib
  ];

  users.users.${vars.user} = {
    packages =
      (with pkgs; [
        thonny
      ])
      ++ (with pkgs-unstable; [
        android-studio
        ladybird
      ]);
    extraGroups = ["kvm" "adbusers" "dialout"];
  };

  programs.adb.enable = true;

  zramSwap.memoryPercent = 100;
}
