{ config, pkgs, inputs, vars, ... }:

{
  home.file = {
    ".config/fish/config.fish".source = ./dotfiles/default.fish;
  };
}
