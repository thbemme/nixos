{
  inputs,
  gpuAcceleration,
  useUnstable,
  vars,
  ...
}: {
  imports = [
    # include NixOS-WSL modules
    inputs.home-manager.nixosModules.home-manager
    <nixos-wsl/modules>
    ../../modules/profiles/default.nix
    ../../modules/system/hosts.nix
    #../../modules/services/llm.nix
  ];

  nix = {
    settings = {
      max-jobs = 2;
      cores = 6;
    };
  };

  wsl = {
    defaultUser = "${vars.user}";
    enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };

  programs = {
    dconf.enable = true;
    ssh.startAgent = true;
  };

  environment.enableAllTerminfo = true;

  networking = {
    hostName = "${vars.hostname}";
    resolvconf.enable = false;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware.graphics.enable = true;

  home-manager = {
    backupFileExtension = "hm-back";
    extraSpecialArgs = {inherit inputs vars gpuAcceleration useUnstable;};
    users = {
      "${vars.user}" = import ../../home/profiles/wsl.nix;
    };
  };
}
