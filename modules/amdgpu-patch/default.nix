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
  # Offending commit: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=468034a06a6e8043c5b50f9cd0cac730a6e497b5
  # Reverting patch 1b824eef269db44d068bbc0de74c94a8e8f9ce02 / upstream: f1c6be3999d2be2673a51a9be0caf9348e254e52
  # Workaround will be obsolete once 4.16 hits stable
  boot.extraModulePackages = [
    (amdgpu-kernel-module.overrideAttrs (_: {
      patches = [./amdgpu-revert.patch];
    }))
  ];
}
