{ config, lib, pkgs, inputs, ... }:

{
  users.users.user = {
    packages = with pkgs; [
      gpt4all
      piper-tts
    ];
  };
}
