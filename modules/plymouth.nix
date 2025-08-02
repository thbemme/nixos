{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";
      logo = pkgs.stdenv.mkDerivation {
        name = "out.png";
        dontUnpack = true;
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-rainbow.svg";
          sha256 = "sha256-gMeJgiSSA5hFwtW3njZQAd4OHji6kbRCJKVoN6zsRbY=";
        };
        nativeBuildInputs = with pkgs; [imagemagick];
        buildPhase = ''
          magick -background none -size 200x200 $src logo.png
        '';
        installPhase = ''
          install -Dm0644 logo.png $out
        '';
      };
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader.timeout = 1;
  };
}
