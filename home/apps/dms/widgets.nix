{
  gpuAcceleration,
  inputs,
  lib,
  ...
}: let
  # Small toggle widget: {id, row, col, w}
  toggle = id: row: col: w: {
    inherit id row col w;
    enabled = true;
    h = 1;
  };
  smallBtn = id: col: {
    inherit id col;
    row = 0;
    enabled = true;
    h = 1;
    w = 1;
    small = true;
  };

  lockWidget = type: {
    enabled = true;
    id = "lock_${type}";
    widgetType = type;
  };

  weatherWidget = id: row: col: w: {
    inherit id row col w;
    h = 2;
    tone = "";
  };
  weatherGraphic = id: row: col: w: (weatherWidget id row col w) // {graphics = true;};
  weatherChart = id: row: col: w: (weatherWidget id row col w) // {forecast = "chart";};
in {
  imports = [
    inputs.dux-plugin-registry.nixosModules.default
  ];

  programs.dank-material-shell.settings = {
    lockScreenWidgetInstances = map lockWidget [
      "desktopClock"
      "lockDate"
      "lockAuth"
      "lockNotifications"
      "lockStatus"
    ];

    greeterWidgetInstances =
      map lockWidget [
        "desktopClock"
        "lockDate"
        "lockAuth"
        "lockStatus"
      ]
      ++ [
        {
          enabled = true;
          id = "greeter_session";
          widgetType = "greeterSession";
          config = {
            displayPreferences = ["all"];
            syncPositionAcrossScreens = true;
          };
        }
      ];

    controlCenterWidgets = [
      (toggle "user" 0 0 4)
      (smallBtn "settings" 4)
      (smallBtn "lock" 5)
      (smallBtn "edit" 6)
      (smallBtn "power" 7)
      (toggle "brightnessSlider" 1 0 4)
      (toggle "volumeSlider" 1 4 4)
      (toggle "wifi" 2 0 4)
      (toggle "bluetooth" 2 4 4)
      (toggle "audioOutput" 3 0 4)
      (toggle "audioInput" 3 4 4)
      (toggle "darkMode" 4 0 2)
      (toggle "nightMode" 4 2 2)
      (toggle "doNotDisturb" 4 4 2)
      (toggle "idleInhibitor" 4 6 2)
    ];

    dashCards = [
      {
        id = "clock";
        col = 0;
        row = 0;
        w = 2;
        h = 1;
      }
      {
        id = "weather";
        col = 2;
        row = 0;
        w = 1;
        h = 1;
      }
      {
        id = "notifications";
        col = 3;
        row = 0;
        w = 3;
        h = 5;
      }
      {
        id = "calendar";
        col = 0;
        row = 1;
        w = 3;
        h = 3;
      }
      {
        id = "sysmon";
        col = 0;
        row = 4;
        w = 3;
        h = 1;
      }
    ];

    dashOptions = {
      clock.tone = "";
      media.lyrics = false;
      weather.widgets = [
        (weatherWidget "conditions" 0 0 2)
        (weatherChart "hourly" 0 2 2)
        (weatherWidget "sun" 2 0 1)
        (weatherWidget "moon" 2 1 1)
        (weatherGraphic "humidity" 2 2 1)
        (weatherGraphic "wind" 2 3 1)
        (weatherChart "daily" 4 1 3)
        (weatherGraphic "precipitation" 4 0 1)
      ];
    };

    barConfigs = [
      {
        attachToScreenEdge = true;
        enabled = true;
        id = "default";
        name = "Main Bar";
        position = 0;
        innerPadding = 0;
        screenPreferences = ["all"];
        showOnLastDisplay = true;

        centerWidgets = [
          {
            id = "workspaceSwitcher";
            groupWorkspaceApps = false;
            maxWorkspaceIcons = "10";
            showOccupiedWorkspacesOnly = true;
            showWorkspaceApps = true;
            workspaceColorMode = "sc";
            workspaceIndicatorCompact = true;
            workspaceUnfocusedColorMode = "sch";
          }
        ];

        leftWidgets = [
          {
            id = "launcherButton";
            launcherLogoMode = "os";
          }
          {
            id = "music";
            mediaShowCoverArt = false;
            mediaShowLyrics = false;
            mediaSize = 1;
          }
        ];

        rightWidgets =
          [
            "catWidget"
            "privacyIndicator"
            "weather"
            {
              id = "systemTray";
              trayUseInlineExpansion = true;
            }
            {
              id = "cpuTemp";
              minimumWidth = true;
            }
          ]
          ++ lib.optionals gpuAcceleration [
            {
              id = "gpuTemp";
              selectedGpuIndex = 0;
              pciId = "1002:73df";
            }
          ]
          ++ [
            "clipboard"
            "battery"
            "controlCenterButton"
            "clock"
            "powerMenuButton"
          ];
      }
    ];
  };
}
