{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    packages = with pkgs; [
      gnome-boxes
      virt-manager
    ];
    extraGroups = [ "libvirtd" ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    swtpm
  ];

  systemd.tmpfiles.rules =
    let
      firmware =
        pkgs.runCommandLocal "qemu-firmware" { } ''
          mkdir $out
          cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
          substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
        '';
    in
    [ "L+ /var/lib/qemu/firmware - - - - ${firmware}" ];
}
