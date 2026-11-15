{config, ...}: {
  programs.niri.settings = {
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
    hotkey-overlay.skip-at-startup = true;

    debug = {
      honor-xdg-activation-with-invalid-serial = [];
    };

    overview = {
      workspace-shadow.enable = true;
      zoom = 0.2;
      backdrop-color = config.lib.stylix.colors.withHashtag.base00;
    };

    input = {
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "90%";
      };
      warp-mouse-to-focus.enable = false;
      workspace-auto-back-and-forth = true;
      keyboard = {
        xkb = {
          layout = "de";
          variant = "nodeadkeys";
          options = "caps:none";
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
      mouse.accel-profile = "flat";
      power-key-handling.enable = false;
    };

    outputs."LG Electronics LG ULTRAGEAR 204NTWG14769" = {
      variable-refresh-rate = "on-demand";
    };

    gestures.hot-corners = {
      top-left = false;
      top-right = false;
      bottom-left = false;
      bottom-right = false;
    };

    spawn-at-startup = [
      {command = ["ghostty" "-e" "rmpc"];}
      {command = ["ghostty" "-e" "btop"];}
      {command = ["librewolf"];}
      {command = ["zeditor"];}
    ];

    workspaces = {
      "1".name = "gaming";
      "2".name = "main";
      "3".name = "dev";
      "4".name = "comm";
      "5".name = "office";
    };

    blur = {
      passes = 2;
      offset = 3.0;
      noise = 0.03;
      saturation = 1.0;
    };

    layout = {
      gaps = 1;
      center-focused-column = "never";
      empty-workspace-above-first = true;
      background-color = "transparent";
      preset-column-widths = [
        {proportion = 1.0;}
        {proportion = 0.5;}
        {proportion = 0.66667;}
        {proportion = 0.33333;}
      ];
      default-column-width.proportion = 0.5;
      preset-window-heights = [
        {proportion = 0.33333;}
        {proportion = 0.5;}
        {proportion = 1.0;}
      ];
      border.width = 2;
      tab-indicator = {
        hide-when-single-tab = true;
        place-within-column = true;
        gap = 5;
        width = 4;
        length.total-proportion = 1.0;
        position = "right";
        gaps-between-tabs = 2;
        corner-radius = 8;
        active.color = config.lib.stylix.colors.withHashtag.base08;
        inactive.color = config.lib.stylix.colors.withHashtag.base06;
      };
      insert-hint.display.color = config.lib.stylix.colors.withHashtag.base08;
    };
  };
}
