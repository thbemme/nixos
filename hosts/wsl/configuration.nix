# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, pkgs-unstable, inputs, vars, ... }:

{
  imports =
    [
      # include NixOS-WSL modules
      <nixos-wsl/modules>
      ../../default/default.nix
      ../../modules/aicpu.nix
    ];

  wsl = {
    defaultUser = "${vars.user}";
    enable = true;
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
  };

  environment.systemPackages = with pkgs-unstable; [
    alpaca-proxy
  ];

  environment.enableAllTerminfo = true;

  networking.hostName = "${vars.hostname}";

  hardware.graphics.enable = true;
  hardware.opengl.setLdLibraryPath = true;

}
