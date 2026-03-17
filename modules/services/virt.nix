{
  pkgs,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-boxes
    swtpm
    virt-manager
  ];

  users.users.${vars.user}.extraGroups = ["libvirtd"];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
}
