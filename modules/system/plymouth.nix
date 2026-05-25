{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";
      logo = pkgs.stdenv.mkDerivation {
        name = "out.png";
        dontUnpack = true;
        # src = pkgs.fetchurl {
        #   url = "https://nixos.org/_astro/nixos-logo-25.11-xantusia-lores.CLapGrL7_18iEK3.webp";
        #   hash = "sha256-StJOgJzrZjB5omz98h/EfN5RIIaySCPplqDh2Wi3EXM=";
        # };
        src = ../../assets/pre-26.05.png;
        nativeBuildInputs = with pkgs; [imagemagick];
        buildPhase = ''
          magick $src -background none -resize 200x200 nix-plymouth-logo.png
        '';
        installPhase = ''
          install -Dm0644 nix-plymouth-logo.png $out
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
