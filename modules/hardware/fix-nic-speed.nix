{pkgs, ...}: {
  systemd.services.fix-nic-speed = {
    description = "Force 1Gbps on enp37s0";
    after = ["network-pre.target"];
    before = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp37s0 speed 1000 duplex full autoneg on";
    };
  };
}
