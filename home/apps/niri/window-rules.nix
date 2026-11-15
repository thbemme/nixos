{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
  radius = 4.0;

  maximizedOpaqueApps = [
    "\\.exe$"
    "^app.organicmaps.desktop$"
    "^gimp"
    "^krita$"
    "^libreoffice-"
    "^librewolf$"
    "^lyx$"
    "^org.gnome.Boxes$"
    "^org.gnome.SimpleScan$"
    "^org.remmina.Remmina$"
    "^rusty-path-of-building-"
    "^scribus$"
    "^steam_app_default"
  ];

  gameApps = ["^steam$" "^heroic$" "^steam_app_" "^rusty-path-of-building-" "\\.exe$"];
  devApps = ["^dev\\.zed\\.Zed$" "^Thonny$"];
  commApps = ["^io.github.tdesktop_x64.TDesktop$" "^telegram-desktop$" "^wasistlos$" "^element$"];
  officeApps = ["^libreoffice-" "^gimp" "^lyx$" "^scribus$" "^krita$" "^org.gnome.SimpleScan$"];

  floatingTitles = [
    {title = "^Open File";}
    {title = "^Open Folder";}
    {title = "^Rename \"";}
    {title = "^File Operation Progress";}
  ];
in {
  programs.niri.settings.window-rules = [
    # Global decoration: rounded corners, blur, terminal opacity
    {
      geometry-corner-radius = {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
      opacity = config.stylix.opacity.terminal;
      background-effect = {
        blur = true;
        xray = false;
      };
    }

    # Highlight dynamic-cast target
    {
      matches = [{is-window-cast-target = true;}];
      focus-ring = {
        enable = true;
        width = 2;
        active.color = colors.base08;
        inactive.color = colors.base0A;
      };
    }

    # Ghostty on main
    {
      matches = [{app-id = "com.mitchellh.ghostty";}];
      open-on-workspace = "main";
    }

    # Big apps: maximized, fully opaque (Remmina menu excluded via its own rule)
    {
      matches = map (app-id: {inherit app-id;}) maximizedOpaqueApps;
      excludes = [{title = "Remmina Remote Desktop Client";}];
      open-maximized = true;
      opacity = 1.0;
    }

    # virt-manager windows, but not its main manager window
    {
      matches = [{app-id = "^.virt-manager-wrapped$";}];
      excludes = [{title = "^Virtual Machine Manager$";}];
      open-maximized = true;
      opacity = 1.0;
    }

    # Dev & messenger apps: maximized
    {
      matches = map (app-id: {inherit app-id;}) (devApps ++ commApps);
      open-maximized = true;
    }

    # Floating windows: Remmina menu, PiP, settings, small utilities, dialogs
    {
      matches =
        [
          {
            app-id = "^librewolf$";
            title = "^(Picture-in-Picture|Library|About LibreWolf)$";
          }
          {
            app-id = "^dev\\.zed\\.Zed$";
            title = "Zed — Settings";
          }
          {
            app-id = "^org.remmina.Remmina$";
            title = "^Remmina Remote Desktop Client$";
          }
          {app-id = ".blueman-manager-wrapped";}
          {app-id = "com.nextcloud.desktopclient.nextcloud";}
          {app-id = "mpv";}
          {app-id = "qalculate-gtk";}
          {app-id = "dev.duxlabs.calendar";}
        ]
        ++ floatingTitles;
      open-floating = true;
    }

    ### Workspace assignment
    {
      matches = [{app-id = "^librewolf$";}];
      open-on-workspace = "main";
    }
    {
      matches = map (app-id: {inherit app-id;}) gameApps;
      open-on-workspace = "gaming";
    }
    {
      matches = map (app-id: {inherit app-id;}) devApps;
      open-on-workspace = "dev";
    }
    {
      matches = map (app-id: {inherit app-id;}) commApps;
      open-on-workspace = "comm";
    }
    {
      matches = map (app-id: {inherit app-id;}) officeApps;
      open-on-workspace = "office";
    }

    # Steam notification toasts pinned bottom-right
    {
      matches = [
        {
          app-id = "^steam$";
          title = "^notificationtoasts_\\d+_desktop$";
        }
      ];
      default-floating-position = {
        x = 10;
        y = 10;
        relative-to = "bottom-right";
      };
    }
  ];
}
