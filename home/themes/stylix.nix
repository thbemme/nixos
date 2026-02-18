{
  inputs,
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    targets = {
      mangohud.enable = false;
      firefox.profileNames = ["default"];
    };

    cursor = {
      package = pkgs.oreo-cursors-plus;
      name = "oreo_purple_cursors";
      size = 24;
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
    };

    image = pkgs.fetchurl {
      url = "https://i.redd.it/pivo53w9nyd51.jpg";
      hash = "sha256-5QjFGb1wO5qfWimRYIAF6BEesxrsZg1AXC3MhKutcEg=";
    };

    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };
    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };
  };
}
