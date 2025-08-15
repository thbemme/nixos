{
  inputs,
  pkgs,
  pkgs-unstable,
  gpuAcceleration,
  ...
}: let
  ollamaPkg =
    if gpuAcceleration
    then pkgs-unstable.ollama-rocm
    else pkgs-unstable.ollama;

  ollamaAcceleration =
    if gpuAcceleration
    then "rocm"
    else false;

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
  disabledModules = ["services/misc/ollama.nix"];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
  ];

  services.ollama = {
    enable = true;
    package = ollamaPkg;
    acceleration = ollamaAcceleration;
    environmentVariables = ollamaEnv;
    rocmOverrideGfx = ollamaRocmGfx;
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0"; # Point reverse proxy to http://<ip>:8080
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = webuiAuth;
      GLOBAL_LOG_LEVEL = "40";
    };
  };

  environment.systemPackages = with pkgs;
    [
      mimic
    ]
    ++ (with pkgs-unstable; [
      oterm
    ]);
}
