_: {
  config = {
    environment.etc = {
      "sensors.d/msib450mpro.conf".text = ''
        chip "nct6795-isa-*"
          ignore in1
          ignore in4
          ignore in5
          ignore in6
          ignore in9
          ignore in10
          ignore in11
          ignore in12
          ignore in13
          ignore in14
          ignore fan1
          ignore fan4
          ignore fan5
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
          label in0 "Vcore"
          label in2 "AVCC"
          label in3 "+3.3V"
          label in7 "3VSB"
          label in8 "Vbat"
          set in2_min  3.3 * 0.90
          set in2_max  3.3 * 1.10
          set in3_min  3.3 * 0.90
          set in3_max  3.3 * 1.10
          set in7_min  3.3 * 0.90
          set in7_max  3.3 * 1.10
          set in8_min  3.0 * 0.90
          set in8_max  3.3 * 1.10
        chip "amdgpu-pci-*"
          label fan1 "GPU Fan"
      '';
    };
  };
}
