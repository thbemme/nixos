{ inputs, vars, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/default.nix;
    };
  };
}
