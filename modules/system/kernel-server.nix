{pkgs, ...}: {
  imports = [
    ./kernel-default.nix
    ./kernel-hardening.nix
  ];

  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
      extraConfig = ''
        serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
        terminal_input --append serial
        terminal_output --append serial
      '';
    };
  };
}
