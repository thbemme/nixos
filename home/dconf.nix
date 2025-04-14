{ ... }:

{
  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-name = "Inter Display 10";
      document-font-name = "Inter Display 10";
      monospace-font-name = "Fira Code 10 @wght=400";
      font-hinting = "full";
      font-antialiasing = "rgba";
      text-scaling-factor = 1;
    };
  };
}
