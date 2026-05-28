{
  pkgs,
  gpuAcceleration,
  ...
}: let
  ollamaPkg =
    if gpuAcceleration
    then pkgs.ollama-rocm
    else pkgs.ollama-cpu;

  ollamaEnv =
    if gpuAcceleration
    then {HCC_AMDGPU_TARGET = "gfx1031";}
    else {};

  ollamaRocmGfx =
    if gpuAcceleration
    then "10.3.1"
    else null;

  webuiAuth =
    if gpuAcceleration
    then "True"
    else "False";
in {
  # disabledModules = ["services/misc/ollama.nix" "services/misc/open-webui.nix"];

  # imports = [
  #   "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
  #   "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
  # ];

  services.ollama = {
    enable = true;
    package = ollamaPkg;
    environmentVariables = ollamaEnv;
    rocmOverrideGfx = ollamaRocmGfx;
  };

  services.open-webui = {
    enable = true;
    package = pkgs.open-webui;
    openFirewall = true;
    host = "0.0.0.0"; # Point reverse proxy to http://<ip>:8080
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = webuiAuth;
      GLOBAL_LOG_LEVEL = "40";
    };
  };

  environment.systemPackages = [
    pkgs.oterm
    pkgs.piper-tts
  ];
}
