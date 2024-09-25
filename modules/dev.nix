{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = (with pkgs; [
      thonny
      zlib
      ncurses5
      git
      gitRepo
      gnupg
      #python2
      curl
      procps
      openssl
      gnumake
      nettools
      androidenv.androidPkgs_9_0.platform-tools
      jdk
      schedtool
      util-linux
      m4
      gperf
      perl
      libxml2
      zip
      unzip
      bison
      flex
      lzop
      python3
      android-studio
    ]);
  };

  programs.adb.enable = true;
  users.users.user.extraGroups = [ "kvm" "adbusers" ];
}
