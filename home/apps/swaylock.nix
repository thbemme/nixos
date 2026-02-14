{
  config,
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      daemonize = true;
      datestr = "%a, %B %e";
      effect-blur = "13x13";
      effect-vignette = "0.5:0.5";
      fade-in = 0.4;
      font = "FiraCode Nerd Font";
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      ignore-empty-password = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      screenshot = true;
      show-failed-attempts = true;
      timestr = "%I:%M %p";
      color = "6272A4";
      bs-hl-color = "8BE9FD";
      inside-clear-color = "282A36";
      inside-color = "282A36";
      inside-ver-color = "282A36";
      inside-wrong-color = "282A36";
      key-hl-color = "50FA7B";
      line-clear-color = "8BE9FD";
      line-color = "282A36";
      line-ver-color = "BD93F9";
      line-wrong-color = "282A36";
      ring-clear-color = "8BE9FD";
      ring-color = "BD93F9";
      ring-ver-color = "BD93F9";
      ring-wrong-color = "FF5555";
      separator-color = "00000000";
      text-caps-lock-color = "";
      text-clear-color = "8BE9FD";
      text-color = "F8F8F2";
      text-ver-color = "8BE9FD";
      text-wrong-color = "FF5555";
    };
  };
}
