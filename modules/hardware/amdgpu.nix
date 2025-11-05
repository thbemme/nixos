{pkgs, ...}: {
  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
    # Enable driver support for AMD GPU overclocking
    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  # OpenCL backends - Pocl for CPU, ROCM for iGPU and discrete GPU
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    blender-hip
    corectrl
  ];

  # Corectrl without password
  security.polkit = {
    extraConfig = ''
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.corectrl.helper.init" ||
               action.id == "org.corectrl.helperkiller.init") &&
              subject.local == true &&
              subject.active == true &&
              subject.isInGroup("wheel")) {
                  return polkit.Result.YES;
          }
      });
    '';
  };
}
