{inputs, ...}: {
  imports = [
    inputs.dux-calendar.homeModules.default
  ];

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
    settings = {
      firstDayOfWeek = -1; # locale default
      showWeekNumbers = true;
      timeFormat = "24h";
      use24HourClock = true;
    };
  };
}
