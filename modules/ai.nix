{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{

  disabledModules = [ "services/misc/ollama.nix" ];

  imports =
    [
      "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
    ];

  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];
  nix.settings.trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];

  # Ollama
  services.ollama = {
    package = pkgs-unstable.ollama-rocm;
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1031";
    };
    rocmOverrideGfx = "10.3.1";
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    package = pkgs-unstable.open-webui;
    host = "192.168.178.20";
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      #WEBUI_AUTH = "False";
    };
  };

  environment.systemPackages = (with pkgs; [
    piper-tts
    mimic
  ]) ++
  (with pkgs-unstable; [
    oterm
    ollama-rocm
    open-webui
  ]);
}
