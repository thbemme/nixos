{
  pkgs,
  vars,
  ...
}: let
  fonts = import ./fonts.nix {inherit pkgs;};
in {
  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Automatic Timezone Daemon
  services.automatic-timezoned.enable = true;

  users.users.${vars.user} = {
    packages = with pkgs; [
      ghostty
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["Fira Code"];
      defaultFonts.sansSerif = ["Adwaita Sans"];
      defaultFonts.serif = ["Adwaita Serif"];
      defaultFonts.emoji = ["Noto Color Emoji"];
    };
    fontDir.enable = true;
    packages = fonts;
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/gui-minimal.nix;
    };
  };

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = false;
}
