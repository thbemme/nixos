{pkgs, ...}: {
  environment.systemPackages = let
    sensors_config = pkgs.writeTextDir "etc/sensors.d/msib450mpro.conf" ''
      chip "nct6795-isa-*"
        ignore fan1
        ignore fan4
        ignore fan5
        ignore in10
        ignore temp4
        ignore temp5
        ignore temp6
        ignore temp8
        ignore temp9
        ignore temp10
        ignore temp11
        ignore temp12
        label fan2 "CPU Fan"
        ignore fan3 #"Case Fan"
      chip "amdgpu-pci-*"
        label fan1 "GPU Fan"
    '';
    sensors = pkgs.symlinkJoin {
      inherit (pkgs.lm_sensors) name;
      paths = [
        pkgs.lm_sensors
        sensors_config
      ];
    };
  in [
    sensors
  ];
}
