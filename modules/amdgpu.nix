{ config, lib, pkgs, inputs, vars, ... }:

{
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  users.users.${vars.user} = {
    packages = with pkgs; [
      amdgpu_top
      blender-hip
      corectrl
    ];
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
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
