{ pkgs, ... }:

{
  # Set G-512 keyboard backlight to BlueViolet
  services.udev = {
    packages = [
      pkgs.g810-led
    ];
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", RUN+="${pkgs.g810-led}/bin/g810-led -a 8a2be2"
    '';
  };

  environment.systemPackages = with pkgs; [
    g810-led
    rivalcfg
  ];
}
