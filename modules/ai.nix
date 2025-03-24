{ pkgs, pkgs-unstable, nix-comfyui, gpuAcceleration, inputs, ... }:

let
  # Determine the Ollama package based on GPU acceleration type
  ollamaPackage =
    if gpuAcceleration == "rocm" then
      pkgs.ollama-rocm
    else
      pkgs.ollama;

  # Configure environment variables dynamically
  ollamaEnvVars =
    if gpuAcceleration == "rocm" then {
      HCC_AMDGPU_TARGET = "gfx1031";
    } else
      { };
in
{

  nixpkgs.overlays = [
    inputs.nix-comfyui.overlays.default
  ];

  # disabledModules = [ "services/misc/ollama.nix" "services/misc/open-webui.nix" ];

  # imports =
  #   [
  #     "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
  #     "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
  #   ];

  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];
  nix.settings.trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];

  # Ollama
  services.ollama = {
    enable = true;
    acceleration = if gpuAcceleration != "none" then gpuAcceleration else false;
    environmentVariables = ollamaEnvVars;
    rocmOverrideGfx = if gpuAcceleration == "rocm" then "10.3.1" else null;
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    #package = pkgs-unstable.open-webui;
    host = "0.0.0.0"; #Point reverse proxy to http://<ip>:8080
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = if gpuAcceleration != "none" then "True" else "False";
      GLOBAL_LOG_LEVEL = "40";
    };
  };

  environment.systemPackages = (with pkgs; [
    mimic
    #comfyuiPackages.rocm.comfyui-with-extensions
    #comfyuiPackages.krita-with-extensions
  ]) ++
  (with pkgs-unstable; [
    oterm
  ]);
}
