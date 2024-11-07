{ config, lib, pkgs, pkgs-unstable, nix-comfyui, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.nix-comfyui.overlays.default
  ];

  disabledModules = [ "services/misc/ollama.nix" "services/misc/open-webui.nix" ];

  imports =
    [
      "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"
      "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/open-webui.nix"
    ];

  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];
  nix.settings.trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];

  # Ollama
  services.ollama = {
    package = pkgs-unstable.ollama-rocm;
    enable = true;
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    package = pkgs-unstable.open-webui;
    host = "0.0.0.0"; #Point reverse proxy to http://<ip>:8080
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "False";
    };
  };

  environment.systemPackages = (with pkgs; [
    #comfyuiPackages.comfyui-with-extensions
  ]) ++
  (with pkgs-unstable; [
    oterm
  ]);
}
