{
  pkgs,
  lib,
  vars,
  ...
}: {
  home.file = {
    ".config/DankMaterialShell" = {source = ../dotfiles/DankMaterialShell;};
    ".config/niri" = {source = ../dotfiles/niri;};
    ".config/fuzzel" = {source = ../dotfiles/fuzzel;};
    ".config/swaylock" = {source = ../dotfiles/swaylock;};
  };
}
