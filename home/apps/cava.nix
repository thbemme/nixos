{config, ...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.bar_width = "1";
      color = {
        gradient = 1;
        gradient_count = 6;
        background = "'#${config.lib.stylix.colors.base00}'";
        gradient_color_1 = "'#${config.lib.stylix.colors.base0B}'";
        gradient_color_2 = "'#${config.lib.stylix.colors.base0C}'";
        gradient_color_3 = "'#${config.lib.stylix.colors.base0D}'";
        gradient_color_4 = "'#${config.lib.stylix.colors.base0A}'";
        gradient_color_5 = "'#${config.lib.stylix.colors.base09}'";
        gradient_color_6 = "'#${config.lib.stylix.colors.base08}'";
      };
    };
  };
}
