{pkgs, ...}: {
  programs = {
    bat.config.theme = "Dracula";
    btop.settings.color_theme = "dracula";
    cava.settings.color = {
      # https://github.com/dracula/cava/blob/main/dracula.cava
      gradient = 1;
      gradient_color_1 = "'#8BE9FD'";
      gradient_color_2 = "'#9AEDFE'";
      gradient_color_3 = "'#CAA9FA'";
      gradient_color_4 = "'#BD93F9'";
      gradient_color_5 = "'#FF92D0'";
      gradient_color_6 = "'#FF79C6'";
      gradient_color_7 = "'#FF6E67'";
      gradient_color_8 = "'#FF5555'";
    };

    fish = {
      plugins = [
        # https://github.com/dracula/fish
        {
          name = "dracula";
          src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "fish";
            rev = "269cd7d76d5104fdc2721db7b8848f6224bdf554";
            hash = "sha256-Hyq4EfSmWmxwCYhp3O8agr7VWFAflcUe8BUKh50fNfY=";
          };
        }
      ];
    };
  };
}
