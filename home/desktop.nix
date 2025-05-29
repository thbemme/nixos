{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      adjust-cell-width = "-10%";
      background-opacity = 0.85;
      confirm-close-surface = false;
      font-family = "Fira Code";
      font-size = 10;
      font-style-bold = "Medium";
      font-style-bold-italic = "Medium Oblique";
      font-style-italic = "Light Oblique";
      font-synthetic-style = false;
      keybind = ["f11=toggle_fullscreen"];
      mouse-hide-while-typing = true;
      quit-after-last-window-closed = true;
      theme = "Dracula";
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = {
        installation_mode = "force_installed";
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "vimium-c@gdh1995.cn" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          installation_mode = "force_installed";
        };
        "authenticator@mymindstorm" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/auth-helper/latest.xpi";
          installation_mode = "force_installed";
        };
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          installation_mode = "force_installed";
        };
        "idcac-pub@guus.ninja" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
