{
  gpuAcceleration,
  inputs,
  ...
}: let
  hasBattery = builtins.pathExists "/sys/class/power_supply/BAT0/";
in {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    niri.includes.enable = false;

    # Core features
    enableSystemMonitoring = false; # System monitoring widgets (dgop)
    enableVPN = false; # VPN management widget
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
    settings = {
      clockDateFormat = "ddd MMM d";
      groupWorkspaceApps = false;
      innerPadding = 0;
      launcherLogoMode = "os";
      maxWorkspaceIcons = "10";
      powerMenuDefaultAction = "suspend";
      scrollTitleEnabled = false;
      showOccupiedWorkspacesOnly = true;
      showWorkspaceApps = true;
      transparency = "0.8";
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      widgetTransparency = "0.8";
      workspaceColorMode = "sc";
      workspaceUnfocusedColorMode = "sch";

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
          ];
          centerWidgets = [
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
          ];
          rightWidgets =
            [
              {
                id = "privacyIndicator";
                enabled = true;
              }
              {
                id = "music";
                enabled = true;
                mediaSize = 1;
              }
              {
                id = "weather";
                enabled = true;
              }
              {
                id = "systemTray";
                enabled = true;
              }
              {
                id = "cpuTemp";
                enabled = true;
                minimumWidth = true;
              }
            ]
            ++ (
              if gpuAcceleration
              then [
                {
                  id = "gpuTemp";
                  enabled = true;
                  selectedGpuIndex = 0;
                  pciId = "1002:73df";
                }
              ]
              else []
            )
            ++ [
              {
                id = "clipboard";
                enabled = true;
              }
              {
                id = "notificationButton";
                enabled = true;
              }
            ]
            ++ (
              if hasBattery
              then [
                {
                  id = "battery";
                  enabled = true;
                }
              ]
              else []
            )
            ++ [
              {
                id = "controlCenterButton";
                enabled = true;
              }
              {
                id = "clock";
                enabled = true;
              }
              {
                id = "powerMenuButton";
                enabled = true;
              }
            ];
        }
      ];
    };
  };
}
