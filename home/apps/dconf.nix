_: {
  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-hinting = "full";
      font-antialiasing = "rgba";
      gtk-enable-primary-paste = true; # Why would you disable that? It makes no sense at all.
      text-scaling-factor = 1;
    };
  };
}
