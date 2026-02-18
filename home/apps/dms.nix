{
  inputs,
  pkgs,
  ...
}: {
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
      #currentThemeName = "stylix";
      # customThemeFile = let
      #   theme = {
      #     name = "Dracula";
      #     primary = "#bd93f9";
      #     primaryText = "#282A36";
      #     primaryContainer = "#a1efe4";
      #     secondary = "#ff79c6";
      #     surface = "#282A36";
      #     surfaceText = "#F8F8F2";
      #     surfaceVariant = "#44475A";
      #     surfaceVariantText = "#d6d8e0";
      #     surfaceTint = "#2d6e8";
      #     background = "#282936";
      #     backgroundText = "#e9e9f4";
      #     outline = "#5a5e77";
      #     surfaceContainer = "#282A36";
      #     surfaceContainerHigh = "#333547";
      #     surfaceContainerHighest = "#4d4f68";
      #     error = "#FF5555";
      #     warning = "#00f769";
      #     info = "#a1efe4";
      #   };
      # in
      #   pkgs.writeText "dracula.json" (
      #     builtins.toJSON {
      #       dark = theme;
      #       light = theme;
      #     }
      #   );

      clockDateFormat = "ddd MMM d";
      groupWorkspaceApps = false;
      innerPadding = "0";
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
          rightWidgets = [
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
            {
              id = "gpuTemp";
              enabled = true;
              selectedGpuIndex = 0;
              pciId = "1002:73df";
            }
            {
              id = "clipboard";
              enabled = true;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
            }
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
