{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "markdown"
    ];
    userSettings = {
      telemetry = {
        metrics = true;
        diagnostics = false;
      };
      vim_mode = true;
      format_on_save = "on";
      lsp = {
        rust-analyzer.binary.path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        nixd.binary.path = "${pkgs.nixd}/bin/nixd";
      };
      languages = {
        Rust.format_on_save = "on";
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
