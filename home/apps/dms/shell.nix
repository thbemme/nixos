{
  inputs,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
    inputs.dux-shell.homeModules.dank-material-shell
    inputs.dux-shell.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    quickshell.package =
      lib.hiPrio inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    niri.includes.enable = false;

    # Core features
    enableSystemMonitoring = true;
    enableVPN = false;
    enableDynamicTheming = false;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;

    plugins = {
      calculator.enable = true;
      calculator.settings.calcEngine = "qalc";
      catWidget.enable = true;
      commandRunner.enable = true;
      emojiLauncher = {
        enable = true;
        settings = {
          noTrigger = false;
          trigger = ":";
        };
      };
      dankActions.enable = true;
      dankNotepadModule.enable = true;
      niriWindows.enable = true;
    };

    session = {
      hiddenTrayIds = [
        "blueman"
        "dank-calendar"
        "easyeffects"
        "steam"
        "udiskie"
      ];
      inherit (vars) weatherLocation weatherCoordinates;
    };

    settings = {
      radiusStrength = 30;
      radiusMode = "scale";
      fixedRadius = 0;
      powerMenuDefaultAction = "suspend";
      dmsWindowsFloatingSeeded = ["niri"];
      chipSurfaceNestedColor = "sch";
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      showWeekNumber = true;
      calendarBackend = "dankcal";
      density = "compact";
      systemTrayIconTintMode = "monochrome";

      scrollTitleEnabled = false;
      clockDateFormat = "ddd MMM d";

      terminalsAlwaysDark = true;

      # Power / idle
      acMonitorTimeout = 180;
      acLockTimeout = 3600;
      acSuspendTimeout = 3600;
      batteryMonitorTimeout = 60;
      batterySuspendTimeout = 900;
      batteryChargeLimit = 100;
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;

      launcherPluginVisibility = {
        dms_settings_search.allowWithoutTrigger = false;
      };

      configVersion = 42;
    };
  };
}
