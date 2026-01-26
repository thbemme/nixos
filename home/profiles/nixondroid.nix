{config, lib, pkgs, ...}: {
  imports = [
    ./theme-cli.nix
    ../apps/bat.nix
    ../apps/fish.nix
 #   ../apps/git.nix
    ../apps/neovim.nix
#    ../apps/ssh.nix
    ../profiles/fish/nixondroid.nix
  ];

  home.stateVersion = "24.05";

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.activation = {
    copyFont = let
      font_src = "${pkgs.nerdfonts.override {fonts = ["FiraCode"];}}/share/fonts/truetype/NerdFonts/FiraCodeNerdFont-Regular.ttf";
      font_dst = "${config.home.homeDirectory}/.termux/font.ttf";
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        ( test ! -e "${font_dst}" || test $(sha1sum "${font_src}"|cut -d' ' -f1 ) != $(sha1sum "${font_dst}" |cut -d' ' -f1)) && $DRY_RUN_CMD install $VERBOSE_ARG -D "${font_src}" "${font_dst}"
      '';
  };
}
