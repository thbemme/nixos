final: prev: {
  xwayland-satellite = prev.xwayland-satellite.overrideAttrs (
    finalAttrs: _prevAttrs: {
      version = "0.8.2";
      src = prev.fetchFromGitHub {
        owner = "Supreeeme";
        repo = "xwayland-satellite";
        rev = "master";
        sha256 = "sha256-28696iIw8uE0ZUyFTtzhEM8xMh85clCYypMxkvUi+sc=";
      };

      # overrideAttrs works on the mkDerivation, so we cannot override cargoHash.
      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) src;
        hash = "sha256-jbEihJYcOwFeDiMYlOtaS8GlunvSze80iWahDj1qDrs=";
      };
    }
  );
}
