{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";
      logo = pkgs.stdenv.mkDerivation {
        name = "out.png";
        dontUnpack = true;
        src = pkgs.fetchurl {
          url = "https://nixos.org/_astro/nixos-logo-26.05-yarara-lores.xm7Ks20R_2fU286.webp";
          hash = "sha256-N5z7WRB/tYM9md8Ww2E0SH+hjmn27zSvzTcFkVlcIqc=";
        };
        nativeBuildInputs = with pkgs; [imagemagick];
        buildPhase = ''
          magick $src -background none -resize 300x300 nix-plymouth-logo.png
        '';
        installPhase = ''
          install -Dm0644 nix-plymouth-logo.png $out
        '';
      };
    };

    # Enable "Silent Boot"
    consoleLogLevel = 3;
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
