{
  config,
  inputs,
  pkgs,
  vars,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  programs.fuzzel = {
    enable = true;
    settings.colors = {
      background = "282a36dd";
      text = "f8f8f2ff";
      match = "8be9fdff";
      selection-match = "8be9fdff";
      selection = "44475add";
      selection-text = "f8f8f2ff";
      border = "bd93f9ff";
    };
    settings.main.font = "FiraCode Nerd Font:size=8";
  };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        barType = "simple";
        position = "top";
        monitors = [];
        density = "compact";
        showOutline = false;
        showCapsule = false;
        capsuleOpacity = 0.6;
        backgroundOpacity = 0.93;
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 2;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = false;
        exclusive = true;
        hideOnOverview = false;
        widgets = {
          left = [
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Spacer";
              width = 20;
            }
            {
              colorName = "primary";
              hideWhenIdle = false;
              id = "AudioVisualizer";
              width = 200;
            }
          ];
          center = [
            {
              colorizeIcons = false;
              hideMode = "hidden";
              iconScale = 0.8;
              id = "Taskbar";
              maxTaskbarWidth = 40;
              onlyActiveWorkspaces = true;
              onlySameOutput = true;
              showPinnedApps = true;
              showTitle = false;
              smartWidth = true;
              titleWidth = 120;
            }
          ];
          right = [
            {
              compactMode = false;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 145;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = false;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "linear";
            }
            {
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = false;
              id = "Tray";
              pinned = [];
            }
            {
              compactMode = false;
              diskPath = "/persist";
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = false;
              showDiskUsage = false;
              showGpuTemp = true;
              showLoadAverage = false;
              showMemoryAsPercent = true;
              showMemoryUsage = false;
              showNetworkStats = false;
              showSwapUsage = false;
              useMonospaceFont = true;
              usePrimaryColor = false;
            }
            {
              displayMode = "alwaysShow";
              id = "Microphone";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              displayMode = "alwaysShow";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              displayMode = "alwaysShow";
              id = "Brightness";
            }
            {
              deviceNativePath = "";
              displayMode = "alwaysShow";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 20;
            }
            {
              hideWhenZero = true;
              hideWhenZeroUnread = false;
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
            {
              customFont = "";
              formatHorizontal = "ddd dd.MM. HH:mm:ss";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
              usePrimaryColor = false;
            }
          ];
        };
        screenOverrides = [];
      };
      general = {
        avatarImage = "/home/riza/Pictures/blowfish-notext-square.png";
        dimmerOpacity = 0.2;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1;
        radiusRatio = 0.4;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1.5;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = false;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "center";
        shadowOffsetX = 0;
        shadowOffsetY = 0;
        language = "";
        allowPanelsOnScreenWithoutBar = true;
        showChangelogOnStartup = true;
        telemetryEnabled = false;
        enableLockScreenCountdown = true;
        lockScreenCountdownDuration = 10000;
        autoStartAuth = true;
        allowPasswordWithFprintd = false;
      };
      ui = {
        fontDefault = "Adwaita Sans";
        fontFixed = "FiraCode Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };
      location = {
        name = "Dresden, Germany";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = 0;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "/home/riza/Pictures/Wallpapers";
        monitorDirectories = [];
        enableMultiMonitorDirectories = false;
        showHiddenFiles = false;
        viewMode = "recursive";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        automationEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 5.0e-2;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
      };
      appLauncher = {
        enableClipboardHistory = true;
        autoPasteClipboard = false;
        enableClipPreview = true;
        clipboardWrapText = true;
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        position = "center";
        pinnedApps = [];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "ghostty";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "list";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = false;
        enableSettingsSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
            {
              id = "NoctaliaPerformance";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        tempPollingInterval = 3000;
        gpuPollingInterval = 3000;
        enableDgpuMonitoring = true;
        memPollingInterval = 3000;
        diskPollingInterval = 30000;
        networkPollingInterval = 3000;
        loadAvgPollingInterval = 3000;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      dock = {
        enabled = false;
        position = "left";
        displayMode = "auto_hide";
        backgroundOpacity = 1;
        floatingRatio = 1;
        size = 1;
        onlySameOutput = true;
        monitors = [];
        pinnedApps = [];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
      };
      network = {
        wifiEnabled = true;
        bluetoothRssiPollingEnabled = false;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = false;
        largeButtonsLayout = "grid";
        showNumberLabels = true;
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
        ];
      };
      notifications = {
        enabled = true;
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 0.85;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
        enableMediaToast = false;
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
        ];
        monitors = [];
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = true;
        cavaFrameRate = 60;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "";
        volumeFeedback = false;
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Dracula";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        generationMethod = "vibrant";
        monitorForColors = "";
      };
      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "btop";
          }
          {
            enabled = true;
            id = "cava";
          }
          {
            enabled = true;
            id = "gtk";
          }
          {
            enabled = true;
            id = "ghostty";
          }
          {
            enabled = true;
            id = "kcolorscheme";
          }
          {
            enabled = true;
            id = "niri";
          }
          {
            enabled = true;
            id = "qt";
          }
          {
            enabled = true;
            id = "code";
          }
        ];
        enableUserTheming = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
        startup = "";
        session = "";
      };
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [];
      };
    };
  };

  home.packages = [
    pkgs.nirius
    pkgs.wl-clipboard-rs
  ];

  services.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.Access" = ["gtk"];
      "org.freedesktop.impl.portal.Notification" = ["gtk"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["xdg-desktop-portal-gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["xdg-desktop-portal-gnome"];
    };
    extraPortals = [
      pkgs.gnome-keyring
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        "QT_QPA_PLATFORM" = "wayland";
        "XDG_SESSION_TYPE" = "wayland";
        "NIXOS_OZONE_WL" = "1";
        "MOZ_ENABLE_WAYLAND" = "1";
        "MOZ_WEBRENDER" = "1";
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
        "GDK_BACKEND" = "wayland";
      };

      overview.workspace-shadow.enable = false;
      debug.honor-xdg-activation-with-invalid-serial = [];
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
      hotkey-overlay.skip-at-startup = true;

      input = {
        keyboard = {
          xkb = {
            layout = "de";
            variant = "nodeadkeys";
          };

          repeat-delay = 235;
          repeat-rate = 60;
          numlock = true;
        };

        touchpad = {
          tap = true;
          dwt = true;
          dwtp = true;
          natural-scroll = false;
          accel-profile = "flat";
        };

        mouse = {
          accel-speed = -0.5;
          accel-profile = "flat";
        };

        power-key-handling.enable = false;
        workspace-auto-back-and-forth = false;
      };

      gestures.hot-corners.enable = false;

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "ghostty";
        "Mod+b".action = spawn "librewolf";
        "Menu".action = spawn "fuzzel";
        "Mod+d".action = spawn "fuzzel";
        "Mod+Alt+l".action = spawn "swaylock";

        "Mod+q".action = close-window;
        "Mod+t".action = toggle-window-floating;
        "Mod+Ctrl+t".action = switch-focus-between-floating-and-tiling;
        "Mod+f".action = maximize-column;
        "Mod+Shift+f".action = expand-column-to-available-width;
        "Mod+Ctrl+f".action = fullscreen-window;

        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Ctrl+Shift+q".action = quit;
        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+p".action = power-off-monitors;

        XF86AudioRaiseVolume = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          allow-when-locked = true;
        };
        XF86AudioLowerVolume = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          allow-when-locked = true;
        };
        XF86AudioMute = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          allow-when-locked = true;
        };
        XF86AudioMicMute = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
        "Mod+MouseForward" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
      };

      window-rules = [
        {
          opacity = 0.95;
        }
        {
          matches = [{app-id = "com.mitchellh.ghostty";}];
          draw-border-with-background = false;
          opacity = 0.8;
        }
        {
          matches = [{app-id = "librewolf";}];
          open-on-workspace = "browser";
          open-maximized = true;
        }
      ];

      layout = {
        gaps = 1;
        center-focused-column = "never";
        empty-workspace-above-first = true;
        background-color = "transparent";

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        default-column-width = {
          proportion = 0.5;
        };

        preset-window-heights = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };

        border = {
          enable = false;
          width = 2;
          active.color = "#ffc87f";
          inactive.color = "#505050";
        };

        shadow = {
          # on
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000070";
          # inactive-color "#00000054"
        };

        tab-indicator = {
          # off
          hide-when-single-tab = true;
          place-within-column = true;
          gap = 5;
          width = 4;
          length = {
            total-proportion = 1.0;
          };
          position = "right";
          gaps-between-tabs = 2;
          corner-radius = 8;
          active.color = "red";
          inactive.color = "gray";
        };

        insert-hint = {
          # off
          display.color = "#ffc87f80";
        };
      };
    };
  };
}
