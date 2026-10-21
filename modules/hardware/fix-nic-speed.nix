{pkgs, ...}: {
  systemd.services.fix-nic-speed = {
    description = "Force 1Gbps on enp37s0";
    wants = ["sys-subsystem-net-devices-enp37s0.device"];
    after = ["sys-subsystem-net-devices-enp37s0.device"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp37s0 speed 1000 duplex full autoneg on";
    };
  };
}
