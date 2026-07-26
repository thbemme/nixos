final: prev: {
  xwayland-satellite = prev.xwayland-satellite.overrideAttrs (
    finalAttrs: _prevAttrs: {
      version = "0.8.2";
      src = prev.fetchFromGitHub {
        owner = "Supreeeme";
        repo = "xwayland-satellite";
        tag = "v${finalAttrs.version}";
        sha256 = "sha256-Mb7jpqnrcYCfNSItIkkHpuR3YxWFxPuIBfcwNKlRBkk=";
      };

      # overrideAttrs works on the mkDerivation, so we cannot override cargoHash.
      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) src;
        hash = "sha256-Saa3SRsQuY6u6pfBGezaEExOt/ReblnrG7pAXjA6Dk8=";
      };
    }
  );
}
