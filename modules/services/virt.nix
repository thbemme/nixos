{
  pkgs,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      gnome-boxes
      virt-manager
    ];
    extraGroups = ["libvirtd"];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    swtpm
  ];
}
