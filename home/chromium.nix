{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    dictionaries = [
      pkgs.hunspellDictsChromium.de_DE
      pkgs.hunspellDictsChromium.en_GB
    ];
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock origin lite
      "hfjbmagddngcpeloejdejnfgbamkjaeg" # vimium-c
      "akpkoodohacdmlddblgnaahbbfjplcig" # darkreader
      "bhghoamapcdpbohphigoooaddinpkbai" # authenticator
      "oeakphpfoaeggagmgphfejmfjbhjfhhh" # YT tweaks
      "gfapcejdoghpoidkfodoiiffaaibpaem" # dracula theme
    ];
    commandLineArgs = [
      # chromium
      "--site-per-process"
      # ungoogled-chromium
      "--enable-features=ReducedSystemInfo,RemoveClientHints,SpoofWebGLInfo,DisableLinkDrag,MinimalReferrers"
      "--omnibox-autocomplete-filtering=search-bookmarks"
      "--fingerprinting-canvas-measuretext-noise"
      "--fingerprinting-canvas-image-data-noise"
      "--fingerprinting-client-rects-noise"
      "--close-window-with-last-tab=never"
      "--no-default-browser-check"
      "--show-avatar-button=never"
      "--disable-beforeunload"
      "--scroll-tabs=always"
      "--start-maximized"
      "--popups-to-tabs"
      "--no-pings"
      "--component-updater=require_encryption"
      "--no-crash-upload"
      "--no-service-autorun"
      "--disable-sync"
    ];
  };
  #home.sessionVariables = {
  #  BROWSER = "chromium";
  #};
}
