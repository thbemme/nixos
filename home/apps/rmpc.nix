{pkgs, ...}: let
  musicDirectory = "~/Music";
in {
  home.packages = with pkgs; [rmpc];

  services.mpd-mpris.enable = true;

  services.mpd = {
    enable = true;
    inherit musicDirectory;
    network.startWhenNeeded = true;

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }

      auto_update "yes"
    '';
  };
}
