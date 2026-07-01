{pkgs, ...}: {
  home.packages = with pkgs; [
    element-desktop
  ];
  xdg.desktopEntries.element-desktop = {
    name = "Element";
    genericName = "Matrix Client";
    comment = "Feature-rich client for Matrix.org";
    exec = "element-desktop --password-store=gnome-libsecret %u";
    icon = "element";
    categories = ["Network" "InstantMessaging" "Chat"];
    mimeType = ["x-scheme-handler/element" "x-scheme-handler/io.element.desktop"];
  };
}
