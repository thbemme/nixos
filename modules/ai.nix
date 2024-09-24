{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = with pkgs; [
      gpt4all
      piper-tts
    ];
  };
}
