{ pkgs
, pkgs-unstable
, vars
, ...
}: {
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    ../../modules/ai.nix
    ../../modules/default.nix
    ../../modules/home_wsl.nix
  ];

  wsl = {
    defaultUser = "${vars.user}";
    enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
  };

  environment.systemPackages = with pkgs-unstable; [
    alpaca-proxy
    chawan
    ghostty
  ];

  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
  };

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; }) ];

  environment.enableAllTerminfo = true;

  networking.hostName = "${vars.hostname}";

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware.graphics.enable = true;
  #hardware.graphics.setLdLibraryPath = true;
}
