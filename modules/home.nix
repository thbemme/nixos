{ inputs, vars, ... }:

{
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/default.nix;
    };
  };

}
