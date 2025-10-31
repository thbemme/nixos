{
  pkgs,
  gpuAcceleration,
  ...
}: {
  programs.btop = {
    enable = true;
    package =
      if gpuAcceleration
      then pkgs.btop-rocm
      else pkgs.btop;
    settings = {
      color_theme = "dracula";
      theme_background = false;
    };
  };
}
