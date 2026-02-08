{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;};
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

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
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
            {id = "plugin:privacy-indicator";}
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
              iconColor = "primary";
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
        showWeekNumberInCalendar = true;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = true;
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
            {id = "Network";}
            {id = "Bluetooth";}
            {id = "WallpaperSelector";}
            {id = "NoctaliaPerformance";}
          ];
          right = [
            {id = "Notifications";}
            {id = "PowerProfile";}
            {id = "KeepAwake";}
            {id = "NightLight";}
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

      dock = {enabled = false;};

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
        enabledTypes = [0 1 2];
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
}
