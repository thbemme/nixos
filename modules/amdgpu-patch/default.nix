{
  config,
  pkgs,
  ...
}: let
  amdgpu-kernel-module = pkgs.callPackage ./amdgpu-kernel-module.nix {
    # Make sure the module targets the same kernel as your system is using.
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  # Workaround https://gitlab.freedesktop.org/drm/amd/-/issues?show=eyJpaWQiOiI0MjM4IiwiZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxMzMwODl9
  boot.extraModulePackages = [
    (amdgpu-kernel-module.overrideAttrs (_: {
      patches = [./amdgpu-revert.patch];
    }))
  ];
}
