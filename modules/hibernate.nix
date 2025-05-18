_: {
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 7850;
    }
  ];

  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  boot.kernelParams = ["mem_sleep_default=deep"];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
}
