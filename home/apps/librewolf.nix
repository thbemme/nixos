{
  pkgs,
  vars,
  ...
}: {
  programs.librewolf = {
    enable = true;
    #package = pkgs.librewolf;
    languagePacks = ["en-US" "de"];
    settings = {
      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
      "cookiebanners.service.mode" = 2; # Block cookie banners
      "identity.fxaccounts.enabled" = true;
      "network.cookie.lifetimePolicy" = 0;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting" = false;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "webgl.disabled" = false;
    };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "searx.kbnetcloud.de";
          privateDefault = "searx.kbnetcloud.de";
          order = [
            "searx.kbnetcloud.de"
            "DuckDuckGo NoAI"
            "NixOS Packages"
            "Nixcode"
            "PR-tracker"
          ];
          engines = {
            "searx.kbnetcloud.de" = {
              name = "searx.kbnetcloud.de";
              description = "SearXNG is a metasearch engine that respects your privacy.";
              queryCharset = "UTF-8";
              searchForm = "https://searx.kbnetcloud.de/search";
              urls = [
                {
                  "params" = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                  ];
                  "rels" = ["results"];
                  "template" = "https://searx.kbnetcloud.de/search";
                  "method" = "POST";
                }
                {
                  "params" = [];
                  "rels" = ["suggestions"];
                  "template" = "https://searx.kbnetcloud.de/autocompleter?q={searchTerms}";
                  "type" = "application/x-suggestions+json";
                  "method" = "POST";
                }
              ];
            };
            "Nixcode" = {
              urls = [{template = "https://github.com/search?q=lang%3ANix+{searchTerms}&type=code";}];
              definedAliases = ["nixcode"];
            };
            "PR-tracker" = {
              urls = [{template = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}";}];
              definedAliases = ["pr"];
            };
            "DuckDuckGo NoAI" = {
              urls = [{template = "https://noai.duckduckgo.com/?q={searchTerms}";}];
              definedAliases = ["ddg"];
            };
            "NixOS Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["nix"];
            };
          };
        };
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      ExtensionSettings = {
        "{d867162c-4c38-4c5f-aca4-db6a6592d7da}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-tweaks/latest.xpi";
          installation_mode = "force_installed";
        };
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
  home.sessionVariables = {
    BROWSER = "librewolf";
  };
}
