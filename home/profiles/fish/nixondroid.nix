_: {
  programs.fish = {
    shellInit = "set -Ux fish_features no-keyboard-protocols";
    shellAliases = {
      r = "nix-on-droid switch -F ~/git/nixos/ $argv";
      c = "nix-collect-garbage -d";
    };
  };
}
