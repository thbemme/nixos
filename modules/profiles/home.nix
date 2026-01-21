{
  inputs,
  vars,
  gpuAcceleration,
  useUnstable,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    backupFileExtension = "hm-back";
    extraSpecialArgs = {inherit inputs vars gpuAcceleration useUnstable;};
    users = {
      "${vars.user}" = import ../../home/profiles/nixos.nix;
    };
  };
}
