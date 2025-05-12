_: {
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 7850;
    }
  ];
  powerManagement.enable = true;

  boot.kernelParams = ["mem_sleep_default=deep"];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
}
