{
  config,
  pkgs,
  ...
}: {
  services.swayidle = let
    niri = "${config.programs.niri.package}/bin/niri";
    lock-cmd = "${pkgs.systemd}/bin/loginctl lock-session";
    monitor-on = "${niri} msg action power-on-monitors";
    monitor-off = "${niri} msg action power-off-monitors";
    lower-brightness = "${systemd-ac-power} || ${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
    restore-brightness = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    suspend = "${pkgs.systemd}/bin/systemctl suspend";
    systemd-ac-power = "${pkgs.systemd}/bin/systemd-ac-power";
    suspendOnBatt = "${systemd-ac-power} || ${suspend}";
  in {
    enable = true;
    events = {
      "before-sleep" = "$lock-cmd";
      "after-resume" = "$monitor-on";
      "lock" = "$lock-cmd";
    };
    timeouts = [
      {
        timeout = 60;
        command = lower-brightness;
        resumeCommand = restore-brightness;
      }
      {
        timeout = 300;
        command = monitor-off;
      }
      {
        timeout = 900;
        command = suspendOnBatt;
      }
      {
        timeout = 1800;
        command = lock-cmd;
      }
      {
        timeout = 3600;
        command = suspend;
      }
    ];
  };
}
