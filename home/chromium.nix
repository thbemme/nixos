{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--enable-features=WebRTCPipeWireCapturer,VaapiVideoDecoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL"
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--disable-background-networking"
      "--enable-accelerated-video-decode"
      "--enable-zero-copy"
      "--no-default-browser-check"
      "--disable-sync"
      "--disable-features=MediaRouter"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform-hint=auto"
    ];
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "hfjbmagddngcpeloejdejnfgbamkjaeg" # vimium-c
      "akpkoodohacdmlddblgnaahbbfjplcig" # darkreader
      "bhghoamapcdpbohphigoooaddinpkbai" # authenticator
      "oeakphpfoaeggagmgphfejmfjbhjfhhh" # YT tweaks
      "gfapcejdoghpoidkfodoiiffaaibpaem" # dracula theme
    ];
  };
  home.sessionVariables = {
    BROWSER = "chromium";
  };
}
