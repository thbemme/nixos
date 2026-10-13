{pkgs, ...}: let
  color = "8a2be2";
in {
  # Set G-512 keyboard backlight to BlueViolet
  services.udev = {
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", RUN+="${pkgs.g810-led}/bin/g810-led -a ${color}"
      ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="1824", TAG+="systemd", ENV{SYSTEMD_WANTS}="rivalcfg.service"
    '';
  };

  systemd.services.rivalcfg = {
    description = "Configure SteelSeries Devices";
    wantedBy = ["multi-user.target"];
    wants = ["systemd-udev-settle.service"];
    after = ["systemd-udev-settle.service"];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      ${pkgs.rivalcfg}/bin/rivalcfg  --z1 ${color} --z2 ${color} --z3 ${color} -c ${color} -s 800 || true
    '';
  };
  environment.systemPackages = with pkgs; [
    g810-led
  ];
}
