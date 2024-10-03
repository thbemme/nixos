{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];
  nix.settings.trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];

  users.users.user = {
    extraGroups = [ "gamemode" ];
    packages = (with pkgs; [
      piper-tts
    ]) ++
    (with pkgs-unstable; [
      gpt4all
    ]);
  };
}
