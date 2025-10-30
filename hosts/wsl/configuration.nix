{
  inputs,
  gpuAcceleration,
  pkgs,
  vars,
  ...
}: {
  imports = [
    # include NixOS-WSL modules
    inputs.home-manager.nixosModules.home-manager
    <nixos-wsl/modules>
    ../../modules/profiles/cli-packages.nix
    ../../modules/profiles/default.nix
    #../../modules/services/llm.nix
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

  environment.systemPackages = with pkgs; [
    ghostty
  ];

  fonts.packages = with pkgs; [
    adwaita-fonts
    fira-code
    vista-fonts
  ];

  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
  };

  environment.enableAllTerminfo = true;

  networking.hostName = "${vars.hostname}";

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware.graphics.enable = true;
  #hardware.graphics.setLdLibraryPath = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs vars gpuAcceleration;};
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../../home/profiles/wsl.nix;
    };
  };
}
