{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = (with pkgs; [
      androidenv.androidPkgs_9_0.platform-tools
      bison
      curl
      flex
      git
      gitRepo
      gnumake
      gnupg
      gperf
      jdk
      libxml2
      lzop
      m4
      ncurses5
      nettools
      openssl
      perl
      procps
      #python2
      python3
      schedtool
      scrcpy
      thonny
      unzip
      util-linux
      zip
      zlib
    ]) ++
    (with pkgs-unstable; [
      android-studio
      #ladybird
    ]);
  };

  programs.adb.enable = true;
  users.users.user.extraGroups = [ "kvm" "adbusers" ];
}
