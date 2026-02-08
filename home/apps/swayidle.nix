{
  config,
  pkgs,
  ...
}: {
  services.swayidle = let
    niri = "${config.programs.niri.package}/bin/niri";
    noctalia-shell = "${config.programs.noctalia-shell.package}/bin/noctalia-shell";
    lock-cmd = "${noctalia-shell} ipc call lockScreen lock";
    monitor-on = "${niri} msg action power-on-monitors";
    monitor-off = "${niri} msg action power-off-monitors";
    lower-brightness = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
    restore-brightness = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    suspend = "${noctalia-shell} ipc call sessionMenu lockAndSuspend";
    systemd-ac-power = "${pkgs.systemd}/bin/systemd-ac-power";
    suspendOnBatt = "${systemd-ac-power} || ${suspend}";
  in {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = lock-cmd;
      }
      {
        event = "after-resume";
        command = monitor-on;
      }
      {
        event = "lock";
        command = lock-cmd;
      }
    ];
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
