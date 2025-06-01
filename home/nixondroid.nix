{vars, ...}: {
  imports = [
    ./fish.nix
  ];
  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  programs.fish = {
    shellAliases = {
      r = "nix-on-droid switch -F ~/git/nixos/ $argv";
      c = "nix-collect-garbage -d";
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    userName = "${vars.gitName}";
    userEmail = "${vars.gitEmail}";
  };
  programs.ssh = {
    forwardAgent = true;
    extraConfig = ''
      SetEnv TERM=xterm-256color
    '';
    matchBlocks = {
      "*" = {
        user = "${vars.user}";
      };
      "blowfish" = {
        hostname = "192.168.178.7";
      };
      "ansible-amd64-vm" = {
        hostname = "192.168.178.23";
      };
      "docker-amd64-vm" = {
        hostname = "192.168.178.18";
      };
      "ssh-amd64-vm" = {
        hostname = "192.168.178.19";
      };
      "puffy" = {
        hostname = "192.168.178.20";
      };
    };
  };
}
