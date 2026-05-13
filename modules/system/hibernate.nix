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

  #boot.kernelParams = [];

  systemd.sleep.settings.Sleep = {
    HibernateOnACPower = "no";
    HibernateDelaySec = "30min";
    SuspendState = "mem";
  };
}
