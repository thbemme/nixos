_: {
  # Define hibernation on lid switch or power key
  # Make sure to have swap>=RAM available
  services = {
    power-profiles-daemon.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandlePowerKey = "hibernate";
      HandlePowerKeyLongPress = "poweroff";
    };
  };

  boot.kernelParams = ["mem_sleep_default=deep"];

  systemd.sleep.extraConfig = ''
    HibernateOnACPower=no
    HibernateDelaySec=30m
    SuspendState=mem
  '';
}
