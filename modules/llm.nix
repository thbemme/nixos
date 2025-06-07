{
  inputs,
  pkgs,
  pkgs-unstable,
  gpuAcceleration,
  ...
}: {
  # nixpkgs.overlays = [
  #   inputs.nix-comfyui.overlays.default
  # ];

  # nix.settings.trusted-substituters = ["https://ai.cachix.org"];
  # nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];

  disabledModules = ["services/misc/ollama.nix"];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
  ];

  # Ollama
  services.ollama = {
    enable = true;
    package =
      if gpuAcceleration
      then pkgs-unstable.ollama-rocm
      else pkgs-unstable.ollama;
    acceleration =
      if gpuAcceleration
      then "rocm"
      else false;
    environmentVariables =
      if gpuAcceleration
      then {
        HCC_AMDGPU_TARGET = "gfx1031";
      }
      else {};
    rocmOverrideGfx =
      if gpuAcceleration
      then "10.3.1" # Workaround for RX 6700 XT
      else null;
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0"; #Point reverse proxy to http://<ip>:8080
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH =
        if gpuAcceleration
        then "True"
        else "False"; # Single user w/o GPU
      GLOBAL_LOG_LEVEL = "40";
    };
  };

  environment.systemPackages =
    (with pkgs; [
      mimic
      #comfyuiPackages.rocm.comfyui-with-extensions
      #comfyuiPackages.krita-with-extensions
    ])
    ++ (with pkgs-unstable; [
      oterm
    ]);
}
