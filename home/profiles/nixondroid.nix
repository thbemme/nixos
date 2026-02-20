{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../apps/bat.nix
    ../apps/fastfetch.nix
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ./fish/nixondroid.nix
  ];

  home.stateVersion = "24.05";

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.activation = {
    copyFont = let
      font_src = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFont-Regular.ttf";
      font_dst = "${config.home.homeDirectory}/.termux/font.ttf";
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        ( test ! -e "${font_dst}" || test $(sha1sum "${font_src}"|cut -d' ' -f1 ) != $(sha1sum "${font_dst}" |cut -d' ' -f1)) && $DRY_RUN_CMD install $VERBOSE_ARG -D "${font_src}" "${font_dst}"
      '';
  };
}
