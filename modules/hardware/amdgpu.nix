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

  nixpkgs.config.rocmSupport = true;

  # OpenCL backends - Pocl for CPU, ROCM for iGPU and discrete GPU
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];

  services.lact = {
    enable = true;
    settings = {
      version = 5;
      apply_settings_timer = 5;
      current_profile = null;
      auto_switch_profiles = false;

      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };

      gpus = {
        "1002:73DF-1849:5209-0000:2b:00.0" = {
          fan_control_enabled = false;
          performace_level = "auto";
          voltage_offset = -77;
        };
      };
    };
  };
}
