{
  inputs,
  pkgs,
  ...
}: let
  stylix-background = pkgs.fetchurl {
    url = "https://i.redd.it/pivo53w9nyd51.jpg";
    hash = "sha256-5QjFGb1wO5qfWimRYIAF6BEesxrsZg1AXC3MhKutcEg=";
  };

  opacity = 0.95;
  fontSize = 10;
in {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    enableReleaseChecks = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

    targets = {
      mangohud.enable = false;
      librewolf.enable = false;
      neovim = {
        transparentBackground = {
          main = true;
          numberLine = true;
          signColumn = true;
        };
      };
    };

    cursor = {
      package = pkgs.oreo-cursors-plus;
      name = "oreo_purple_cursors";
      size = 24;
    };

    opacity = {
      terminal = opacity;
      popups = opacity;
    };

    fonts = {
      serif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Serif";
      };

      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };
    };

    image = stylix-background;

    icons = {
      enable = true;
      dark = "rose-pine-moon";
      package = pkgs.rose-pine-icon-theme;
    };
  };
}
