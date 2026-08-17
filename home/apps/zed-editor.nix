{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "markdown"
    ];
    userSettings = {
      auto_update = false;
      disable_ai = true;
      tab_size = 2;
      telemetry = {
        metrics = true;
        diagnostics = false;
      };
      minimap = {
        max_width_columns = 80;
        thumb = "always";
        show = "always";
      };
      vim_mode = true;
      format_on_save = "on";
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
