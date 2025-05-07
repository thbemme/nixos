{ ... }:

{
  config = {
    environment.etc = {
      "sensors3.conf".text = ''
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
    };
  };
}
