{pkgs, ...}: {
  home.packages = with pkgs; [
    package-version-server
  ];

  stylix.targets.zed.enable = false;

  programs.zed-editor = {
    enable = true;

    extensions = [
      "ansible"
      "color-highlight"
      "dockerfile"
      "markdown"
      "nix"
      "rose-pine-theme"
    ];

    userSettings = {
      # Editor behavior
      auto_update = false;
      format_on_save = "on";
      vim_mode = true;
      tab_size = 2;
      theme = "Rosé Pine Moon";

      # Autosave
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };

      direnv = {
        enable = true;
      };
      # AI
      disable_ai = true;

      # UI
      buffer_font_weight = 300;
      buffer_line_height = "standard";
      current_line_highlight = "all";
      selection_highlight = true;

      # Panels
      project_panel = {
        button = true;
        dock = "left";
      };

      git_panel = {
        button = true;
        dock = "left";
      };

      outline_panel = {
        file_icons = true;
        button = true;
        git_status = true;
        dock = "left";
      };

      debugger = {
        dock = "bottom";
      };

      terminal = {
        dock = "bottom";
      };

      # Disabled panels
      notification_panel = {
        button = false;
      };

      collaboration_panel = {
        button = false;
      };

      # Minimap
      minimap = {
        max_width_columns = 80;
        thumb = "always";
        show = "always";
      };

      # Telemetry
      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      # Language servers
      lsp = {
        nixd.binary.path = "${pkgs.nixd}/bin/nixd";
      };

      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter = {
            external = {
              command = "${pkgs.alejandra}/bin/alejandra";
              arguments = ["--quiet" "-"];
            };
          };
        };
      };
    };
  };
}
