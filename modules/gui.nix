{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

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
    packages = with pkgs; [
      adwaita-fonts
      fira-code
      noto-fonts
      noto-fonts-color-emoji
      vistafonts
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/gui.nix;
    };
  };

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = false;
}
