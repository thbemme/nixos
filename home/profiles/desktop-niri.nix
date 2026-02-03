{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
    ../apps/vicinae.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    cmus
    gpu-screen-recorder
    kdePackages.qt6ct
    mission-center
    nautilus
    nirius
    pwvucontrol
    qalculate-gtk
    wl-clipboard-rs
    wlsunset
    xwayland-satellite
  ];

  programs.fish = {
    shellInit = ''
      set -gx QT_QPA_PLATFORM "wayland";
      set -gx XDG_SESSION_TYPE "wayland";
      set -gx NIXOS_OZONE_WL "1";
      set -gx MOZ_ENABLE_WAYLAND "1";
      set -gx MOZ_WEBRENDER "1";
      set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION "1";
      set -gx GDK_BACKEND "wayland";
      set -gx QT_QPA_PLATFORMTHEME "qt6ct";
    '';
  };

  gtk.theme.name = "adw-gtk3";

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

  services.udiskie = {
    enable = true;
  };

  services.swayidle = let
    niri = "${pkgs.niri}/bin/niri";
    noctalia-shell = "${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell";
    lock-cmd = "${noctalia-shell} ipc call lockScreen lock";
    monitor-on = "${niri} msg action power-on-monitors";
    monitor-off = "${niri} msg action power-off-monitors";
    lower-brightness = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
    restore-brightness = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    suspend = "${noctalia-shell} ipc call sessionMenu lockAndSuspend";
    systemd-ac-power = "${pkgs.systemd}/bin/systemd-ac-power";
    suspendOnBatt = "${systemd-ac-power} || ${suspend}";
  in {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = lock-cmd;
      }
      {
        event = "after-resume";
        command = monitor-on;
      }
      {
        event = "lock";
        command = lock-cmd;
      }
    ];
    timeouts = [
      {
        timeout = 60;
        command = lower-brightness;
        resumeCommand = restore-brightness;
      }
      {
        timeout = 300;
        command = monitor-off;
      }
      {
        timeout = 900;
        command = suspendOnBatt;
      }
      {
        timeout = 1800;
        command = lock-cmd;
      }
      {
        timeout = 3600;
        command = suspend;
      }
    ];
  };

  # programs.fuzzel = {
  #   enable = true;
  #   settings.colors = {
  #     background = "282a36dd";
  #     text = "f8f8f2ff";
  #     match = "8be9fdff";
  #     selection-match = "8be9fdff";
  #     selection = "44475add";
  #     selection-text = "f8f8f2ff";
  #     border = "bd93f9ff";
  #   };
  #   settings.main.font = "FiraCode Nerd Font:size=12";
  # };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    colors = {
      mPrimary = "#bd93f9";
      mOnPrimary = "#282A36";
      mSecondary = "#ff79c6";
      mOnSecondary = "#4e1d32";
      mTertiary = "#8be9fd";
      mOnTertiary = "#003543";
      mError = "#FF5555";
      mOnError = "#282A36";
      mSurface = "#282A36";
      mOnSurface = "#bd93f9";
      mSurfaceVariant = "#44475A";
      mOnSurfaceVariant = "#d6d8e0";
      mOutline = "#5a5e77";
      mShadow = "#282A36";
      mHover = "#8be9fd";
      mOnHover = "#003543";
    };

    settings = {
      bar = {
        barType = "simple";
        position = "top";
        monitors = [];
        density = "compact";
        showOutline = false;
        showCapsule = true;
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
              colorizeSystemIcon = "primary";
              customIconPath = "";
              enableColorization = true;
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
              hideWhenIdle = true;
              id = "AudioVisualizer";
              width = 200;
            }
          ];
          center = [
            {
              colorizeIcons = true;
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
            {
              characterCount = 2;
              emptyColor = "primary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              id = "Workspace";
              labelMode = "name";
              occupiedColor = "secondary";
              reverseScroll = false;
              showApplications = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
            }
          ];
          right = [
            {
              compactMode = false;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = true;
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
              colorizeIcons = true;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [];
            }
            {
              compactMode = false;
              diskPath = "/";
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
              deviceNativePath = "";
              displayMode = "alwaysShow";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = true;
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
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
            }
            {
              colorName = "primary";
              id = "SessionMenu";
            }
          ];
        };
        screenOverrides = [];
      };
      general = {
        avatarImage = pkgs.fetchurl {
          url = "https://xosc.org/gpn2019/img/puffy.png";
          hash = "sha256-MBDNaoxf5mO0cBUNyc4jzTlllpx+STcv1CtmGzCWh2E=";
        };
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
        firstDayOfWeek = 1;
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
        directory = "kbnetcloud/Wallpapers";
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
        transitionEdgeSmoothness = 0.5;
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
        location = "bottom_center";
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
            id = "gtk";
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

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      overview.workspace-shadow.enable = false;
      debug.honor-xdg-activation-with-invalid-serial = [];
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
      hotkey-overlay.skip-at-startup = true;

      input = {
        focus-follows-mouse.enable = true;
        workspace-auto-back-and-forth = true;
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
          natural-scroll = true;
          accel-profile = "flat";
        };

        mouse = {
          accel-speed = -0.5;
          accel-profile = "flat";
        };

        power-key-handling.enable = false;

        # Disable caps lock
        keyboard.xkb.options = "caps:none";
      };

      gestures.hot-corners.enable = false;

      spawn-at-startup = [
        {command = ["ghostty" "-e" "cmus"];}
        {command = ["ghostty" "-e" "btop"];}
        {command = ["librewolf"];}
        {command = ["codium"];}
        {command = ["nextcloud" "--background"];}
        {command = ["corectrl" "--minimize-systray"];}
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "sh" "-c" "ghostty";
        "Mod+b".action = spawn "librewolf";
        "Menu".action = spawn "vicinae" "toggle";
        "Mod+Space".action = spawn "vicinae" "toggle";
        "Mod+Alt+l".action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";

        "Mod+WheelScrollDown".action = focus-column-right;
        "Mod+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+WheelScrollUp".action = move-column-left;
        "Mod+Shift+WheelScrollDown".action = focus-workspace-down;
        "Mod+Shift+WheelScrollUp".action = focus-workspace-up;

        "Mod+Minus".action = switch-preset-window-width;
        "Mod+Shift+Minus".action = switch-preset-window-height;

        "Mod+q".action = close-window;
        "Mod+t".action = toggle-window-floating;
        "Mod+Ctrl+t".action = switch-focus-between-floating-and-tiling;
        "Mod+f".action = maximize-column;
        "Mod+Shift+f".action = expand-column-to-available-width;
        "Mod+Ctrl+f".action = fullscreen-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Down".action = move-window-down;

        "Mod+Ctrl+Left".action = focus-monitor-left;
        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+Up".action = focus-monitor-up;
        "Mod+Ctrl+Down".action = focus-monitor-down;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+Up".action = move-column-to-workspace-up;
        "Mod+Shift+Ctrl+Down".action = move-column-to-workspace-down;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Alt+Left".action = consume-or-expel-window-left;
        "Mod+Alt+Right".action = consume-or-expel-window-right;
        "Mod+y".action = toggle-column-tabbed-display;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

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
        "f9" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
        "Mod+MouseForward" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
        XF86AudioPlay = {
          action = spawn "playerctl play-pause";
          allow-when-locked = true;
        };
        XF86AudioStop = {
          action = spawn "playerctl stop";
          allow-when-locked = true;
        };
        XF86AudioPrev = {
          action = spawn "playerctl previous";
          allow-when-locked = true;
        };
        XF86AudioNext = {
          action = spawn "playerctl next";
          allow-when-locked = true;
        };

        XF86MonBrightnessUp = {
          action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
          allow-when-locked = true;
        };
        XF86MonBrightnessDown = {
          action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
          allow-when-locked = true;
        };
        "Print".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};

        "Ctrl+Alt+Delete".action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
      };

      workspaces = {
        "1".name = "gaming";
        "2".name = "main";
        "3".name = "dev";
        "4".name = "comm";
        "5".name = "office";
      };

      window-rules = [
        {
          #opacity = 0.95;
        }
        {
          matches = [{app-id = "com.mitchellh.ghostty";}];
          draw-border-with-background = false;
          opacity = 0.8;
        }
        {
          matches = [
            {
              app-id = "^librewolf$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [{app-id = "^librewolf$";}];
          open-maximized = true;
          open-on-workspace = "main";
        }
        {
          matches = [
            {app-id = "com.nextcloud.desktopclient.nextcloud";}
            {app-id = "qalculate-gtk";}
            {app-id = "org.corectrl.CoreCtrl";}
          ];
          open-floating = true;
        }
        {
          matches = [
            {app-id = "steam_app_default";}
            {app-id = "net.lutris.Lutris";}
            {app-id = "ascension launcher.ex";}
          ];
          open-floating = false;
          open-on-workspace = "gaming";
        }
        {
          matches = [
            {app-id = "^steam_app_";}
            {app-id = "^rusty-path-of-building-";}
            {app-id = "ascension.exe";}
          ];
          open-maximized = true;
          open-on-workspace = "gaming";
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
        }
        {
          matches = [
            {app-id = "codium";}
            {app-id = "VSCodium";}
          ];
          open-maximized = true;
          open-on-workspace = "dev";
        }
        {
          matches = [
            {app-id = "hexchat";}
            {app-id = "io.github.tdesktop_x64.TDesktop";}
            {app-id = "vesktop";}
            {app-id = "wasistlos";}
          ];
          open-maximized = true;
          open-on-workspace = "comm";
        }
        {
          matches = [
            {app-id = "^libreoffice-";}
            {app-id = "gimp";}
            {app-id = "lyx";}
            {app-id = "scribus";}
            {app-id = "krita";}
          ];
          open-maximized = true;
          open-on-workspace = "office";
        }
        {
          matches = [
            {app-id = "codium";}
            {app-id = "nautilus";}
            {app-id = "qalculate-gtk";}
            {app-id = "VSCodium";}
          ];
          draw-border-with-background = false;
          opacity = 0.95;
        }
      ];

      cursor = {
        theme = "oreo_purple_cursors";
        hide-when-typing = true;
      };

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
          {proportion = 1.0;}
        ];

        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#bd93f9";
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
          color = "#282A36";
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
