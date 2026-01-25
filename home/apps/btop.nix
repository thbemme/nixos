{
  pkgs,
  gpuAcceleration,
  ...
}: let
  isWsl = builtins.getEnv "WSL_DISTRO_NAME" != "";
  btopPackage =
    if gpuAcceleration
    then pkgs.btop-rocm
    else pkgs.btop;
in {
  programs.btop = {
    enable = true;
    package = btopPackage;
    settings =
      {
        theme_background = false;
      }
      // (
        if isWsl
        then {
          use_fstab = false;
          disks_filter = "/";
        }
        else {
          use_fstab = true;
        }
      );
  };
}
